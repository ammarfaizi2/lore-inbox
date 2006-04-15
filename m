Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWDOPS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWDOPS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 11:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWDOPS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 11:18:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29708 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030270AbWDOPS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 11:18:56 -0400
Date: Sat, 15 Apr 2006 16:17:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       lenz@cs.wisc.edu
Subject: Re: Fix collie compilation
Message-ID: <20060415151735.GA19735@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, lenz@cs.wisc.edu
References: <20060414180300.GA23060@elf.ucw.cz> <1145038279.6179.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145038279.6179.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 07:11:19PM +0100, Richard Purdie wrote:
> On Fri, 2006-04-14 at 20:03 +0200, Pavel Machek wrote:
> > Fix collie compilation with current defconfig
> >[...]
> > diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> > index be589ce..9aa6cde 100644
> > --- a/arch/arm/mach-sa1100/collie.c
> > +++ b/arch/arm/mach-sa1100/collie.c
> > @@ -295,7 +295,9 @@ static void __init collie_init(void)
> >  	LCM_DAC |= (LCM_DAC_SCLOEB | LCM_DAC_SDAOEB); /* init DAC */
> >  #endif
> >  
> > +#ifdef CONFIG_PCMCIA_SA1100
> >  	platform_scoop_config = &collie_pcmcia_config;
> > +#endif
> 
> I'm fine with the defconfig changes but this last bit doesn't fix the
> original problem if CONFIG_PCMCIA_SA1100=m. The correct solution is to
> move platform_scoop_config back to scoop.c which I'll submit a patch
> for.

However, the patch doesn't apply to any -rc1 kernel, so it's been dropped
on the floor.

It would be nice to get patches generated against mainline kernels, and
which have been tested against mainline kernels...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
