Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284731AbRLURfB>; Fri, 21 Dec 2001 12:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284874AbRLURev>; Fri, 21 Dec 2001 12:34:51 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:14585 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284731AbRLURei>; Fri, 21 Dec 2001 12:34:38 -0500
Date: Fri, 21 Dec 2001 09:33:21 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011221093321.B1103@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011221090014.A1103@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0112210916110.1454-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112210916110.1454-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Dec 21, 2001 at 09:19:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 09:19:04AM -0800, Davide Libenzi wrote:
> On Fri, 21 Dec 2001, Mike Kravetz wrote:
> 
> > Some time back, I asked if anyone had any RT benchmarks and got
> > little response.  Performance (latency) degradation for RT tasks
> > while implementing new schedulers was my concern.  Does anyone
> > have ideas about how we should measure/benchmark this?  My
> > 'solution' at the time was to take a scheduler heavy benchmark
> > like reflex, and simply make all the tasks RT.  This wasn't very
> > 'real world', but at least it did allow me to compare scheduler
> > overhead in the RT paths of various scheduler implementations.
> 
> Mike, a better real world test would be to have a variable system runqueue
> load with the wakeup of an rt task and measuring the latency of the rt
> task under various loads.
> This can be easily implemented with cpuhog ( that load the runqueue ) plus
> the LatSched ( scheduler latency sampler ) that will measure the exact
> latency in CPU cycles.

Right!  Any ideas on variable system runqueue load?  Should those
other tasks be RT or OTHER? a mix?  I would suspect that we would
want multiple RT tasks on the runqueue or at least in the system
(otherwise why worry about global semantics?).

However, I would feel better about this if someone had a real world
load involving RT tasks on a SMP system.  At least then we could try
to simulate a load someone cares about.

-- 
Mike
