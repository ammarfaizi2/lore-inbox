Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311240AbSCQBVN>; Sat, 16 Mar 2002 20:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311242AbSCQBUx>; Sat, 16 Mar 2002 20:20:53 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:26317 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311240AbSCQBUr>;
	Sat, 16 Mar 2002 20:20:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 2.4.18 Preempt Freezeups
Date: Sun, 17 Mar 2002 02:14:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <E16mObg-0000mZ-00@starship> <20020316181338.A26242@hq.fsmlabs.com>
In-Reply-To: <20020316181338.A26242@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mPFW-0000mo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 17, 2002 02:13 am, yodaiken@fsmlabs.com wrote:
> On Sun, Mar 17, 2002 at 01:33:04AM +0100, Daniel Phillips wrote:
> > On March 16, 2002 01:40 am, yodaiken@fsmlabs.com wrote:
> > > 
> > > Without preempt:
> > > 	x = movefrom processor register;
> 		// if preemption is on, we can be preempted and restart
> 		// on another processor so x will be wrong
> > >         do_something with x
> > > 
> > > is safe in SMP
> > > With [preempt] it requires a lock.
> > 
> > It must be a trick question.  Why would it?
> 
> See comment.

Which processor register were you thinking of?  Surely not anything in the 
general register set, and otherwise, it's just another example of per-cpu 
data.  It needs to be protected, and the protection is lightweight.

-- 
Daniel
