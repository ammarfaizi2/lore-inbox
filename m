Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWJJDxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWJJDxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWJJDxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:53:48 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:19729 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964940AbWJJDxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:53:47 -0400
Date: Tue, 10 Oct 2006 13:53:39 +1000
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] crypto: fix crypto_alloc_{tfm,base}() return value
Message-ID: <20061010035339.GA29279@gondor.apana.org.au>
References: <20061009085812.GA6020@localhost> <20061009111446.GA22020@gondor.apana.org.au> <20061009115526.GA10857@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009115526.GA10857@localhost>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 08:55:26PM +0900, Akinobu Mita wrote:
> 
> I misunderstood about crypto_alloc_tfm().
> 
> BTW, ecryptfs and reiser4 are still using crypto_alloc_tfm().
> Should we mark it as __deprecated?

Probably.  Although anybody using crypto_alloc_tfm will probably
also use the old crypto interface which gives plenty of warnings
already.

> - __crypto_alloc_tfm() should return -ENOMEM on kzalloc() failure.
>   But it returns NULL.
> 
> - crypto_alloc_base() may not return -EINTR on signal_pending()
> 
> I'll fix the patch and resend with more clear description later.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
