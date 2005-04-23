Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVDWBUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDWBUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 21:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVDWBUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 21:20:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261426AbVDWBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 21:20:38 -0400
Date: Sat, 23 Apr 2005 03:20:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] correct the DEBUG_BUGVERBOSE question dependency
Message-ID: <20050423012035.GR4355@stusta.de>
References: <20050423002513.GQ4355@stusta.de> <Pine.LNX.4.61.0504230302400.863@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504230302400.863@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 03:05:17AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Apr 2005, Adrian Bunk wrote:
> 
> > Currently, DEBUG_BUGVERBOSE, is automatically set to "y" if 
> > DEBUG_KERNEL=n and EMBEDDED=y which doesn't make much sense.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.12-rc2-mm3-full/lib/Kconfig.debug.old	2005-04-22 03:03:27.000000000 +0200
> > +++ linux-2.6.12-rc2-mm3-full/lib/Kconfig.debug	2005-04-22 03:04:00.000000000 +0200
> > @@ -125,9 +125,9 @@
> >  	  This options enables addition error checking for high memory systems.
> >  	  Disable for production systems.
> >  
> >  config DEBUG_BUGVERBOSE
> > -	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
> > +	bool "Verbose BUG() reporting (adds 70K)" if EMBEDDED
> >  	depends on BUG
> >  	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || (X86 && !X86_64) || FRV
> >  	default !EMBEDDED
> >  	help
> 
> 1. you just messed up the menu structure.
> 2. the default is "!EMBEDDED", so it should become "n"?!


Ups, thanks for the correction.

I didn't see this, and this makes my patch completely pointless.


> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

