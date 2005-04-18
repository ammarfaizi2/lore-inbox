Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVDRLuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVDRLuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVDRLuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:50:37 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:19462 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262043AbVDRLub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:50:31 -0400
Date: Mon, 18 Apr 2005 21:49:25 +1000
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@intercode.com.au>, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: resource release functions ought to check for NULL (crypto_free_tfm)
Message-ID: <20050418114925.GA6854@gondor.apana.org.au>
References: <Pine.LNX.4.62.0504150106420.3466@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504150106420.3466@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 01:15:58AM +0200, Jesper Juhl wrote:
> 
> As far as I'm aware there's a general concensus that functions that are 
> responsible for freeing resources should be able to cope with being passed 
> a NULL pointer. This makes sense as it removes the need for all callers to 

In general I'd only do this when most of the callers are doing the
NULL check.  As that seems to be the case here, I agree with your
change.  I've applied it to my tree.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
