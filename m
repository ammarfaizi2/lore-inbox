Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVCYGSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVCYGSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:18:16 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:49933 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261445AbVCYGO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:14:57 -0500
Date: Fri, 25 Mar 2005 17:13:11 +1100
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325061311.GA22959@gondor.apana.org.au>
References: <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com> <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111731361.20797.5.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:16:01AM +0300, Evgeniy Polyakov wrote:
> On Fri, 2005-03-25 at 00:58 -0500, Jeff Garzik wrote:
>
> > If its disabled by default, then you and 2-3 other people will use this 
> > feature.  Not enough justification for a kernel API at that point.
> 
> It is only because there are only couple of HW crypto devices
> in the tree, with one crypto framework inclusion there will be
> at least redouble.

You missed the point.  This has nothing to do with the crypto API.
Jeff is saying that if this is disabled by default, then only a few
users will enable it and therefore use this API.

Since we can't afford to enable it by default as hardware RNG may
fail which can lead to catastrophic consequences, there is no point
for this API at all.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
