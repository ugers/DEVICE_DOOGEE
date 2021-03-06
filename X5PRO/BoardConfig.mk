TARGET_BOARD_PLATFORM := mt6735m

# Enable non DEODEX build
#WITH_DEXPREOPT := true

# TWRP
RECOVERY_VARIANT := twrp
TWHAVE_SELINUX := false
TW_USE_TOOLBOX := false
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
PRODUCT_COPY_FILES += device/DOOGEE/X5PRO/twrp.fstab:recovery/root/etc/twrp.fstab


# Use the non-open-source part, if present
-include vendor/DOOGEE/X5PRO/BoardConfigVendor.mk

# Use the 6735 common part
include device/mediatek/mt6735/BoardConfig.mk

#Config partition size
-include $(MTK_PTGEN_OUT)/partition_size.mk
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

MTK_INTERNAL_CDEFS := $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$($(t))\"))

COMMON_GLOBAL_CFLAGS += $(MTK_INTERNAL_CDEFS)
COMMON_GLOBAL_CPPFLAGS += $(MTK_INTERNAL_CDEFS)

ifneq ($(MTK_K64_SUPPORT), yes)
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,32N2
else
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,64N2
endif

-include device/mediatek/build/build/tools/base_rule_remake.mk

