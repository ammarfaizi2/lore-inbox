Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSFSW3t>; Wed, 19 Jun 2002 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318037AbSFSW3s>; Wed, 19 Jun 2002 18:29:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9225 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318036AbSFSW3r>; Wed, 19 Jun 2002 18:29:47 -0400
Date: Wed, 19 Jun 2002 18:25:22 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield() 
In-Reply-To: <E17Kg4s-0001Lz-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.3.96.1020619181429.3743B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Rusty Russell wrote:

> In message <Pine.LNX.3.96.1020619072548.1119D-100000@gatekeeper.tmr.com> you wr
> ite:
> > On Wed, 19 Jun 2002, Rusty Russell wrote:
> > 
> > > On Mon, 17 Jun 2002 17:46:29 -0700
> > > David Schwartz <davids@webmaster.com> wrote:
> > > > "The sched_yield() function shall force the running thread to relinquish 
> the 
> > > > processor until it again becomes the head of its thread list. It takes no
>  
> > > > arguments."
> > > 
> > > Notice how incredibly useless this definition is.  It's even defined in ter
> ms
> > > of UP.
> > 
> > I think you parse this differently than I, I see no reference to UP. The
> > term "the processor" clearly (to me at least) means the processor running
> > in that thread at the time of the yeild.
> > 
> > The number of processors running in a single thread at any one time is an
> > integer number in the range zero to one.
> 
> It's the word "until": "relinquish the processor until".
> 
> It's pretty clearly implied that it's going to "unrelinquish" *the
> processor* at the end of this process.
> 
> So, by your definition, it can be scheduled on another CPU before it
> becomes head of the thread list?

I have to read "head of the thread list" broadly, and assume it means the
thread will be run when it is the most appropriate thread to be run. I
don't read the wording as requiring or forbidding SMP, uni, or a strict
round-robin scheduler. The term "head of the thread list" doesn't state
that all other processes must get a time slice.

I believe I clarified my concerns in another post, I don't want to repeat
them. I don't want a process with threads contending for a resource to get
all or none of the CPU, each of which is possible with various schedulers
and patches recently available. I'd like to see threads of a single
process be able to get, use, and share a timeslice before some cpu hog
comes in and get his timeslice.

I don't read the text you quoted as requiring much more than 'run someone
else," because it's comfortably vague. To me anyway. I'm not knocking
anyone who reads it more strictly, I just don't see what you did.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

