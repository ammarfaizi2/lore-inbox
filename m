Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUG2UyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUG2UyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUG2UmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:42:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53656 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265264AbUG2Uj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:39:57 -0400
Date: Thu, 29 Jul 2004 22:26:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729202629.GC468@openzaurus.ucw.cz>
References: <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722074034.GC7553@elte.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i did not say latency sources, i said unpredictable latency sources. 
> hardirq and softirq processing introduces near arbitrary latency at any
> (irqs-enabled) point in the kernel. Hence they make all kernel code
> unbound in essence - even the most trivial kernel code, sys_getpid().
...
> [the only remaining source of 'latency uncertainty' is the small
> asynchronous hardirq stub that would still remain. This has an effect
> that can be compared to e.g. cache effects and it cannot become unbound
> unless the CPU is bombarded with a very high number of interrupts.]

Well, I do not follow you I guess.

With large-enough number of hardirqs you do no progress at all.

Even if only "sane" number of irqs, if they all decide to hit within one
getpid(), this getpid is going to take quite long....
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

