Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVKAUh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVKAUh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVKAUh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:37:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26306 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751164AbVKAUhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:37:55 -0500
Date: Tue, 1 Nov 2005 21:37:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Make spitz compile again
Message-ID: <20051101203715.GB7172@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz> <1130773530.8353.39.camel@localhost.localdomain> <20051101193135.GA7075@elf.ucw.cz> <1130875849.8489.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130875849.8489.21.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I needed this to get it to compile... Please apply (probably modulo //
> > part).
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> > --- clean-rp/arch/arm/mach-pxa/pxa_keys.c	2005-11-01 19:32:56.000000000 +0100
> > +++ linux-rp/arch/arm/mach-pxa/pxa_keys.c	2005-11-01 20:17:38.000000000 +0100
> 
> None of the Zaurus models use pxa_keys so I don't know why you're
> compiling this. I'll sort it out but its only needed for the hx2750 in
> the tree you have.

Sorry, will fix that.. The patch should still help poor 2750 users
;-).

> >  static struct pxaficp_platform_data spitz_ficp_platform_data = {
> >  	.transceiver_cap  = IR_SIRMODE | IR_OFF,
> > -	.transceiver_mode = spitz_irda_transceiver_mode,
> > +//	.transceiver_mode = spitz_irda_transceiver_mode,
> >  };
> 
> I'm not sure why you'd want to do that?

Because of this one?

  CC      arch/arm/mach-pxa/spitz.o
arch/arm/mach-pxa/spitz.c:347: error: `spitz_irda_transceiver_mode'
undeclared here (not in a function)
arch/arm/mach-pxa/spitz.c:347: error: initializer element is not
constant
arch/arm/mach-pxa/spitz.c:347: error: (near initialization for
`spitz_ficp_platform_data.transceiver_mode')
make[1]: *** [arch/arm/mach-pxa/spitz.o] Error 1

:-). I probably should have enabled irda in config or something.

> I'll move the akita code around and sort out the #ifdefs - it should
> compile and just throw the odd warning about unused code as it stands
> though?

Probably same irda problem.
							Pavel
-- 
Thanks, Sharp!
