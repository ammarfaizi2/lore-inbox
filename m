Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289533AbSAOMmL>; Tue, 15 Jan 2002 07:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289536AbSAOMmE>; Tue, 15 Jan 2002 07:42:04 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:33289 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S289533AbSAOMlw>;
	Tue, 15 Jan 2002 07:41:52 -0500
Date: Tue, 15 Jan 2002 05:39:01 -0700
From: yodaiken@fsmlabs.com
To: george anzinger <george@mvista.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, yodaiken@fsmlabs.com,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020115053901.C32605@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <87k7ukyjme.fsf@fadata.bg> <20020114030925.A1363@viejo.fsmlabs.com> <E16QC5P-0000nO-00@starship.berlin> <3C439D02.EBCD78C4@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C439D02.EBCD78C4@mvista.com>; from george@mvista.com on Mon, Jan 14, 2002 at 07:07:46PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 07:07:46PM -0800, george anzinger wrote:
> Daniel Phillips wrote:
> > 
> > On January 14, 2002 10:09 am, yodaiken@fsmlabs.com wrote:
> > > UNIX generally tries to ensure liveness. So you know that
> > >       cat lkarchive | grep feel | wc
> > > will complete and not just that, it will run pretty reasonably because
> > > for UNIX _every_ process is important and gets cpu and IO time.
> > > When you start trying to add special low latency tasks, you endanger
> > > liveness.  And preempt is especially corrosive because one of the
> > > mechanisms UNIX uses to assure liveness is to make sure that once a
> > > process starts it can do a significant chunk of work.
> > 
> If I read this right, your complaint is not with preemption but with
> scheduler policy.  Clearly both are needed to "assure liveness". 

You are right: I think however "preemption" is part of
a package of ideas about how the system should work. 
So it would probably be better to separate these issues out

> Another way of looking at preemption is that is enables a more
> responsive and nimble scheduler policy (afterall it is the scheduler
> that decided that task A should give way to task B.  All preemption does
> is to allow that to happen with greater dispatch.)  Given that, we can
> then discuss what scheduler policy should be.

If you would write this as 
	Another way of looking at preemption is that it is intended
	to enable a more responsive ...
then we would be off to a good start in narrowing the discussion.
My reservation about preemption as an implementation technique is that
it has costs, which seem to be not easily boundable, but not very 
clear benefits.


> -- 
> George           george@mvista.com
> High-res-timers: http://sourceforge.net/projects/high-res-timers/
> Real time sched: http://sourceforge.net/projects/rtsched/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

