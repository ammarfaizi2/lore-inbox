Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284836AbRLURSB>; Fri, 21 Dec 2001 12:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284850AbRLURRw>; Fri, 21 Dec 2001 12:17:52 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:267 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284836AbRLURRj>; Fri, 21 Dec 2001 12:17:39 -0500
Date: Fri, 21 Dec 2001 09:19:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011221090014.A1103@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0112210916110.1454-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Mike Kravetz wrote:

> On Thu, Dec 20, 2001 at 02:57:55PM -0800, Davide Libenzi wrote:
> > On 21 Dec 2001, Momchil Velikov wrote:
> > >
> > > I'd like to second that, IMHO the RT task scheduling should trade
> > > throughput for latency, and if someone wants priority inversion, let
> > > him explicitly request it.
> >
> > No a great performance loss anyway. It's zero performance loss if the CPU
> > that has ran the woke up RT task for the last time is not running another
> > RT task ( very probable ). If the last CPU of the woke up task is running
> > another RT task a CPU discovery loop ( like the current scheduler ) must
> > be triggered. Not a great deal anyway.
>
> Some time back, I asked if anyone had any RT benchmarks and got
> little response.  Performance (latency) degradation for RT tasks
> while implementing new schedulers was my concern.  Does anyone
> have ideas about how we should measure/benchmark this?  My
> 'solution' at the time was to take a scheduler heavy benchmark
> like reflex, and simply make all the tasks RT.  This wasn't very
> 'real world', but at least it did allow me to compare scheduler
> overhead in the RT paths of various scheduler implementations.

Mike, a better real world test would be to have a variable system runqueue
load with the wakeup of an rt task and measuring the latency of the rt
task under various loads.
This can be easily implemented with cpuhog ( that load the runqueue ) plus
the LatSched ( scheduler latency sampler ) that will measure the exact
latency in CPU cycles.




- Davide


