Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUK2DRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUK2DRL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 22:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUK2DRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 22:17:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7440 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261618AbUK2DQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 22:16:42 -0500
Date: Mon, 29 Nov 2004 04:16:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jmorris@redhat.com, davem@davemloft.net,
       Jean-Luc Cooke <jlcooke@certainkey.com>,
       Andrew McDonald <andrew@mcdonald.org.uk>,
       Kyle McMartin <kyle@debian.org>, Jean-Francois Dive <jef@linuxbe.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cry[to/ : make some code static
Message-ID: <20041129031636.GS4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 crypto/sha512.c |    2 
 crypto/tcrypt.c |    2 
 crypto/tcrypt.h |  102 ++++++++++++++++++++++++------------------------
 3 files changed, 53 insertions(+), 53 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/crypto/sha512.c.old	2004-11-29 03:33:17.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/crypto/sha512.c	2004-11-29 03:37:57.000000000 +0100
@@ -48,7 +48,7 @@
         return (x >> y) | (x << (64 - y));
 }
 
-const u64 sha512_K[80] = {
+static const u64 sha512_K[80] = {
         0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
         0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
         0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
--- linux-2.6.10-rc2-mm3-full/crypto/tcrypt.h.old	2004-11-29 03:38:22.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/crypto/tcrypt.h	2004-11-29 03:45:06.000000000 +0100
@@ -63,7 +63,7 @@
  */
 #define MD4_TEST_VECTORS	7
 
-struct hash_testvec md4_tv_template [] = {
+static struct hash_testvec md4_tv_template [] = {
 	{
 		.plaintext = "",
 		.digest	= { 0x31, 0xd6, 0xcf, 0xe0, 0xd1, 0x6a, 0xe9, 0x31,
@@ -109,7 +109,7 @@
  */
 #define MD5_TEST_VECTORS	7
 
-struct hash_testvec md5_tv_template[] = {
+static struct hash_testvec md5_tv_template[] = {
 	{
 		.digest	= { 0xd4, 0x1d, 0x8c, 0xd9, 0x8f, 0x00, 0xb2, 0x04,
 			    0xe9, 0x80, 0x09, 0x98, 0xec, 0xf8, 0x42, 0x7e },
@@ -154,7 +154,7 @@
  */
 #define SHA1_TEST_VECTORS	2
 
-struct hash_testvec sha1_tv_template[] = {
+static struct hash_testvec sha1_tv_template[] = {
 	{ 
 		.plaintext = "abc",
 		.psize	= 3,
@@ -175,7 +175,7 @@
  */
 #define SHA256_TEST_VECTORS	2
 
-struct hash_testvec sha256_tv_template[] = {	
+static struct hash_testvec sha256_tv_template[] = {	
 	{ 
 		.plaintext = "abc",
 		.psize	= 3,
@@ -200,7 +200,7 @@
  */
 #define SHA384_TEST_VECTORS	4
 
-struct hash_testvec sha384_tv_template[] = {
+static struct hash_testvec sha384_tv_template[] = {
 	{ 
 		.plaintext= "abc",
 		.psize	= 3,
@@ -249,7 +249,7 @@
  */
 #define SHA512_TEST_VECTORS	4
 
-struct hash_testvec sha512_tv_template[] = {
+static struct hash_testvec sha512_tv_template[] = {
 	{ 
 		.plaintext = "abc",
 		.psize	= 3,
@@ -309,7 +309,7 @@
  */
 #define WP512_TEST_VECTORS	8
 
-struct hash_testvec wp512_tv_template[] = {
+static struct hash_testvec wp512_tv_template[] = {
 	{ 
 		.plaintext = "",
 		.psize	= 0,
@@ -407,7 +407,7 @@
 
 #define WP384_TEST_VECTORS	8
 
-struct hash_testvec wp384_tv_template[] = {
+static struct hash_testvec wp384_tv_template[] = {
 	{ 
 		.plaintext = "",
 		.psize	= 0,
@@ -489,7 +489,7 @@
 
 #define WP256_TEST_VECTORS	8
 
-struct hash_testvec wp256_tv_template[] = {
+static struct hash_testvec wp256_tv_template[] = {
 	{ 
 		.plaintext = "",
 		.psize	= 0,
@@ -561,7 +561,7 @@
  */
 #define HMAC_MD5_TEST_VECTORS	7
 
-struct hmac_testvec hmac_md5_tv_template[] =
+static struct hmac_testvec hmac_md5_tv_template[] =
 {	
 	{
 		.key	= { [0 ... 15] =  0x0b },
@@ -625,7 +625,7 @@
  */
 #define HMAC_SHA1_TEST_VECTORS	7
 
-struct hmac_testvec hmac_sha1_tv_template[] = {	
+static struct hmac_testvec hmac_sha1_tv_template[] = {	
 	{
 		.key	= { [0 ... 19] = 0x0b },
 		.ksize	= 20,
@@ -690,7 +690,7 @@
  */
 #define HMAC_SHA256_TEST_VECTORS	10
 
-struct hmac_testvec hmac_sha256_tv_template[] = {
+static struct hmac_testvec hmac_sha256_tv_template[] = {
 	{
 		.key	= { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			    0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
@@ -813,7 +813,7 @@
 #define DES3_EDE_ENC_TEST_VECTORS	3
 #define DES3_EDE_DEC_TEST_VECTORS	3
 
-struct cipher_testvec des_enc_tv_template[] = {
+static struct cipher_testvec des_enc_tv_template[] = {
 	{ /* From Applied Cryptography */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef },
 		.klen	= 8,
@@ -917,7 +917,7 @@
 	},
 };
 
-struct cipher_testvec des_dec_tv_template[] = {
+static struct cipher_testvec des_dec_tv_template[] = {
 	{ /* From Applied Cryptography */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef },
 		.klen	= 8,
@@ -957,7 +957,7 @@
 	},
 };
 
-struct cipher_testvec des_cbc_enc_tv_template[] = {
+static struct cipher_testvec des_cbc_enc_tv_template[] = {
 	{ /* From OpenSSL */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef},
 		.klen	= 8,
@@ -1012,7 +1012,7 @@
 	},
 };
 
-struct cipher_testvec des_cbc_dec_tv_template[] = {
+static struct cipher_testvec des_cbc_dec_tv_template[] = {
 	{ /* FIPS Pub 81 */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef },
 		.klen	= 8,
@@ -1053,7 +1053,7 @@
 /*
  * We really need some more test vectors, especially for DES3 CBC.
  */
-struct cipher_testvec des3_ede_enc_tv_template[] = {
+static struct cipher_testvec des3_ede_enc_tv_template[] = {
 	{ /* These are from openssl */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
 			    0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
@@ -1084,7 +1084,7 @@
 	},
 };
 
-struct cipher_testvec des3_ede_dec_tv_template[] = {
+static struct cipher_testvec des3_ede_dec_tv_template[] = {
 	{ /* These are from openssl */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
 			    0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
@@ -1123,7 +1123,7 @@
 #define BF_CBC_ENC_TEST_VECTORS	1
 #define BF_CBC_DEC_TEST_VECTORS	1
 
-struct cipher_testvec bf_enc_tv_template[] = {
+static struct cipher_testvec bf_enc_tv_template[] = {
 	{ /* DES test vectors from OpenSSL */
 		.key	= { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },
 		.klen	= 8,
@@ -1178,7 +1178,7 @@
 	},
 };
 
-struct cipher_testvec bf_dec_tv_template[] = {
+static struct cipher_testvec bf_dec_tv_template[] = {
 	{ /* DES test vectors from OpenSSL */
 		.key	= { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
 		.klen	= 8,
@@ -1233,7 +1233,7 @@
 	},
 };
 
-struct cipher_testvec bf_cbc_enc_tv_template[] = {
+static struct cipher_testvec bf_cbc_enc_tv_template[] = {
 	{ /* From OpenSSL */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
 			    0xf0, 0xe1, 0xd2, 0xc3, 0xb4, 0xa5, 0x96, 0x87 },
@@ -1252,7 +1252,7 @@
 	},
 };
 
-struct cipher_testvec bf_cbc_dec_tv_template[] = {
+static struct cipher_testvec bf_cbc_dec_tv_template[] = {
 	{ /* From OpenSSL */
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
 			    0xf0, 0xe1, 0xd2, 0xc3, 0xb4, 0xa5, 0x96, 0x87 },
@@ -1279,7 +1279,7 @@
 #define TF_CBC_ENC_TEST_VECTORS		4
 #define TF_CBC_DEC_TEST_VECTORS		4
 
-struct cipher_testvec tf_enc_tv_template[] = {
+static struct cipher_testvec tf_enc_tv_template[] = {
 	{
 		.key	= { [0 ... 15] = 0x00 },
 		.klen	= 16,
@@ -1312,7 +1312,7 @@
 	},
 };
 
-struct cipher_testvec tf_dec_tv_template[] = {
+static struct cipher_testvec tf_dec_tv_template[] = {
 	{
 		.key	= { [0 ... 15] = 0x00 },
 		.klen	= 16,
@@ -1345,7 +1345,7 @@
 	},
 };
 
-struct cipher_testvec tf_cbc_enc_tv_template[] = {
+static struct cipher_testvec tf_cbc_enc_tv_template[] = {
 	{ /* Generated with Nettle */
 		.key	= { [0 ... 15] = 0x00 },
 		.klen	= 16,
@@ -1391,7 +1391,7 @@
 	},
 };
 
-struct cipher_testvec tf_cbc_dec_tv_template[] = {
+static struct cipher_testvec tf_cbc_dec_tv_template[] = {
 	{ /* Reverse of the first four above */
 		.key	= { [0 ... 15] = 0x00 },
 		.klen	= 16,
@@ -1447,7 +1447,7 @@
 #define TNEPRES_ENC_TEST_VECTORS	4
 #define TNEPRES_DEC_TEST_VECTORS	4
 
-struct cipher_testvec serpent_enc_tv_template[] = 
+static struct cipher_testvec serpent_enc_tv_template[] = 
 {
 	{
 		.input	= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
@@ -1489,7 +1489,7 @@
 	},
 };
 
-struct cipher_testvec tnepres_enc_tv_template[] = 
+static struct cipher_testvec tnepres_enc_tv_template[] = 
 {
 	{ /* KeySize=128, PT=0, I=1 */
 		.input	= { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -1540,7 +1540,7 @@
 };
 
 
-struct cipher_testvec serpent_dec_tv_template[] = 
+static struct cipher_testvec serpent_dec_tv_template[] = 
 {
 	{
 		.input	= { 0x12, 0x07, 0xfc, 0xce, 0x9b, 0xd0, 0xd6, 0x47,
@@ -1582,7 +1582,7 @@
 	},
 };
 
-struct cipher_testvec tnepres_dec_tv_template[] =
+static struct cipher_testvec tnepres_dec_tv_template[] =
 {
 	{
 		.input	= { 0x41, 0xcc, 0x6b, 0x31, 0x59, 0x31, 0x45, 0x97,
@@ -1629,7 +1629,7 @@
 #define CAST6_ENC_TEST_VECTORS	3
 #define CAST6_DEC_TEST_VECTORS  3
 
-struct cipher_testvec cast6_enc_tv_template[] = 
+static struct cipher_testvec cast6_enc_tv_template[] = 
 {
 	{
 		.key	= { 0x23, 0x42, 0xbb, 0x9e, 0xfa, 0x38, 0x54, 0x2c, 
@@ -1664,7 +1664,7 @@
 	},
 };
 
-struct cipher_testvec cast6_dec_tv_template[] = 
+static struct cipher_testvec cast6_dec_tv_template[] = 
 {
 	{
 		.key	= { 0x23, 0x42, 0xbb, 0x9e, 0xfa, 0x38, 0x54, 0x2c, 
@@ -1706,7 +1706,7 @@
 #define AES_ENC_TEST_VECTORS 3
 #define AES_DEC_TEST_VECTORS 3
 
-struct cipher_testvec aes_enc_tv_template[] = { 
+static struct cipher_testvec aes_enc_tv_template[] = { 
 	{ /* From FIPS-197 */
 		.key	= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
 			    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f },
@@ -1743,7 +1743,7 @@
 	},
 };
 
-struct cipher_testvec aes_dec_tv_template[] = { 
+static struct cipher_testvec aes_dec_tv_template[] = { 
 	{ /* From FIPS-197 */
 		.key	= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
 			    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f },
@@ -1784,7 +1784,7 @@
 #define CAST5_ENC_TEST_VECTORS	3
 #define CAST5_DEC_TEST_VECTORS	3
 
-struct cipher_testvec cast5_enc_tv_template[] =
+static struct cipher_testvec cast5_enc_tv_template[] =
 {
 	{
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x12, 0x34, 0x56, 0x78,
@@ -1812,7 +1812,7 @@
 	},
 };
 
-struct cipher_testvec cast5_dec_tv_template[] =
+static struct cipher_testvec cast5_dec_tv_template[] =
 {
 	{
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x12, 0x34, 0x56, 0x78,
@@ -1846,7 +1846,7 @@
 #define ARC4_ENC_TEST_VECTORS	7
 #define ARC4_DEC_TEST_VECTORS	7
 
-struct cipher_testvec arc4_enc_tv_template[] =
+static struct cipher_testvec arc4_enc_tv_template[] =
 {
 	{
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef },
@@ -1913,7 +1913,7 @@
 	},
 };
 
-struct cipher_testvec arc4_dec_tv_template[] =
+static struct cipher_testvec arc4_dec_tv_template[] =
 {
 	{
 		.key	= { 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef },
@@ -1986,7 +1986,7 @@
 #define TEA_ENC_TEST_VECTORS	4
 #define TEA_DEC_TEST_VECTORS	4
 
-struct cipher_testvec tea_enc_tv_template[] =
+static struct cipher_testvec xtea_enc_tv_template[] =
 {
 	{
 		.key    = { [0 ... 15] = 0x00 },
@@ -2030,7 +2030,7 @@
 	}
 };
 
-struct cipher_testvec tea_dec_tv_template[] =
+static struct cipher_testvec tea_dec_tv_template[] =
 {
 	{
 		.key    = { [0 ... 15] = 0x00 },
@@ -2080,7 +2080,7 @@
 #define XTEA_ENC_TEST_VECTORS	4
 #define XTEA_DEC_TEST_VECTORS	4
 
-struct cipher_testvec xtea_enc_tv_template[] =
+static struct cipher_testvec tea_enc_tv_template[] =
 {
 	{
 		.key    = { [0 ... 15] = 0x00 },
@@ -2124,7 +2124,7 @@
 	}
 };
 
-struct cipher_testvec xtea_dec_tv_template[] =
+static struct cipher_testvec xtea_dec_tv_template[] =
 {
 	{
 		.key    = { [0 ... 15] = 0x00 },
@@ -2174,7 +2174,7 @@
 #define KHAZAD_ENC_TEST_VECTORS 5
 #define KHAZAD_DEC_TEST_VECTORS 5
 
-struct cipher_testvec khazad_enc_tv_template[] = { 
+static struct cipher_testvec khazad_enc_tv_template[] = { 
 	{ 
 		.key	= { 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
 			    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
@@ -2220,7 +2220,7 @@
 	},
 };
 
-struct cipher_testvec khazad_dec_tv_template[] = { 
+static struct cipher_testvec khazad_dec_tv_template[] = { 
 	{
 		.key	= { 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
 			    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
@@ -2275,7 +2275,7 @@
 #define ANUBIS_CBC_ENC_TEST_VECTORS		2
 #define ANUBIS_CBC_DEC_TEST_VECTORS		2
 
-struct cipher_testvec anubis_enc_tv_template[] = {
+static struct cipher_testvec anubis_enc_tv_template[] = {
 	{
 		.key	= { 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe,
 			    0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe },
@@ -2338,7 +2338,7 @@
 	},
 };
 
-struct cipher_testvec anubis_dec_tv_template[] = {
+static struct cipher_testvec anubis_dec_tv_template[] = {
 	{
 		.key	= { 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe,
 			    0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe },
@@ -2401,7 +2401,7 @@
 	},
 };
 
-struct cipher_testvec anubis_cbc_enc_tv_template[] = {
+static struct cipher_testvec anubis_cbc_enc_tv_template[] = {
 	{
 		.key	= { 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe,
 			    0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe },
@@ -2436,7 +2436,7 @@
 	},
 };
 
-struct cipher_testvec anubis_cbc_dec_tv_template[] = {
+static struct cipher_testvec anubis_cbc_dec_tv_template[] = {
 	{
 		.key	= { 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe,
 			    0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe, 0xfe },
@@ -2489,7 +2489,7 @@
 #define DEFLATE_COMP_TEST_VECTORS 2
 #define DEFLATE_DECOMP_TEST_VECTORS 2
 
-struct comp_testvec deflate_comp_tv_template[] = {
+static struct comp_testvec deflate_comp_tv_template[] = {
 	{
 		.inlen	= 70,
 		.outlen	= 38,
@@ -2525,7 +2525,7 @@
 	},
 };
 
-struct comp_testvec deflate_decomp_tv_template[] = {
+static struct comp_testvec deflate_decomp_tv_template[] = {
 	{
 		.inlen	= 122,
 		.outlen	= 191,
@@ -2566,7 +2566,7 @@
  */
 #define MICHAEL_MIC_TEST_VECTORS 6
 
-struct hash_testvec michael_mic_tv_template[] =
+static struct hash_testvec michael_mic_tv_template[] =
 {
 	{
 		.key = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
--- linux-2.6.10-rc2-mm3-full/crypto/tcrypt.c.old	2004-11-29 03:38:51.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/crypto/tcrypt.c	2004-11-29 03:39:06.000000000 +0100
@@ -255,7 +255,7 @@
 
 #endif	/* CONFIG_CRYPTO_HMAC */
 
-void
+static void
 test_cipher(char * algo, int mode, int enc, struct cipher_testvec * template, unsigned int tcount)
 {
 	unsigned int ret, i, j, k, temp;

