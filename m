Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVCSNYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVCSNYT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVCSNX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:23:59 -0500
Received: from coderock.org ([193.77.147.115]:18312 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262497AbVCSNSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:18:22 -0500
Subject: [patch 3/4] crypto/blowfish.c: fix sparse warnings
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:18:16 +0100
Message-Id: <20050319131816.9EEE51F23D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/blowfish.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN crypto/blowfish.c~sparse-crypto_blowfish crypto/blowfish.c
--- kj/crypto/blowfish.c~sparse-crypto_blowfish	2005-03-18 20:05:36.000000000 +0100
+++ kj-domen/crypto/blowfish.c	2005-03-18 20:05:36.000000000 +0100
@@ -349,8 +349,8 @@ static void encrypt_block(struct bf_ctx 
 
 static void bf_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	const u32 *in_blk = (const u32 *)src;
-	u32 *const out_blk = (u32 *)dst;
+	const __be32 *in_blk = (const __be32 *)src;
+	__be32 *const out_blk = (__be32 *)dst;
 	u32 in32[2], out32[2];
 
 	in32[0] = be32_to_cpu(in_blk[0]);
@@ -362,8 +362,8 @@ static void bf_encrypt(void *ctx, u8 *ds
 
 static void bf_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	const u32 *in_blk = (const u32 *)src;
-	u32 *const out_blk = (u32 *)dst;
+	const __be32 *in_blk = (const __be32 *)src;
+	__be32 *const out_blk = (__be32 *)dst;
 	const u32 *P = ((struct bf_ctx *)ctx)->p;
 	const u32 *S = ((struct bf_ctx *)ctx)->s;
 	u32 yl = be32_to_cpu(in_blk[0]);
_
