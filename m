Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVC2KmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVC2KmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVC2KjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:39:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35512 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262330AbVC2KiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:38:23 -0500
Date: Tue, 29 Mar 2005 12:38:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jgarzik@pobox.com>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329103801.GE3897@elf.ucw.cz>
References: <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <20050329102104.GB6496@elf.ucw.cz> <20050329103049.GB19541@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329103049.GB19541@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What catastrophic consequences? Noone is likely to even *notice*, and
> > it does not help practical attack at all. Unless hardware RNGs are
> > *very* flakey (like, more flakey than harddrives), this is not a problem.
> 
> The reason some people use hardware RNGs in the first place is because
> they don't trust the software RNGs.  When the hardware RNG fails but
> continues to send data to /dev/random, /dev/random essentially degenerates
> into a software RNG.  Now granted /dev/random is a pretty good software
> RNG, however, for some purposes it just isn't good enough.

It seems to me that people wanting this level of assurance should do
their own FIPS (or whatever) tests.

Interrupts are not totally unpredictable, either, yet noone runs FIPS
tests on them. I'd say that hardware generator is still better than
interrupt timing. If someone really wants casino-level of randomness,
they should do it all in userspace, probably off interrupt entropy
sources, and do their own FIPS testing.

> Otherwise we can just do away with it and always use /dev/urandom.
> 
> Someone else raised the example of Casinos using hardware RNGs.  Some
> of them are doing this to comply with government regulation.  In that
> case, using data from the software RNG when the hardware has failed
> would be violating the law.

Well, you are still using hardware RNG, but failed one. I do not see
how you can break law with that... given that hardware RNG had proper
certification in the first place.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
