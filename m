Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311261AbSCQCOy>; Sat, 16 Mar 2002 21:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310184AbSCQCOo>; Sat, 16 Mar 2002 21:14:44 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:4558 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311261AbSCQCOa>;
	Sat, 16 Mar 2002 21:14:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 2.4.18 Preempt Freezeups
Date: Sun, 17 Mar 2002 03:08:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <E16mPFW-0000mo-00@starship> <20020316185421.A26719@hq.fsmlabs.com>
In-Reply-To: <20020316185421.A26719@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mQ5f-0000mx-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 17, 2002 02:54 am, yodaiken@fsmlabs.com wrote:
> On Sun, Mar 17, 2002 at 02:14:14AM +0100, Daniel Phillips wrote:
> > On March 17, 2002 02:13 am, yodaiken@fsmlabs.com wrote:
> > > On Sun, Mar 17, 2002 at 01:33:04AM +0100, Daniel Phillips wrote:
> > > > On March 16, 2002 01:40 am, yodaiken@fsmlabs.com wrote:
> > > > > 
> > > > > Without preempt:
> > > > > 	x = movefrom processor register;
> > > 		// if preemption is on, we can be preempted and restart
> > > 		// on another processor so x will be wrong
> > > > >         do_something with x
> > > > > 
> > > > > is safe in SMP
> > > > > With [preempt] it requires a lock.
> > > > 
> > > > It must be a trick question.  Why would it?
> > > 
> > > See comment.
> > 
> > Which processor register were you thinking of?  Surely not anything in the 
> > general register set, and otherwise, it's just another example of per-cpu 
> > data.  It needs to be protected, and the protection is lightweight.
> 
> So what didn't you understand? Your (dubious)
> assertion that the lock is "lightweight"
> has absolutely no bearing on whether a lock is needed or not.

I didn't understand which kind of register you meant (because you didn't say). 
For the bog-standard variety I don't see a problem.

Protection of special registers is lightweight, it's just a preempt
disable/enable (inc/dec).

-- 
Daniel
