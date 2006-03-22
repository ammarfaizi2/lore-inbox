Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWCWALS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWCWALS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWCWAKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:10:48 -0500
Received: from bhhdoa.org.au ([65.98.99.88]:34063 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S964895AbWCWAFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:05:23 -0500
Message-ID: <1143068226.4421d6424ecf1@vds.kolivas.org>
Date: Thu, 23 Mar 2006 09:57:06 +1100
From: kernel@kolivas.org
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: cpu scheduler merge plans
References: <20060322155122.2745649f.akpm@osdl.org>
In-Reply-To: <20060322155122.2745649f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:

> 
> So it's that time again.  We need to decide which of the queued sched
> patches should be merged into 2.6.17.
> 
> I have:
> 
> sched-fix-task-interactivity-calculation.patch
> small-schedule-microoptimization.patch
> #
> sched-implement-smpnice.patch
> sched-smpnice-apply-review-suggestions.patch
> sched-smpnice-fix-average-load-per-run-queue-calculations.patch
> sched-store-weighted-load-on-up.patch
> sched-add-discrete-weighted-cpu-load-function.patch
> sched-add-above-background-load-function.patch
> # Suresh had problems
> # con:
> sched-cleanup_task_activated.patch
> sched-make_task_noninteractive_use_sleep_type.patch
> sched-dont_decrease_idle_sleep_avg.patch
> sched-include_noninteractive_sleep_in_idle_detect.patch
> sched-remove-on-runqueue-requeueing.patch
> sched-activate-sched-batch-expired.patch
> sched-reduce-overhead-of-calc_load.patch
> #
> sched-fix-interactive-task-starvation.patch

I'd like to see all of these up to this point go in. I can't comment on the
below directly.

> #
> # "strange load balancing problems": pwil3058@bigpond.net.au
> sched-new-sched-domain-for-representing-multi-core.patch
> sched-fix-group-power-for-allnodes_domains.patch
> x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch
> 
> 
> I'm not sure what the "Suresh had problems" comment refers to - perhaps a
> now-removed patch.

On previous versions of smp nice Suresh found some throughput issues. Peter has
addressed these as far as I'm aware, but we really need Suresh to check all
those again.
> 
> afaik, the load balancing problem which Peter observed remains unresolved.

That was a multicore enabled balancing problem which he reported went away on a
later -mm.

Cheers,
Con

