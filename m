Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVDKUL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVDKUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVDKUKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:10:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:11461 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261916AbVDKUJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:09:05 -0400
Date: Mon, 11 Apr 2005 22:11:39 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cifs: md5 cleanup - functions
Message-ID: <Pine.LNX.4.62.0504112209220.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Function names and return types on same line - conform to established 
fs/cifs/ style.

Patch is also available at:
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md5-funct.patch

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm2-orig/fs/cifs/md5.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.12-rc2-mm2/fs/cifs/md5.c	2005-04-09 10:34:47.000000000 +0200
@@ -28,8 +28,7 @@ static void MD5Transform(__u32 buf[4], _
 /*
  * Note: this code is harmless on little-endian machines.
  */
-static void
-byteReverse(unsigned char *buf, unsigned longs)
+static void byteReverse(unsigned char *buf, unsigned longs)
 {
 	__u32 t;
 	do {
@@ -44,8 +43,7 @@ byteReverse(unsigned char *buf, unsigned
  * Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
  * initialization constants.
  */
-void
-MD5Init(struct MD5Context *ctx)
+void MD5Init(struct MD5Context *ctx)
 {
 	ctx->buf[0] = 0x67452301;
 	ctx->buf[1] = 0xefcdab89;
@@ -60,8 +58,7 @@ MD5Init(struct MD5Context *ctx)
  * Update context to reflect the concatenation of another buffer full
  * of bytes.
  */
-void
-MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
+void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
 {
 	register __u32 t;
 
@@ -109,8 +106,7 @@ MD5Update(struct MD5Context *ctx, unsign
  * Final wrapup - pad to 64-byte boundary with the bit pattern 
  * 1 0* (64-bit count of bits processed, MSB-first)
  */
-void
-MD5Final(unsigned char digest[16], struct MD5Context *ctx)
+void MD5Final(unsigned char digest[16], struct MD5Context *ctx)
 {
 	unsigned int count;
 	unsigned char *p;
@@ -168,8 +164,7 @@ MD5Final(unsigned char digest[16], struc
  * reflect the addition of 16 longwords of new data.  MD5Update blocks
  * the data and converts bytes into longwords for this routine.
  */
-static void
-MD5Transform(__u32 buf[4], __u32 const in[16])
+static void MD5Transform(__u32 buf[4], __u32 const in[16])
 {
 	register __u32 a, b, c, d;
 
@@ -255,9 +250,8 @@ MD5Transform(__u32 buf[4], __u32 const i
 /***********************************************************************
  the rfc 2104 version of hmac_md5 initialisation.
 ***********************************************************************/
-void
-hmac_md5_init_rfc2104(unsigned char *key, int key_len,
-		      struct HMACMD5Context *ctx)
+void hmac_md5_init_rfc2104(unsigned char *key, int key_len,
+	struct HMACMD5Context *ctx)
 {
 	int i;
 
@@ -293,9 +287,8 @@ hmac_md5_init_rfc2104(unsigned char *key
 /***********************************************************************
  the microsoft version of hmac_md5 initialisation.
 ***********************************************************************/
-void
-hmac_md5_init_limK_to_64(const unsigned char *key, int key_len,
-			 struct HMACMD5Context *ctx)
+void hmac_md5_init_limK_to_64(const unsigned char *key, int key_len,
+	struct HMACMD5Context *ctx)
 {
 	int i;
 
@@ -323,9 +316,8 @@ hmac_md5_init_limK_to_64(const unsigned 
 /***********************************************************************
  update hmac_md5 "inner" buffer
 ***********************************************************************/
-void
-hmac_md5_update(const unsigned char *text, int text_len,
-		struct HMACMD5Context *ctx)
+void hmac_md5_update(const unsigned char *text, int text_len,
+	struct HMACMD5Context *ctx)
 {
 	MD5Update(&ctx->ctx, text, text_len);	/* then text of datagram */
 }
@@ -333,8 +325,7 @@ hmac_md5_update(const unsigned char *tex
 /***********************************************************************
  finish off hmac_md5 "inner" buffer and generate outer one.
 ***********************************************************************/
-void
-hmac_md5_final(unsigned char *digest, struct HMACMD5Context *ctx)
+void hmac_md5_final(unsigned char *digest, struct HMACMD5Context *ctx)
 {
 	struct MD5Context ctx_o;
 
@@ -350,9 +341,8 @@ hmac_md5_final(unsigned char *digest, st
  single function to calculate an HMAC MD5 digest from data.
  use the microsoft hmacmd5 init method because the key is 16 bytes.
 ************************************************************/
-void
-hmac_md5(unsigned char key[16], unsigned char *data, int data_len,
-	 unsigned char *digest)
+void hmac_md5(unsigned char key[16], unsigned char *data, int data_len,
+	unsigned char *digest)
 {
 	struct HMACMD5Context ctx;
 	hmac_md5_init_limK_to_64(key, 16, &ctx);


