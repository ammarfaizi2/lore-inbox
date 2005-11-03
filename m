Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbVKCSYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVKCSYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbVKCSYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:24:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030382AbVKCSYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:24:08 -0500
Date: Thu, 3 Nov 2005 19:23:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tony.luck@gmail.com, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/platform.h
Message-ID: <20051103182358.GF23366@stusta.de>
References: <20050902205204.GU3657@stusta.de> <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net> <20051001233414.GG4212@stusta.de> <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com> <20051003190345.GH3652@stusta.de> <12c511ca0510031407i5266cf4ak5082ec54f60a3d17@mail.gmail.com> <20051003215053.GI3652@stusta.de> <20051010112341.7bb116ae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010112341.7bb116ae.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 11:23:41AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Mon, Oct 03, 2005 at 02:07:12PM -0700, Tony Luck wrote:
> >  > > The default_idle() prototype should stay inside some header file.
> >  > 
> >  > That would be best, yes.
> >  > 
> >  > > @Patrick:
> >  > > Any suggestion where it should move to?
> >  > 
> >  > Of the include files already included directly by arch/ia64/kernel/setup.c,
> >  > <linux/sched.h> looks the most promising.  There's lots of .*idle.* things
> >  > already in there.
> >  > 
> >  > Looking at existing precedent: ppc64 has a definition of default_idle()
> >  > in <asm/machdep.h>
> > 
> >  The question whether linux/ or asm/ is the best place for the definition 
> >  boils down to the question whether it is expected that default_idle() is 
> >  present on all architectures or whether it's an architecture-specific 
> >  implementation detail.
> 
> Yes, default_idle() is arch-specific and so its prototype should be in an
> arch-specific header.
> 
> All the implementations happen to have the same signature, so it's tempting
> to put the prototype into some generic header, but given that there's no
> non-arch-specific caller, we shouldn't do that.

ppc64 has the prototype in machdep.h.

The only other architectures that seem to require a non-static 
default_idle() are cris, i386 and ia64.

Any hint which header file would suit best?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

