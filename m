Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVCSN3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVCSN3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVCSNX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:23:28 -0500
Received: from coderock.org ([193.77.147.115]:14472 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262495AbVCSNSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:18:15 -0500
Subject: [patch 1/4] crypto/sha256.c: fix sparse warnings
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, domen@coderock.org,
       adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:18:09 +0100
Message-Id: <20050319131810.4A9111ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/sha256.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN crypto/sha256.c~sparse-crypto_sha256 crypto/sha256.c
--- kj/crypto/sha256.c~sparse-crypto_sha256	2005-03-18 20:05:34.000000000 +0100
+++ kj-domen/crypto/sha256.c	2005-03-18 20:05:34.000000000 +0100
@@ -58,7 +58,7 @@ static inline u32 Maj(u32 x, u32 y, u32 
 
 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
 {
-	W[I] = __be32_to_cpu( ((u32*)(input))[I] );
+	W[I] = __be32_to_cpu( ((__be32*)(input))[I] );
 }
 
 static inline void BLEND_OP(int I, u32 *W)
_
