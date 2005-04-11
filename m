Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVDKUOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVDKUOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVDKUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:12:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:26821 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261916AbVDKULu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:11:50 -0400
Date: Mon, 11 Apr 2005 22:14:28 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cifs: md5 cleanup - spaces
Message-ID: <Pine.LNX.4.62.0504112211450.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


clean up spacing, redundant blank lines etc. 

patch is also at:
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md5-spaces.patch

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm2/fs/cifs/md5.c.with_patch1	2005-04-09 10:36:44.000000000 +0200
+++ linux-2.6.12-rc2-mm2/fs/cifs/md5.c	2005-04-09 10:40:44.000000000 +0200
@@ -72,9 +72,8 @@ void MD5Update(struct MD5Context *ctx, u
 	t = (t >> 3) & 0x3f;	/* Bytes already in shsInfo->data */
 
 	/* Handle any leading odd-sized chunks */
-
 	if (t) {
-		unsigned char *p = (unsigned char *) ctx->in + t;
+		unsigned char *p = (unsigned char *)ctx->in + t;
 
 		t = 64 - t;
 		if (len < t) {
@@ -83,22 +82,20 @@ void MD5Update(struct MD5Context *ctx, u
 		}
 		memmove(p, buf, t);
 		byteReverse(ctx->in, 16);
-		MD5Transform(ctx->buf, (__u32 *) ctx->in);
+		MD5Transform(ctx->buf, (__u32 *)ctx->in);
 		buf += t;
 		len -= t;
 	}
 	/* Process data in 64-byte chunks */
-
 	while (len >= 64) {
 		memmove(ctx->in, buf, 64);
 		byteReverse(ctx->in, 16);
-		MD5Transform(ctx->buf, (__u32 *) ctx->in);
+		MD5Transform(ctx->buf, (__u32 *)ctx->in);
 		buf += 64;
 		len -= 64;
 	}
 
 	/* Handle any remaining bytes of data. */
-
 	memmove(ctx->in, buf, len);
 }
 
@@ -127,7 +124,7 @@ void MD5Final(unsigned char digest[16], 
 		/* Two lots of padding:  Pad the first block to 64 bytes */
 		memset(p, 0, count);
 		byteReverse(ctx->in, 16);
-		MD5Transform(ctx->buf, (__u32 *) ctx->in);
+		MD5Transform(ctx->buf, (__u32 *)ctx->in);
 
 		/* Now fill the next block with 56 bytes */
 		memset(ctx->in, 0, 56);
@@ -138,11 +135,11 @@ void MD5Final(unsigned char digest[16], 
 	byteReverse(ctx->in, 14);
 
 	/* Append length in bits and transform */
-	((__u32 *) ctx->in)[14] = ctx->bits[0];
-	((__u32 *) ctx->in)[15] = ctx->bits[1];
+	((__u32 *)ctx->in)[14] = ctx->bits[0];
+	((__u32 *)ctx->in)[15] = ctx->bits[1];
 
 	MD5Transform(ctx->buf, (__u32 *) ctx->in);
-	byteReverse((unsigned char *) ctx->buf, 4);
+	byteReverse((unsigned char *)ctx->buf, 4);
 	memmove(digest, ctx->buf, 16);
 	memset(ctx, 0, sizeof(*ctx));	/* In case it's sensitive */
 }
@@ -269,8 +266,8 @@ void hmac_md5_init_rfc2104(unsigned char
 	}
 
 	/* start out by storing key in pads */
-	memset(ctx->k_ipad, 0, sizeof (ctx->k_ipad));
-	memset(ctx->k_opad, 0, sizeof (ctx->k_opad));
+	memset(ctx->k_ipad, 0, sizeof(ctx->k_ipad));
+	memset(ctx->k_opad, 0, sizeof(ctx->k_opad));
 	memcpy(ctx->k_ipad, key, key_len);
 	memcpy(ctx->k_opad, key, key_len);
 
@@ -298,8 +295,8 @@ void hmac_md5_init_limK_to_64(const unsi
 	}
 
 	/* start out by storing key in pads */
-	memset(ctx->k_ipad, 0, sizeof (ctx->k_ipad));
-	memset(ctx->k_opad, 0, sizeof (ctx->k_opad));
+	memset(ctx->k_ipad, 0, sizeof(ctx->k_ipad));
+	memset(ctx->k_opad, 0, sizeof(ctx->k_opad));
 	memcpy(ctx->k_ipad, key, key_len);
 	memcpy(ctx->k_opad, key, key_len);
 


