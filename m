Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbUKYCxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUKYCxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUKYCxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:53:09 -0500
Received: from brown.brainfood.com ([146.82.138.61]:7315 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262933AbUKYCxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:53:02 -0500
Date: Wed, 24 Nov 2004 03:00:37 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
In-Reply-To: <20041124040604.GA13340@elte.hu>
Message-ID: <Pine.LNX.4.58.0411240258460.2242@gradall.private.brainfood.com>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
 <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
 <20041123115201.GA26714@elte.hu> <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com>
 <20041124040604.GA13340@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Ingo Molnar wrote:

>
> * Adam Heath <doogie@debian.org> wrote:
>
> > > > I'm seeing something very odd.  It's against 29-0.  I also seem to
> > > > recall seeing something similiar reported earlier.
> > > >
> > > > I'm seeing pauses on my system.  Not certain what is causing it.
> > > > Hitting a key on the keyboard unsticks it.
> > >
> > > at first sight this looks like a scheduling/wakeup anomaly. Please
> > > re-report this if it happens with the current (30-4) kernel too. Also,
> > > could you test the vanilla -mm tree, it has a few scheduler updates too.
> >
> > 2.6.10-rc1-mm3 doesn't have the same problem.  Didn't have a more
> > recent mm kernel available last night.  Will compile one, and always
> > keep it available.
>
> -rc2-mm2 would be nice to test - there are a number of new interactivity
> fixes from Con being test-driven in -mm right now. In particular, these
> patches were added in -rc1-mm4. These are the patches in question:
>
>  sched-adjust_timeslice_granularity.patch
>  requeue_granularity.patch
>  sched-remove_interactive_credit.patch
>
> you can download them individually from:
>
>  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/broken-out/
>
> so if these symptoms still occur with vanilla -rc2-mm2, could you try to
> unapply them, in reverse order? (there might be rejects when you try
> that, due to patch dependencies - let me know if it doesnt work out and
> i'll do an undo patch.)

The symptoms still occur with 30-9.  I'll be trying rc2-mm2 over the holiday.

Came in this morning, and after hitting a key, my machine said it was 2:38am,
when it was actually 11:10am.  All internet connections had died(obviously).
But the machine started working fine once I hit that key.  No messages in
dmesg.
