Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSIIQct>; Mon, 9 Sep 2002 12:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSIIQct>; Mon, 9 Sep 2002 12:32:49 -0400
Received: from packet.digeo.com ([12.110.80.53]:7876 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317471AbSIIQcs>;
	Mon, 9 Sep 2002 12:32:48 -0400
Message-ID: <3D7CD1B9.B1491E6@digeo.com>
Date: Mon, 09 Sep 2002 09:52:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Rik van Riel <riel@conectiva.com.br>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <Pine.LNX.4.44L.0209091035470.1857-100000@imladris.surriel.com> <E17oRCu-0006pL-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 16:37:25.0243 (UTC) FILETIME=[2D9F24B0:01C2581F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 09 September 2002 15:37, Rik van Riel wrote:
> > On Sun, 8 Sep 2002, Daniel Phillips wrote:
> >
> > > I suspect the overall performance loss on the laptop has more to do with
> > > several months of focussing exclusively on the needs of 4-way and higher
> > > smp machines.
> >
> > Probably true, we're pulling off an indecent number of tricks
> > for 4-way and 8-way SMP performance. This overhead shouldn't
> > be too bad on UP and 2-way machines, but might easily be a
> > percent or so.
> 
> Though to be fair, it's smart to concentrate on the high end with a
> view to achieving world domination sooner.  And it's a stretch to call
> the low end performance 'slow'.

It's on the larger machines where 2.4 has problems.  Fixing them up
makes the kernel broader, more general purpose.  We're seeing 50-100%
gains in some areas there.  Giving away a few percent on smaller machines
at this stage is OK.  But yup, we need to go and get that back later.

> An idea that's looking more and more attractive as time goes by is to
> have a global config option that specifies that we want to choose the
> simple way of doing things wherever possible, over the enterprise way.

Prefer not to.  We've been able to cover all bases moderately well
thus far without adding a big boolean switch.

> We want this especially for embedded.  On low end processors, it's even
> possible that the small way will be faster in some cases than the
> enterprise way, due to cache effects.

The main thing we can do for smaller systems is to not allocate as much
memory at boot time.  Some more careful scaling is needed there.  I'll
generate a list soon.
