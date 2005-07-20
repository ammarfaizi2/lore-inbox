Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVGTR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVGTR6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVGTR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 13:58:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48814 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261430AbVGTR5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 13:57:19 -0400
Date: Wed, 20 Jul 2005 19:57:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: John Lenz <lenz@cs.wisc.edu>, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Sharp Zaurus sl-5500 broken in 2.6.12
Message-ID: <20050720175713.GA19403@atrey.karlin.mff.cuni.cz>
References: <20050711193454.GA2210@elf.ucw.cz> <33703.127.0.0.1.1121130438.squirrel@localhost> <20050719180624.GB15186@atrey.karlin.mff.cuni.cz> <20050719192104.GB32757@elf.ucw.cz> <1121804551.7499.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121804551.7499.55.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ...and that's well known; but now I did some back tracking, and
> > > 2.6.12-rc1 works, 2.6.12-rc2 does *not* and 2.6.12-rc2 with arm
> > > changes reverted works. I'll play a bit more.
> > 
> > This fixes at least one break-the-boot bug in -rc2...
> > 
> > 							Pavel
> > 
> > --- linux-z11.rc2bad/arch/arm/mach-sa1100/collie.c	2005-07-19 20:49:07.000000000 +0200
> > +++ linux-z11/arch/arm/mach-sa1100/collie.c	2005-07-19 21:05:54.000000000 +0200
> > @@ -235,7 +235,7 @@
> >  	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
> >  			      ARRAY_SIZE(collie_flash_resources));
> >  
> > -	sharpsl_save_param();
> > +//	sharpsl_save_param();
> >  }
> >  
> >  static struct map_desc collie_io_desc[] __initdata = {
> 
> Could you check this wasn't caused by this typo please:
> 
> http://www.rpsys.net/openzaurus/patches/collie_typofix-r0.patch
> 
> (this has been fixed in recent kernels)

Oops, you are right, it is now fixed. I screwed up some config or
something... It works now.

BTW is there some place where I can find modifications Sharp did to
mainline 2.4 kernel?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
