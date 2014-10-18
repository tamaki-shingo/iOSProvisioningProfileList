TMP_DIR="ProvisioningPlists"
PROVISIONING_PROFILE_LIST=`find ~/Library/MobileDevice/Provisioning\ Profiles/ -name "*.mobileprovision"`;

IFS='

'
array=($PROVISIONING_PROFILE_LIST)

rm -rf /tmp/${TMP_DIR}/

if [ ! -d /tmp/${TMP_DIR} ]; then
    mkdir "/tmp/${TMP_DIR}"
fi

for i in "${array[@]}"
do
  PROVISION_NAME=`basename ${i}`
  PLIST_NAME=`basename ${i} | sed -e "s/mobileprovision/plist/g"`
  security cms -D -i ${i} > /tmp/${TMP_DIR}/${PLIST_NAME}
  echo ${PROVISION_NAME} - `/usr/libexec/PlistBuddy -c 'Print Name' /tmp/${TMP_DIR}/${PLIST_NAME}`
done

rm -rf /tmp/${TMP_DIR}/
