Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVC2Kaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVC2Kaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVC2K2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:28:37 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:37901 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262291AbVC2K2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:28:14 -0500
Date: Tue, 29 Mar 2005 20:25:08 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, johnpol@2ka.mipt.ru,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329102508.GA19541@gondor.apana.org.au>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com> <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <20050329101816.GA6496@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329101816.GA6496@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 12:18:16PM +0200, Pavel Machek wrote:
>
> I do not think paranoia about random generators is neccessary. If
> vendor provides you with random generator, it should be ok to just use
> it. [Did anyone see failing hw random generator, *at all*?] I can
> provide you with plenty of failing hdds....

We've been through this before.  It's not a question of trusting the
hardware to be /dev/hw_random, it's a question of trusting it to be
/dev/random.

/dev/random is special in that we've gone to extraordinary lengths to
make sure that it contains the amount of entropy that we say it does.

So while it'd be perfectly OK to feed unverified data through
/dev/hw_random, the same cannot be done for /dev/random.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
