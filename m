Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274667AbRITWDu>; Thu, 20 Sep 2001 18:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274672AbRITWDj>; Thu, 20 Sep 2001 18:03:39 -0400
Received: from waste.org ([209.173.204.2]:29784 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S274667AbRITWD1>;
	Thu, 20 Sep 2001 18:03:27 -0400
Date: Thu, 20 Sep 2001 17:03:15 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <20010920213510Z274657-760+14618@vger.kernel.org>
Message-ID: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Dieter Nützel wrote:

> Am Donnerstag, 20. September 2001 23:10 schrieb Robert Love:
> > On Thu, 2001-09-20 at 04:21, Andrea Arcangeli wrote:
> > > > You've forgotten a one liner.
> > > >
> > > >   #include <linux/locks.h>
> > > > +#include <linux/compiler.h>
> > >
> > > woops, didn't trapped it because of gcc 3.0.2. thanks.
> > >
> > > > But this is not enough. Even with reniced artsd (-20).
> > > > Some shorter hiccups (0.5~1 sec).
> > >
> > > I'm not familiar with the output of the latency bench, but I actually
> > > read "4617" usec as the worst latency, that means 4msec, not 500/1000
> > > msec.
> >
> > Right, the patch is returning the length preemption was unavailable
> > (which is when a lock is held) in us. So it is indded 4ms.
> >
> > But, I think Dieter is saying he _sees_ 0.5~1s latencies (in the form of
> > audio skips).  This is despite the 4ms locks being held.
>
> Yes, that's the case. During dbench 16,32,40,48, etc...

You might actually be waiting on disk I/O and not blocked.

Does your audio source depend on any files (eg mp3s) and if so, could they
be moved to a ramfs? Do the skips go away then?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

