Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVHYORV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVHYORV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHYORV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:17:21 -0400
Received: from sun3.sammy.net ([68.162.198.6]:4108 "HELO sun3.sammy.net")
	by vger.kernel.org with SMTP id S965013AbVHYOQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:16:58 -0400
Date: Thu, 25 Aug 2005 10:17:16 -0400 (EDT)
From: Sam Creasey <sammy@sammy.net>
X-X-Sender: sammy@sun3
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, Paul Jackson <pj@sgi.com>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
In-Reply-To: <20050825141251.GS9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.40.0508251012220.17653-100000@sun3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Aug 2005, Al Viro wrote:

> On Thu, Aug 25, 2005 at 09:59:05AM -0400, Sam Creasey wrote:
>
> > I have been a little out of it for a while on the sun3 stuffs, I'll admit
> > (cursed day job), but I really, really intend to get recent 2.6 running
> > again.  Knowing that the rest of m68k is at least compiling is a good
> > start point.  Still, I'm going with Geert, and I'm not sure where the
> > compile regressions would have come from (outside of the video/serial
> > drivers, which don't compile in m68k CVS either).
> >
> > What compile failures are you seeing?
>
> After looking at that for a while...  It's the second hairball in there ;-)
> flush_icache_range()/flush_icache_user_range() stuff, with all related
> fun.  Note that mainline has flush_ichace_range() in memory.c, which is
> not picked by sun3.

Huh, my last compiling 2.6 sun3 tree ((old) m68k CVS) has those in
arch/m68k/mm/cache.c, which sun3 did use.

Ok, sounds like I need to make sure those are broken out sanely.  I'm
pretty sure memory.c is a bad place for that, since (as you observed),
it's motorola-mmu only code (or, at least, was...)

I'm considerably less scared now. :)

-- Sam


