Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288465AbSAHWAg>; Tue, 8 Jan 2002 17:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288435AbSAHWA3>; Tue, 8 Jan 2002 17:00:29 -0500
Received: from zero.tech9.net ([209.61.188.187]:51976 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288460AbSAHV76>;
	Tue, 8 Jan 2002 16:59:58 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16O4FN-0000BI-00@starship.berlin>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
	<E16O3L5-0000B8-00@starship.berlin> <1010524653.3225.109.camel@phantasy> 
	<E16O4FN-0000BI-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 17:01:53 -0500
Message-Id: <1010527314.3229.146.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 16:57, Daniel Phillips wrote:

> > True (re spinlock weight in preemptible kernel) but how is that not
> > comparable to explicit scheduling points?  Worse, the preempt-kernel
> > typically does its preemption on a branch on return to interrupt
> > (similar to user space's preemption).  What better time to check and
> > reschedule if needed?
> 
> The per-spinlock cost I was refering to is the cost of the inc/dec per 
> spinlock.  I guess this cost is small enough as to be hard to measure, but
> I have not tried so I don't know.  Curiously, none of the people I've heard
> making pronouncements on the overhead of your preempt patch seem to have 
> measured it either.

;-)
 
If they did I suspect it would be minimal.  Andrew's point on complexity
and overhead in this manner is exact -- such thinks are just not an
issue.

I see two valid arguments against kernel preemption, and I'll be the
first to admit them:

- we introduce new problems with kernel programming.  specifically, the
issue with implicitly locked per-CPU data.  honestly, this isn't a huge
deal.  I've been working on preempt-kernel for awhile now and the
problems we have found and fixed are minimal.  admittedly, however,
especially wrt the future, preempt-kernel may introduce new concerns.  I
say let's rise to meet them.

- we don't do enough for the worst-case latency.  this is where future
work is useful and where preempt-kernel provides the framework for a
better kernel.

I want a better kernel.  Hell, I want the best kernel.  In my opinion,
one factor of that is having a preemptible kernel.

	Robert Love

