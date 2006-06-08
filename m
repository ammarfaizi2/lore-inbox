Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWFHB5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWFHB5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFHB5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:57:36 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:29191 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932262AbWFHB5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:57:35 -0400
Date: Thu, 8 Jun 2006 11:57:28 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Message-ID: <20060608015728.GA8314@gondor.apana.org.au>
References: <200606041516.21967.jfritschi@freenet.de> <200606072137.24176.jfritschi@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606072137.24176.jfritschi@freenet.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 09:37:23PM +0200, Joachim Fritschi wrote:
> 
> diff -uprN linux-2.6.17-rc5/crypto/Makefile linux-2.6.17-rc5.twofish/crypto/Makefile
> --- linux-2.6.17-rc5/crypto/Makefile	2006-06-07 18:43:24.000000000 +0200
> +++ linux-2.6.17-rc5.twofish/crypto/Makefile	2006-06-04 13:59:27.949797218 +0200
> @@ -32,3 +32,5 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += mich
>  obj-$(CONFIG_CRYPTO_CRC32C) += crc32c.o
>  
>  obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
> +
> +twofish-objs := twofish_c.o twofish_common.o

What do we gain by renaming twofish.c to twofish_c.c?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
