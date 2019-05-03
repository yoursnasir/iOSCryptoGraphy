//
//  ViewController.m
//  RSAUtil
//
//  Created by ideawu on 7/14/15.
//  Copyright (c) 2015 ideawu. All rights reserved.
//

#import "ViewController.h"
#import "RSA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];


    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHk+nUH5bgPu4V/vgwFGfcb4dI1Q+OtZjUlhZH6F7lv6HLgVnG8SIpSquoxSkrYVI/tH6E4yawOk0uxeoH/BQtQ6HseJvajyEexto0L21VrLo+XfNDLfhxauYVvzcq5Sn1uDOAlq0WQRHmUR63vZ94FjhWuOV1xFjzo2P7PNLj3wIDAQAB\n-----END PUBLIC KEY-----";
    NSString *encryptedTextString = @"1UDH6MhJLAybkdUy1ycfIA==";
    NSString *encryptedSecretKeyString = @"wd5ujRgamDAUWmqsmpbRH2Jv2mdE+zNKxhLPT8NLlsdI2/5UZGGo2p02qcqm+lB3e+Ty4vuc8fpjEaPgE2ZAdP6SDj4LGRVme1HGFU2+myXgKpoBGpQstElo5b+HjgCml6LK7hEQZPd1+9iHQYD6TdmDxNFlOwYal9hotcQM5KY=";
    
    NSString *privkey =@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMeT6dQfluA+7hX++DAUZ9xvh0jVD461mNSWFkfoXuW/ocuBWcbxIilKq6jFKSthUj+0foTjJrA6TS7F6gf8FC1Doex4m9qPIR7G2jQvbVWsuj5d80Mt+HFq5hW/NyrlKfW4M4CWrRZBEeZRHre9n3gWOFa45XXEWPOjY/s80uPfAgMBAAECgYAM0IKDDEQzwdansudcrvK8RKz7EDMfhql5fOmRVGpDdjp9RqDtFS6MWC8NdxtdnbIaRQyam7swNY4fIrYULSteX54l8J4tvOBZ0h8NA1VN6Xm5CwBGMVfH85coYo9eCvXghPa+R9EJMJtfXJtgIlexT1k6QMJdsr7L2YuOtAtugQJBAOnWrjP+T68M68G6led3B+0cu6hB90i+hJQBvLxGLY9Qqm66EWKLkZD0+n5s1jJYEnF+y3uuV78iZAGR9aSPRAsCQQDafgH+R/wWtGZ1fxAFoYslWyrRWpe4kuk6OzlFohva9sVGHMP5xPxQcZuFJPBInNUnfZVWup4yM7n0G39KwA/9AkEA0CqjLfoJKcaQ4geeh035qmXX0PPYldO05qWdROYcjOa8spHGBDpHPgo4LO/qxyqMUKkVsGcGCkstSBCN4w7+/QJAQccBrp3ZRLSWy/SuzCMwEtT5dQGC/6wqzr8ZpN8C58624T6zuTQWidlJ6rGOLS4Z9cOW+/8+tPphlx3YGpbruQJAY4AQFj9s8x1Y2hvE/XARs7KxQ/IWTs+lJynqK+JSorV9F/txPWb6DH9gNiWjGDPaDHJmu4xYMIuZl3ysaOFlnw==";

	NSString *originString = @"hello world!";
	for(int i=0; i<4; i++){
		originString = [originString stringByAppendingFormat:@" %@", originString];
	}
	NSString *encWithPubKey;
	NSString *decWithPrivKey;
	NSString *encWithPrivKey;
	NSString *decWithPublicKey;
	
	NSLog(@"Original string(%d): %@", (int)originString.length, originString);
	
	// Demo: encrypt with public key
	encWithPubKey = [RSA encryptString:originString publicKey:pubkey];
	NSLog(@"Enctypted with public key: %@", encWithPubKey);
	// Demo: decrypt with private key
    //NSData *decodedPrivateKey = [[NSData alloc] initWithBase64EncodedString:privkey options:0];
    //NSString *decodedStringpk = [[NSString alloc] initWithData:decodedPrivateKey encoding:NSUTF8StringEncoding];
    //[[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* decodedPrivateKey = [privkey dataUsingEncoding:NSUTF8StringEncoding];
    NSString *decodedStringpk = [[NSString alloc] initWithData:decodedPrivateKey encoding:NSUTF8StringEncoding];
    
    NSData*  encodedSecKeyvalue =[[NSData alloc] initWithBase64EncodedString:encryptedSecretKeyString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodedStringSecKey = [[NSString alloc] initWithData:encodedSecKeyvalue encoding:NSUTF8StringEncoding];
    decWithPrivKey = [RSA decryptString:encryptedSecretKeyString privateKey:decodedStringpk];
    
    
     NSData*  encodedcypherText =[[NSData alloc] initWithBase64EncodedString:encryptedTextString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSLog(@"%@", decodedPrivateKey);
    
    NSLog(@" RSA Secret key %@", decodedPrivateKey);
    // Generate key pair
    
    NSData* tag = [@"com.example.keys.mykey" dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* attributes =
    @{ (id)kSecAttrKeyType:               (id)kSecAttrKeyTypeRSA,
       (id)kSecAttrKeySizeInBits:         @2048,
       (id)kSecPrivateKeyAttrs:
           @{ (id)kSecAttrIsPermanent:    @YES,
              (id)kSecAttrApplicationTag: tag,
              },
       };
    
    CFErrorRef errorpk = NULL;
    SecKeyRef privateKey = SecKeyCreateRandomKey((__bridge CFDictionaryRef)attributes,
                                                 &errorpk);
    if (!privateKey) {
        NSError *err = CFBridgingRelease(errorpk);  // ARC takes ownership
        // Handle the error. . .
    }
    
    
    
    // 1. Get private key
    // Load from NSData and import private key
    OSStatus securityError;
    //securityError = SecPKCS12Import((CFDataRef) decodedPrivateKey, (CFDictionaryRef)secImportOptions, &secImportItems);
   // SecKeyAlgorithm algorithm =
    NSDictionary* options = @{(id)kSecAttrKeyType: (id)kSecAttrKeyType,
                              (id)kSecAttrKeyClass: (id)kSecAttrKeyClassSymmetric,
                              (id)kSecAttrKeySizeInBits: @128,
                              };
    CFErrorRef error = NULL;
   // SecKeyRef privateKeyRef = SecKeyCreateWithData((__bridge CFDataRef)decodedPrivateKey,
     //                                    (__bridge CFDictionaryRef)options,
      //                                   &error);
    SecKeyRef privateKeyRef =  [RSA GeneratePrivateKey: privkey];
    
    NSLog(@"%@", privateKeyRef); // foo
    SecKeyAlgorithm algorithm = kSecKeyAlgorithmRSAEncryptionPKCS1;
    decWithPrivKey = [RSA decryptString:encryptedSecretKeyString privateKey:decodedStringpk];
    
    BOOL canDecrypt = SecKeyIsAlgorithmSupported(privateKeyRef,
                                                 kSecKeyOperationTypeDecrypt,
                                                 algorithm);
    canDecrypt &= ([encodedSecKeyvalue length] == SecKeyGetBlockSize(privateKeyRef));
    
    // 2. Decrypt encrypted secret key using private key
    NSData* clearText = nil;
    if (canDecrypt) {
        CFErrorRef error = NULL;
        clearText = (NSData*)CFBridgingRelease(       // ARC takes ownership
                                               SecKeyCreateDecryptedData(privateKeyRef,
                                                                         algorithm,
                                                                         (__bridge CFDataRef)encodedSecKeyvalue,
                                                                         &error));
        if (!clearText) {
            NSError *err = CFBridgingRelease(error);  // ARC takes ownership
            // Handle the error. . .
        }
    }
    
   // 2. Decrypt  cyphertext using secret key using private key
    
    //NSData *secretKeydata  = [RSA decryptSecretKeyString:encryptedSecretKeyString privateKey:privkey];
	//NSLog(@"Decrypted with private key: %@", secretKeydata);
    //algorithm =kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM;
    //SecKeyRef secKeyRef = SecKeyCreateWithData((__bridge CFDataRef)clearText,
     //                                  (__bridge CFDictionaryRef)options,
       //                                &error);
    //NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    //NSData *plainData = [secretKeydata AES256DecryptWithKey:key];
    
    //NSString *plainString = [[NSString alloc] initWithData:secretKeydata encoding:NSUTF8StringEncoding];
    NSString *plainString = [[NSString alloc] initWithData:clearText encoding:NSUTF8StringEncoding];
    SecKeyRef secKeyRef =  [RSA GenerateSecretKey: clearText];
    BOOL canDecryptSec = SecKeyIsAlgorithmSupported(secKeyRef,
                                                 kSecKeyOperationTypeDecrypt,
                                                 algorithm);
    canDecryptSec &= ([encodedSecKeyvalue length] == SecKeyGetBlockSize(secKeyRef));
    
    size_t plainBufferSize = SecKeyGetBlockSize(secKeyRef);
    uint8_t *plainBuffer = malloc(plainBufferSize);
    uint8_t *challengeBuffer = (uint8_t*)[encodedcypherText bytes];
    size_t cipherBufferSize = strlen((char *)challengeBuffer);
    NSLog(@"decryptWithSecretKey: length of input: %lu", cipherBufferSize);
    OSStatus status = noErr;
    //  Error handling
    //OAEPWithSHA1AndMGF1Padding
    status = SecKeyDecrypt(secKeyRef,
                           kSecPaddingPKCS1,
                           challengeBuffer,
                           cipherBufferSize,
                           &plainBuffer[0],
                           &plainBufferSize
                           );
    NSLog(@"decryption result code: %d (size: %lu)", (int)status, plainBufferSize);
    NSLog(@"FINAL decrypted text: %s", plainBuffer);
    
	// by PHP
	encWithPubKey = @"CKiZsP8wfKlELNfWNC2G4iLv0RtwmGeHgzHec6aor4HnuOMcYVkxRovNj2r0Iu3ybPxKwiH2EswgBWsi65FOzQJa01uDVcJImU5vLrx1ihJ/PADUVxAMFjVzA3+Clbr2fwyJXW6dbbbymupYpkxRSfF5Gq9KyT+tsAhiSNfU6akgNGh4DENoA2AoKoWhpMEawyIubBSsTdFXtsHK0Ze0Cyde7oI2oh8ePOVHRuce6xYELYzmZY5yhSUoEb4+/44fbVouOCTl66ppUgnR5KjmIvBVEJLBq0SgoZfrGiA3cB08q4hb5EJRW72yPPQNqJxcQTPs8SxXa9js8ZryeSxyrw==";
	decWithPrivKey = [RSA decryptString:encryptedSecretKeyString privateKey:privkey];
	NSLog(@"(PHP enc)Decrypted with private key: %@", decWithPrivKey);
	
	// Demo: encrypt with private key
	encWithPrivKey = [RSA encryptString:originString privateKey:privkey];
	NSLog(@"Enctypted with private key: %@", encWithPrivKey);

	// Demo: decrypt with public key
	decWithPublicKey = [RSA decryptString:encWithPrivKey publicKey:pubkey];
	NSLog(@"(PHP enc)Decrypted with public key: %@", decWithPublicKey);
}

@end
