Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268202AbTBNBvx>; Thu, 13 Feb 2003 20:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268203AbTBNBvw>; Thu, 13 Feb 2003 20:51:52 -0500
Received: from jazz-1.trumpet.com.au ([203.5.119.62]:47887 "EHLO
	jazz-1.trumpet.com.au") by vger.kernel.org with ESMTP
	id <S268202AbTBNBvu>; Thu, 13 Feb 2003 20:51:50 -0500
Date: Fri, 14 Feb 2003 13:01:30 +1100 (EST)
From: Peter Tattam <peter@jazz-1.trumpet.com.au>
To: mailing-lists@digitaleric.net
cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
In-Reply-To: <200302132051.35268.lkml@digitaleric.net>
Message-ID: <Pine.BSF.3.96.1030214125805.16984A-100000@jazz-1.trumpet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Eric Northup wrote:

> On Thursday 13 February 2003 07:14 pm, Peter Tattam wrote:
> > On Thu, 13 Feb 2003, Andi Kleen wrote:
> > > [Hmm, this is becomming a FAQ]
> > >
> > > > Switching in and out of long mode is evil enough that I don't think it
> > > > is worth it.  And encouraging people to write good JIT compiling
> > >
> > > Forget it. It is completely undefined in the architecture what happens
> > > then. You'll lose interrupts and everything. Nothing for an operating
> > > system intended to be stable.
> > >
> > > I have no plans at all to even think about it for Linux/x86-64.
> [snip]
> >
> > The only other unknown quantity is the time it takes for the CPU to
> > enable/disable long mode, but with modern CPU speeds, the interrupt latency
> > may only be mildy affect by such a process, unless the CPU is broken in
> > some way. I see no discussion in the AMD manuals regarding the cost of the
> > mode switch, only what AMD engineers have hinted at.
> 
> I think the real issue is that AMD neither recommends nor supports this 
> strategy.  ( http://www.x86-64.org/lists/discuss/msg02964.html ... there were 
> better posts but I couldn't find them)  People with real hardware can't talk 
> about it right now, but it seems to me this is just begging to get hit by 
> errata -- how much effore do you think team Hammer spent testing a subtle 
> mode transition which is marked "Don't do that!" ?
> 

well, I guess AMD need to come out & explicitly state this somewhere other than
on a mailing list.   I wouldn't be only one tempted to see if it can be done,
and if it becomes "necessary" for some OSes, AMD will get locked into a
backward compatibility minefield.  Anyone know what Windows 64 does about this
issue?  If Microsoft considers that it is sufficient to warp the CPU for v86
emulation, it may just be a done deal.

Peter

--
Peter R. Tattam                            peter@trumpet.com
Managing Director,    Trumpet Software International Pty Ltd
Hobart, Australia,  Ph. +61-3-6245-0220,  Fax +61-3-62450210

