Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVCTLXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVCTLXD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCTLUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:20:49 -0500
Received: from coderock.org ([193.77.147.115]:41099 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261720AbVCTLUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:20:16 -0500
Date: Sun, 20 Mar 2005 12:20:08 +0100
From: Domen Puncer <domen@coderock.org>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 2/4 with proper signed-off] crypto/sha512.c: fix sparse warnings
Message-ID: <20050320112008.GI14273@nd47.coderock.org>
References: <20050319131813.768A11ECA8@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131813.768A11ECA8@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/crypto/sha512.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN crypto/sha512.c~sparse-crypto_sha512 crypto/sha512.c
--- kj/crypto/sha512.c~sparse-crypto_sha512	2005-03-20 12:11:34.000000000 +0100
+++ kj-domen/crypto/sha512.c	2005-03-20 12:11:34.000000000 +0100
@@ -105,7 +105,7 @@ static const u64 sha512_K[80] = {
 
 static inline void LOAD_OP(int I, u64 *W, const u8 *input)
 {
-	W[I] = __be64_to_cpu( ((u64*)(input))[I] );
+	W[I] = __be64_to_cpu( ((__be64*)(input))[I] );
 }
 
 static inline void BLEND_OP(int I, u64 *W)
_
