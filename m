Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311252AbSCQBzD>; Sat, 16 Mar 2002 20:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311251AbSCQByy>; Sat, 16 Mar 2002 20:54:54 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:34323 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S311252AbSCQBys>;
	Sat, 16 Mar 2002 20:54:48 -0500
Date: Sat, 16 Mar 2002 18:54:21 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
Message-ID: <20020316185421.A26719@hq.fsmlabs.com>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <E16mObg-0000mZ-00@starship> <20020316181338.A26242@hq.fsmlabs.com> <E16mPFW-0000mo-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16mPFW-0000mo-00@starship>; from phillips@bonn-fries.net on Sun, Mar 17, 2002 at 02:14:14AM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 02:14:14AM +0100, Daniel Phillips wrote:
> On March 17, 2002 02:13 am, yodaiken@fsmlabs.com wrote:
> > On Sun, Mar 17, 2002 at 01:33:04AM +0100, Daniel Phillips wrote:
> > > On March 16, 2002 01:40 am, yodaiken@fsmlabs.com wrote:
> > > > 
> > > > Without preempt:
> > > > 	x = movefrom processor register;
> > 		// if preemption is on, we can be preempted and restart
> > 		// on another processor so x will be wrong
> > > >         do_something with x
> > > > 
> > > > is safe in SMP
> > > > With [preempt] it requires a lock.
> > > 
> > > It must be a trick question.  Why would it?
> > 
> > See comment.
> 
> Which processor register were you thinking of?  Surely not anything in the 
> general register set, and otherwise, it's just another example of per-cpu 
> data.  It needs to be protected, and the protection is lightweight.


So what didn't you understand? Your (dubious)
assertion that the lock is "lightweight"
has absolutely no bearing on whether a lock is needed or not.





> 
> -- 
> Daniel

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

