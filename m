Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVCZI0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVCZI0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVCZI0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:26:32 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:19342 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261772AbVCZI0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:26:20 -0500
Date: Sat, 26 Mar 2005 11:52:45 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Kim Phillips <kim.phillips@freescale.com>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
Message-ID: <20050326115245.0a297934@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050326003601.GB22930@gondor.apana.org.au>
References: <1111737496.20797.59.camel@uganda>
	<424495A8.40804@freescale.com>
	<20050325234348.GA17411@havoc.gtf.org>
	<20050325234745.GA22661@gondor.apana.org.au>
	<20050326034733.3c532f20@zanzibar.2ka.mipt.ru>
	<20050326003601.GB22930@gondor.apana.org.au>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sat, 26 Mar 2005 11:25:11 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005 11:36:02 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sat, Mar 26, 2005 at 03:47:33AM +0300, Evgeniy Polyakov wrote:
> > 
> > It looks like we all misunderstand each other - 
> > why do you think that if there will be kernel <-> kernel
> > RNG dataflow, then system will continuously spent all
> > it's time to produce that data?
> 
> It doesn't matter whether it's like that or not.
> 
> The point is if you do it in the kernel then either you'll have very
> coarse controls over the rate of data coming out of the hardware RNG,
> e.g., only on/off, or you'll have to put more code in to set the rate 
> appropriately.

It is not the problem absolutely - just sleep if pool is full.
It will limit usage but this is better than nothing.
 
> Either way it's a loss compared to doing it in user-space.
>
>
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
