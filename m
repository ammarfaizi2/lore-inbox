Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWCWBQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWCWBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWCWBQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:16:53 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:53758 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932219AbWCWBQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:16:52 -0500
Message-ID: <4421F702.5040609@bigpond.net.au>
Date: Thu, 23 Mar 2006 12:16:50 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: cpu scheduler merge plans
References: <20060322155122.2745649f.akpm@osdl.org>
In-Reply-To: <20060322155122.2745649f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 23 Mar 2006 01:16:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
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
> #
> # "strange load balancing problems": pwil3058@bigpond.net.au
> sched-new-sched-domain-for-representing-multi-core.patch
> sched-fix-group-power-for-allnodes_domains.patch
> x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch
> 
> 
> I'm not sure what the "Suresh had problems" comment refers to - perhaps a
> now-removed patch.
> 
> afaik, the load balancing problem which Peter observed remains unresolved.

I have not seen this problem on recent -mm kernels (-rc6-mm1 and
-rc6-mm2 even with SCHED_MC configured in) so it would appear that it's
fixed.  The only worrying thing is that we don't know what fixed it.

> 
> Has smpnice had appropriate testing for regressions?

There've been no reported problems for quite a while so my (biased)
answer would be "yes".

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce


