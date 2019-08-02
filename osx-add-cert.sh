#!/usr/bin/env bash

KEY_CHAIN=build.keychain

echo $CERTIFICATE_P12 | base64 --decode > cert.p12

security create-keychain -p travis $KEY_CHAIN
# Make the keychain the default so identities are found

security default-keychain -s $KEY_CHAIN

# Unlock the keychain
security unlock-keychain -p travis $KEY_CHAIN

security import cert.p12 -k $KEY_CHAIN -P $CERTIFICATE_PASS -T /usr/bin/codesign;

security set-key-partition-list -S apple-tool:,apple: -s -k travis $KEY_CHAIN

# remove certs
rm -fr cert.p12
