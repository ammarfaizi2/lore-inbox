Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVCTLZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVCTLZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVCTLXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:23:48 -0500
Received: from coderock.org ([193.77.147.115]:43147 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262135AbVCTLUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:20:50 -0500
Date: Sun, 20 Mar 2005 12:20:42 +0100
From: Domen Puncer <domen@coderock.org>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 3/4 with proper signed-off] crypto/blowfish.c: fix sparse warnings
Message-ID: <20050320112042.GJ14273@nd47.coderock.org>
References: <20050319131816.9EEE51F23D@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131816.9EEE51F23D@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/blowfish.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN crypto/blowfish.c~sparse-crypto_blowfish crypto/blowfish.c
--- kj/crypto/blowfish.c~sparse-crypto_blowfish	2005-03-20 12:11:35.000000000 +0100
+++ kj-domen/crypto/blowfish.c	2005-03-20 12:11:35.000000000 +0100
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
