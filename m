Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVCSNYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVCSNYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCSNXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:23:39 -0500
Received: from coderock.org ([193.77.147.115]:16776 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262496AbVCSNSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:18:18 -0500
Subject: [patch 2/4] crypto/sha512.c: fix sparse warnings
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:18:12 +0100
Message-Id: <20050319131813.768A11ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/sha512.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN crypto/sha512.c~sparse-crypto_sha512 crypto/sha512.c
--- kj/crypto/sha512.c~sparse-crypto_sha512	2005-03-18 20:05:35.000000000 +0100
+++ kj-domen/crypto/sha512.c	2005-03-18 20:05:35.000000000 +0100
@@ -105,7 +105,7 @@ static const u64 sha512_K[80] = {
 
 static inline void LOAD_OP(int I, u64 *W, const u8 *input)
 {
-	W[I] = __be64_to_cpu( ((u64*)(input))[I] );
+	W[I] = __be64_to_cpu( ((__be64*)(input))[I] );
 }
 
 static inline void BLEND_OP(int I, u64 *W)
_
