Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVHYJaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVHYJaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHYJaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:30:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5603 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964903AbVHYJaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:30:11 -0400
Date: Thu, 25 Aug 2005 11:29:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Paul Jackson <pj@sgi.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Sam Creasey <sammy@sammy.net>
Subject: Re: Linux-2.6.13-rc7
In-Reply-To: <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0508251125030.28348@numbat.sonytel.be>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
 <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk>
 <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2005, Al Viro wrote:
> It does, no (build) regressions.  BTW, tree is not far from allmodconfig
> buildable on a bunch of targets now - yesterday pile of fixes was about
> half of the set needed for that.  Most of the remaining stuff is for
> m68k (and applies both to Linus' tree and m68k CVS); I'll send that today
> and if Geert ACKs them, we will be _very_ close to having 2.6.13 build

They look OK to me (sorry, I'm not in a position to really test them).
For thread_info related stuff, please coordinate with Roman.

> out of the box on the following set:
> alpha, amd64, arm (RPC and versatile being tracked), i386, ia64, m32r,
> m68k (!SUN3), ppc (6xx, 44x, chestnut being tracked), ppc64, sparc,
> sparc64, s390, s390x, uml-i386, uml-amd64.

Very nice! That must be a historical record ;-)

> 	v850, m68knommu: gcc gives ICE on attempt to build cross-toolchain

Can't you use the plain m68k toolchain? I always used a m68k-linux-gcc 3.3.3
for my uClinux experiments.

> sun3 is seriously broken and I doubt that we'll see any takers for testing
> 2.6 on those anyway ;-)

However, a few months ago it was still known to work in m68k CVS (ask Sammy).
And I didn't see any real compile regressions since then.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
