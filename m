Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTBYCAj>; Mon, 24 Feb 2003 21:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTBYCAj>; Mon, 24 Feb 2003 21:00:39 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:7810 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S265355AbTBYCAi>; Mon, 24 Feb 2003 21:00:38 -0500
Date: Mon, 24 Feb 2003 18:07:30 -0800
To: yodaiken@fsmlabs.com
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lm@work.bitmover.com, mbligh@aracnet.com, davidsen@tmr.com,
       greearb@candelatech.com, linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225020730.GA4507@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085031.GP10411@holomorphy.com> <20030224091758.A11805@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224091758.A11805@hq.fsmlabs.com>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 09:17:58AM -0700, yodaiken@fsmlabs.com wrote:
> On Mon, Feb 24, 2003 at 12:50:31AM -0800, William Lee Irwin III wrote:
> > There's a vague notion in my head that it should decrease scheduling
> 
> Vague notions seems to be the level of data on this topic.

Ok, replace "vague notion" with latency and scheduling concepts that
everybody else except you understands and you'll be a bit more relevant.

It's not even about IO system, it's about a consumer-producer relationships
between threads and some kind of IPC generic mechanism. You'd run into
the same problems by having two threads communicating in a priorty capable
scheduler, since the temporal granualarity of "things that the scheduler
manages" gets clobbered but inheritently brain damaged locking.

Say, how would the scheduler properly order the priority relationships for
non-preemptable thread that holds that critical section for 100ms under
an extreme (or normal) case ?

The effectiveness of the scheduler in these cases would be meaningless.
Shit, just replace that SOB with a stocastic-insert-round-robin system and
it'll be just as effective if this current state of Linux locking stays
in place. There's probably more truth than exaggeration from what I've
seen both in the code and running Linux as a desktop OS.

> Victor Yodaiken 

bill


