Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTIJOSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263844AbTIJOSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:18:53 -0400
Received: from gprs147-217.eurotel.cz ([160.218.147.217]:29569 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263787AbTIJOSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:18:52 -0400
Date: Wed, 10 Sep 2003 16:17:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Mikael Pettersson <mikpe@csd.uu.se>, bunk@fs.tum.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       robert@schwebel.de, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030910141713.GA2589@elf.ucw.cz>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se> <20030907174341.GA21260@mail.jlokier.co.uk> <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk> <20030908101714.A25308@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908101714.A25308@bitwizard.nl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 	2. The CPU types are not a total order.  Say I want a kernel
> > > 	   that supports Athlons and a Centaur for my cluster.  What
> > > 	   CPU setting should I use?  What CPU setting will give my the best
> > > 	   performing kernel - and is that the same as the one for smallest
> > > 	   kernel?
> > 
> > You'd use two kernels. There is no sane other answer to that specific
> > case 8)
> 
> Ehmm. In some cases, having multiple kernels is a pain in the @55. 
> 
> Having the option to make a generic kernel should remain. One that
> works on as much as possible CPUs. Even if it's a bit suboptimal on
> some CPUs. 
> 
> Also it would be nice if we can make the boot code run on anything
> until the point where the CPU is detected. Then we can give a nice
> message that the kernel was not compiled for this cpu instead of a 
> blank-screen-hang. If we have to compile printk for 386 for this

Better yet do the check in i386/boot/setup.S; its assembly anyway... I
actually had check there (or somewhere near that :-) for x86-64. Not
sure where it is now.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
