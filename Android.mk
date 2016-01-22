LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

incallui_dir := ../InCallUI
contacts_common_dir := ../ContactsCommon
phone_common_dir := ../PhoneCommon
supportdesign_dir := ../../../external/android/support-prebuilt/support-design
appcompat_dir := ../../../external/android/support-prebuilt/appcompat

src_dirs := src \
    $(incallui_dir)/src \
    $(contacts_common_dir)/src \
    $(phone_common_dir)/src \
    $(phone_common_dir)/src-ambient

res_dirs := res \
    $(incallui_dir)/res \
    $(contacts_common_dir)/res \
    $(phone_common_dir)/res \
    $(supportdesign_dir)/res \
    $(appcompat_dir)/res

LOCAL_SRC_FILES := $(call all-java-files-under, $(src_dirs)) $(call all-Iaidl-files-under, $(src_dirs))
LOCAL_SRC_FILES += ../../providers/ContactsProvider/src/com/android/providers/contacts/NameSplitter.java \
                   ../../providers/ContactsProvider/src/com/android/providers/contacts/HanziToPinyin.java \
                   ../../providers/ContactsProvider/src/com/android/providers/contacts/util/NeededForTesting.java
LOCAL_RESOURCE_DIR := $(addprefix $(LOCAL_PATH)/, $(res_dirs)) \
    frameworks/support/v7/cardview/res frameworks/support/v7/recyclerview/res \
    frameworks/support/v7/appcompat/res frameworks/support/design/res
LOCAL_ASSET_DIR += $(LOCAL_PATH)/assets

LOCAL_AAPT_FLAGS := \
    --auto-add-overlay \
    --extra-packages android.support.design \
    --extra-packages android.support.v7.appcompat \
    --extra-packages android.support.v7.cardview \
    --extra-packages android.support.v7.recyclerview \
    --extra-packages android.support.v7.appcompat \
    --extra-packages android.support.design \
    --extra-packages com.android.incallui \
    --extra-packages com.android.contacts.common \
    --extra-packages com.android.phone.common \
    --extra-packages com.cyanogen.ambient

LOCAL_STATIC_JAVA_AAR_LIBRARIES := \
    ambientsdk

LOCAL_JAVA_LIBRARIES := telephony-common
LOCAL_FULL_LIBS_MANIFEST_FILES := $(LOCAL_PATH)/AndroidManifest_cm.xml

LOCAL_STATIC_JAVA_LIBRARIES := \
    android-common \
    android-support-v13 \
    android-support-v4 \
    android-support-v7-appcompat \
    android-support-v7-cardview \
    android-support-v7-recyclerview \
    android-support-design \
    com.android.services.telephony.common \
    com.android.vcard \
    guava \
    libphonenumber \
    org.cyanogenmod.platform.sdk \
    dialernext-android-support-design

LOCAL_PACKAGE_NAME := Dialer
LOCAL_CERTIFICATE := shared
LOCAL_PRIVILEGED_MODULE := true

LOCAL_PROGUARD_FLAG_FILES := proguard.flags $(incallui_dir)/proguard.flags

# Uncomment the following line to build against the current SDK
# This is required for building an unbundled app.
#LOCAL_SDK_VERSION := current

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    dialernext-android-support-design:$(supportdesign_dir)/android-support-design.jar \
    dialernext-android-support-v7-appcompat:$(appcompat_dir)/android-support-v7-appcompat.jar

include $(BUILD_MULTI_PREBUILT)

# Use the following include to make our test apk.
include $(call all-makefiles-under,$(LOCAL_PATH))
