Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275278AbRJFQeH>; Sat, 6 Oct 2001 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275290AbRJFQd6>; Sat, 6 Oct 2001 12:33:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1034 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S275278AbRJFQdw>; Sat, 6 Oct 2001 12:33:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>,
        Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Subject: Re: low-latency patches
Date: Sat, 6 Oct 2001 18:33:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <3BBEA8CF.D2A4BAA8@zip.com.au>
In-Reply-To: <3BBEA8CF.D2A4BAA8@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011006163412Z16352-2758+1299@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 6, 2001 08:46 am, Andrew Morton wrote:
> Bob McElrath wrote:
> > 1) Which of these two projects has better latency performance?  Has anyone
> >     benchmarked them against each other?
> 
> I haven't seen any rigorous latency measurements on Rob's stuff, and
> I haven't seriously measured the reschedule-based patch for months.  But
> I would expect the preempt patch to perform significantly worse because
> it doesn't attempt to break up the abovementioned long-held locks.

Nor should it.  The preemption patch should properly address only what is 
needed to implement preemption, and a patch similar to yours should be 
applied on top to break up the remaining lock latencies.  (Perhaps a duh?)

> (It can
> do so, though - a straightforward adaptation of the reschedule patch's
> changes will fix it).

Yep.

--
Daniel
