Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVCTLXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVCTLXC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVCTLVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:21:10 -0500
Received: from coderock.org ([193.77.147.115]:38795 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261729AbVCTLT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:19:29 -0500
Date: Sun, 20 Mar 2005 12:19:24 +0100
From: Domen Puncer <domen@coderock.org>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 1/4 with proper signed-off] crypto/sha256.c: fix sparse warnings
Message-ID: <20050320111924.GH14273@nd47.coderock.org>
References: <20050319131810.4A9111ECA8@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131810.4A9111ECA8@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/sha256.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN crypto/sha256.c~sparse-crypto_sha256 crypto/sha256.c
--- kj/crypto/sha256.c~sparse-crypto_sha256	2005-03-20 12:11:33.000000000 +0100
+++ kj-domen/crypto/sha256.c	2005-03-20 12:11:33.000000000 +0100
@@ -58,7 +58,7 @@ static inline u32 Maj(u32 x, u32 y, u32 
 
 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
 {
-	W[I] = __be32_to_cpu( ((u32*)(input))[I] );
+	W[I] = __be32_to_cpu( ((__be32*)(input))[I] );
 }
 
 static inline void BLEND_OP(int I, u32 *W)
_
