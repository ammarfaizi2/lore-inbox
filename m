Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287166AbRL2JNZ>; Sat, 29 Dec 2001 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287167AbRL2JNP>; Sat, 29 Dec 2001 04:13:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:15349 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S287166AbRL2JNE>; Sat, 29 Dec 2001 04:13:04 -0500
Message-ID: <3C2D890E.BBDE7C09@mvista.com>
Date: Sat, 29 Dec 2001 01:12:46 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: knobi@knobisoft.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <3C2C3F55.3BA4A0C3@sirius-cafe.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> 
> > Re: [RFC] Scheduler issue 1, RT tasks ...
> >
> > >
> > > Right, that was my question. George says, in your words, "for better
> >
> > > standards compliancy ..." and I want to know why you guys think
> > that.
> >
> > The thought was that if someone need RT tasks he probably need a very
> > low
> > latency and so the idea that by applying global preemption decisions
> > would
> > lead to a better compliancy. But i'll be happy to ear that this is
> > false
> > anyway ...
> >
> 
>  without wanting to start a RT flame-fest, what do people really want
> when they talk about RT in this [Linux] context:
> 
> - very low latency
> - deterministic latency ("never to exceed")
> - both
> - something completely different
> 
All of the above from time to time and user to user.  That is, some
folks want one or more of the above, some folks want more, some less. 
What is really up?  Well they have a job to do that requires certain
things.  Different jobs require different capabilities.  It is hard to
say that any given system will do a reasonably complex job with out
testing.  For example we may have the required latency but find the
system fails because, to get the latency, we preempted another task that
was (and so still is) in the middle of updating something we need to
complete the job.

On the other hand, some things clearly are in the way of doing some real
time tasks in a timely fashion.  Among these things are long context
switch latency, high kernel overhead, and low resolution time keeping/
alarms.  So we talk (argue? posture?) most about these.  At the same
time all the other bullet items of *nix systems are, at least some
times, important.

Why Linux?  The same reasons it is used any where else.  Among these
reasons is the desire to have to know and support only one system.  Thus
the drive to extend it to the more responsive end of the spectrum
without loosing other capabilities.  And, of course, the standards issue
is in here.  Standards compliance is important from an investment point
of view.  It allows the user to move his costly (far more than the
hardware) software investment from one kernel/ system to another with
little or no rework.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
