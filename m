Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVCTHd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVCTHd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 02:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCTHd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 02:33:57 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:30995 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262034AbVCTHd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 02:33:56 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: domen@coderock.org
Subject: Re: [patch 1/4] crypto/sha256.c: fix sparse warnings
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
Organization: Core
In-Reply-To: <20050319131810.4A9111ECA8@trashy.coderock.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DCuuz-0003fC-00@gondolin.me.apana.org.au>
Date: Sun, 20 Mar 2005 18:32:13 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> diff -puN crypto/sha256.c~sparse-crypto_sha256 crypto/sha256.c
> --- kj/crypto/sha256.c~sparse-crypto_sha256     2005-03-18 20:05:34.000000000 +0100
> +++ kj-domen/crypto/sha256.c    2005-03-18 20:05:34.000000000 +0100
> @@ -58,7 +58,7 @@ static inline u32 Maj(u32 x, u32 y, u32 
> 
> static inline void LOAD_OP(int I, u32 *W, const u8 *input)
> {
> -       W[I] = __be32_to_cpu( ((u32*)(input))[I] );
> +       W[I] = __be32_to_cpu( ((__be32*)(input))[I] );

I don't get any warnings here (sparse version dated 12/03/2005).
What warnings are you getting exactly?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
