Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVL2TOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVL2TOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVL2TOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:14:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750861AbVL2TOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:14:20 -0500
Date: Thu, 29 Dec 2005 20:14:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229191419.GR3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de> <20051229154241.GY22293@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229154241.GY22293@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 10:42:41AM -0500, Jakub Jelinek wrote:
> On Thu, Dec 29, 2005 at 04:35:29PM +0100, Adrian Bunk wrote:
> > > You describe a nice utopia where only the most essential functions are
> > > inlined.. but so far that hasn't worked out all that well ;) Turning
> > > "inline" back into the hint to the compiler that the C language makes it
> > > is maybe a cop-out, but it's a sustainable approach at least.
> > >...
> > 
> > But shouldn't nowadays gcc be able to know best even without an "inline" 
> > hint?
> 
> Only for static functions (and in -funit-at-a-time mode).

I'm assuming -funit-at-a-time mode. Currently it's disabled on i386, but 
this will change in the medium-term future.

> Anything else would require full IMA over the whole kernel and we aren't
> there yet.  So inline hints are useful.  But most of the inline keywords
> in the kernel really should be that, hints, because e.g. while it can be

Are there (on !alpha) any places in the kernel where a function is 
inline but not static, and this is wanted?

> beneficial to inline something on one arch, it may be not beneficial on
> another arch, depending on cache sizes, number of general registers
> available to the compiler, register preassure, speed of the call/ret
> pair, calling convention and many other factors.

Does gcc really need hints when the functions are static?

> 	Jakub

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

