Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284950AbRLUS1r>; Fri, 21 Dec 2001 13:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284951AbRLUS1g>; Fri, 21 Dec 2001 13:27:36 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:25611 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284950AbRLUS1P>; Fri, 21 Dec 2001 13:27:15 -0500
Date: Fri, 21 Dec 2001 10:29:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011221093321.B1103@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0112211024390.1454-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Mike Kravetz wrote:

> On Fri, Dec 21, 2001 at 09:19:04AM -0800, Davide Libenzi wrote:
> > On Fri, 21 Dec 2001, Mike Kravetz wrote:
> >
> > > Some time back, I asked if anyone had any RT benchmarks and got
> > > little response.  Performance (latency) degradation for RT tasks
> > > while implementing new schedulers was my concern.  Does anyone
> > > have ideas about how we should measure/benchmark this?  My
> > > 'solution' at the time was to take a scheduler heavy benchmark
> > > like reflex, and simply make all the tasks RT.  This wasn't very
> > > 'real world', but at least it did allow me to compare scheduler
> > > overhead in the RT paths of various scheduler implementations.
> >
> > Mike, a better real world test would be to have a variable system runqueue
> > load with the wakeup of an rt task and measuring the latency of the rt
> > task under various loads.
> > This can be easily implemented with cpuhog ( that load the runqueue ) plus
> > the LatSched ( scheduler latency sampler ) that will measure the exact
> > latency in CPU cycles.
>
> Right!  Any ideas on variable system runqueue load?  Should those
> other tasks be RT or OTHER? a mix?  I would suspect that we would
> want multiple RT tasks on the runqueue or at least in the system
> (otherwise why worry about global semantics?).
>
> However, I would feel better about this if someone had a real world
> load involving RT tasks on a SMP system.  At least then we could try
> to simulate a load someone cares about.

In my tests i stop the run queue load to 8 ( per cpu ) now coz higher
values are somehow unusual.
A good plot should also have a third dimension that is the number of real
time tasks running.
I guess i've to take a better look at gnuplot docs for 3d graphs :)



- Davide


