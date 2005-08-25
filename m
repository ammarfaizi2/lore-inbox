Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVHYOQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVHYOQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVHYOQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:16:52 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24984 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965008AbVHYOQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:16:51 -0400
Date: Thu, 25 Aug 2005 16:16:17 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Sam Creasey <sammy@sammy.net>, Paul Jackson <pj@sgi.com>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
In-Reply-To: <20050825141251.GS9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0508251614440.28348@numbat.sonytel.be>
References: <Pine.LNX.4.62.0508251125030.28348@numbat.sonytel.be>
 <Pine.LNX.4.40.0508250954240.17653-100000@sun3>
 <20050825141251.GS9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Al Viro wrote:
> On Thu, Aug 25, 2005 at 09:59:05AM -0400, Sam Creasey wrote:
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

Indeed, the cache flush routines have to be moved to a separate file, as per
376-cache.diff. But that one depends on 362-cache.diff, that's why it's still
in my POSTPONED queue, until the originator has pushed that one upstream.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
