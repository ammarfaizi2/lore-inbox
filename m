Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288541AbSANBJu>; Sun, 13 Jan 2002 20:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288543AbSANBJk>; Sun, 13 Jan 2002 20:09:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30471 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288541AbSANBJa>; Sun, 13 Jan 2002 20:09:30 -0500
Date: Sun, 13 Jan 2002 20:08:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16O2hc-0000B3-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020113195717.17441I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Daniel Phillips wrote:

> On January 8, 2002 08:47 pm, Andrew Morton wrote:
> > There's no point in just merging the preempt patch and saying "there,
> > that's done".  It doesn't do anything.
> > 
> > Instead, a decision needs to be made: "Linux will henceforth be a 
> > low-latency kernel".
> 
> I thought the intention was to make it a config option?

Irrelevant, it has to be implemented in order to be an option, so the
amount of work involved is the same either way. And if you want to make it
a runtime setting you add a slight bit of work and overhead deciding if LL
is wanted.

I'm not advocating that, but it would allow admins to enable LL when the
system was slow and see if it really made a change. Rebooting is bound to
change the load ;-)
 
> > Now, IF we can come to this decision, then
> > internal preemption is the way to do it.  But it affects ALL kernel
> > developers.  Because we'll need to introduce a new rule: "it is a
> > bug to spend more than five milliseconds holding any locks".
> > 
> > So.  Do we we want a low-latency kernel?  Are we prepared to mandate
> > the five-millisecond rule?   It can be done, but won't be easy, and
> > we'll never get complete coverage.  But I don't see the will around
> > here.

Really? You have people working on low latency, people working on preempt,
and at least a few of us trying to characterize the problems with large
memory and i/o. I would say latency has become a real issue, and you only
need enough "will" to have one person write useful code, this is a
committee.

Since changes of this type don't need to be perfect and address all cases,
just help some and not make other worse, I think we will see improvement
in 2.4.xx without waiting for 2.5 or 2.6. No one is complaining that the
Linux overall thruput is bad, that network performance is bad, etc. But
responsiveness has become an issue, and I'm sure there's enough will to
solve it. "Solve" means getting most of the delays to be caused by
hardware capacity instead of kernel ineptitude.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

