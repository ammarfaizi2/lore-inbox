Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbRFSRKp>; Tue, 19 Jun 2001 13:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbRFSRKf>; Tue, 19 Jun 2001 13:10:35 -0400
Received: from mail.zmailer.org ([194.252.70.162]:7693 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S263359AbRFSRKZ>;
	Tue, 19 Jun 2001 13:10:25 -0400
Date: Tue, 19 Jun 2001 20:10:05 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619201005.P5947@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca> <3B2F769C.DCDB790E@kegel.com> <20010619090956.R3089@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010619090956.R3089@work.bitmover.com>; from lm@bitmover.com on Tue, Jun 19, 2001 at 09:09:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I can understand the opinnions expressed by these quotes.
  Having seen how horribly certain CORBA monsters work, I am sure
  that the basic idea of threads is lost somewhere along the way...

On Tue, Jun 19, 2001 at 09:09:56AM -0700, Larry McVoy wrote:
> > > >--
> > > > "A Computer is a state machine.
> > > >  Threads are for people who can't program state machines."
> > > >       - Alan Cox
.... 
> And one from me:
> 
>     ``Think of it this way: threads are like salt, not like pasta. You
>     like salt, I like salt, we all like salt. But we eat more pasta.''
> 
> Threads are a really bad idea.  All you need are processes and either the
> ability to not fork the VM (Linux' clone, Plan 9's rfork) or just good
> old mmap(2).  If you allow threads then all you are saying is that your
> process model is so pathetic you had to invent another, supposedly lighter
> weight, object to do the same thing.  

   That is usually true.   In rare cases I *do* want to use threads, or
   things just alike them.

   Pre-requisite are for wanting to share very large amounts of the VM
   of the processes and/or IO descriptors, have multiple processors in
   the system capable to execute my code, and wanting to parallellize
   (with lack of AIO) certain IO activities (disk related, mainly) which
   normal non-blocking IO can't handle.


   Threads are like salt, best used in moderation.
   They are resources, and hogging them will very rapidly cause
   the harms to exceed the benefits.


   (...that CORBA beast...)  ... creates a thread for each incoming
   request without any sort of limit at how much there can be threads
   running in parallel.

> Don't you think it is funny that Sun doesn't publish numbers comparing
> their thread performance to process performance?  Sure, you can find 
> context switch benchmarks where they have user level switching going on
> but those are a red herring.  The real numbers you want are the kernel
> level context switches and those are just as expensive as the process
> context switch numbers.

   If they weren't, I would be most amazed..

> -- 
> Larry McVoy   	 lm at bitmover.com         http://www.bitmover.com/lm 

/Matti Aarnio
