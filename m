Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVCZAii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVCZAii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVCZAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:38:37 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:15891 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261893AbVCZAib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:38:31 -0500
Date: Sat, 26 Mar 2005 11:36:02 +1100
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, Kim Phillips <kim.phillips@freescale.com>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050326003601.GB22930@gondor.apana.org.au>
References: <1111737496.20797.59.camel@uganda> <424495A8.40804@freescale.com> <20050325234348.GA17411@havoc.gtf.org> <20050325234745.GA22661@gondor.apana.org.au> <20050326034733.3c532f20@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326034733.3c532f20@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 03:47:33AM +0300, Evgeniy Polyakov wrote:
> 
> It looks like we all misunderstand each other - 
> why do you think that if there will be kernel <-> kernel
> RNG dataflow, then system will continuously spent all
> it's time to produce that data?

It doesn't matter whether it's like that or not.

The point is if you do it in the kernel then either you'll have very
coarse controls over the rate of data coming out of the hardware RNG,
e.g., only on/off, or you'll have to put more code in to set the rate 
appropriately.

Either way it's a loss compared to doing it in user-space.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
