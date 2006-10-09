Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWJILO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWJILO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWJILO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:14:56 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:22532 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932401AbWJILOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:14:55 -0400
Date: Mon, 9 Oct 2006 21:14:46 +1000
To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] crypto: fix crypto_alloc_{tfm,base}() return value
Message-ID: <20061009111446.GA22020@gondor.apana.org.au>
References: <20061009085812.GA6020@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009085812.GA6020@localhost>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 05:58:12PM +0900, Akinobu Mita wrote:
> crypto_alloc_tfm() and crypto_alloc_base() are suppose to return error code
> as pointer on failures. But there are some cases where they return NULL
> (for example, crypto_alloc_tfm() returns NULL on kzalloc() failure)
> 
> This patch fixes that wrong return value, and also fixes tcrypt so that it can
> detect error code correctly.

Actually, crypto_alloc_tfm is an obsolete function which is supposed
to maintain its previous semantics of returning NULL or success.

I don't quite see where the problem with crypto_alloc_base is.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
