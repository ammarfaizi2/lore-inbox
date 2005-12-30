Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVL3NiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVL3NiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVL3NiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:38:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26630 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751262AbVL3NiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:38:24 -0500
Date: Fri, 30 Dec 2005 14:38:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230133823.GY3811@stusta.de>
References: <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229231615.GV15993@alpha.home.local> <1135929917.2941.0.camel@laptopd505.fenrus.org> <20051230081536.GA30503@alpha.home.local> <1135931072.2941.9.camel@laptopd505.fenrus.org> <20051230092015.GA30681@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230092015.GA30681@w.ods.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 10:20:15AM +0100, Willy Tarreau wrote:
> On Fri, Dec 30, 2005 at 09:24:32AM +0100, Arjan van de Ven wrote:
> > On Fri, 2005-12-30 at 09:15 +0100, Willy Tarreau wrote:
> > > 
> > > 
> > > I trust your experience on this, but wasn't the lack of testing
> > > primarily due to the use of a "special" version of the compiler ?
> > > For instance, if we put a short howto in Documentation/ explaining
> > > how to build a kgcc toolchain describing what versions to use, there
> > > are chances that most LKML users will use the exact same version.
> > > Distro maintainers may want to follow the same version too. Also,
> > > the fact that the kernel would be designed to work with *that*
> > > compiler will limit the maintenance trouble you certainly have
> > > encountered trying to keep the compiler up-to-date with more recent
> > > kernel patches and updates.
> > 
> > it's not that easy. Simply put: the gcc people release an update every 6
> > months; distros "jump ahead" the bugfixes on that usually. (think of it
> > like -stable, where distros would ship patches accepted for -stable but
> > before -stable got released). Taking an older compiler from gcc.gnu.org
> > doesn't mean it's bug free. It just means you're not getting bugfixes.
> 
> OK, but precisely, we don't have any bug free version of gcc anyway. The
> kernel has a long history of workaround for gcc bugs. So probably there
> will be less work with a -possibly buggy- old gcc version than with a
> constantly changing one. For instance, if we stick to 3.4 for 2 years,
> we will of course encounter a lot of bugs. But they will be worked around
> just like gcc-2.95 bugs have been, and we will be able to keep the same
> compiler very long at virtually zero maintenance work.
>...

The changes in gcc aren't _that_ big.

As an example, I tried compiling recent 2.6 kernels with gcc CVS HEAD 
shortly before the 4.1 branch was created, and except for two or three 
internal compiler errors (that are OK considering that I used a random 
CVS snapshot) the kernel compiled fine.

Every gcc release might have it's own issues, but compared to e.g. the 
pains your proposal would impose on new ports, they aren't that big.
And you shouldn't forget that it's even non-trivial to find one gcc 
release that works fine compiling kernels on all architectures. As an 
example, gcc 3.2 is a known bad compiler on arm.

> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

