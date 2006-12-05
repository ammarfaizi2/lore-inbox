Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031500AbWLEVSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031500AbWLEVSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031519AbWLEVSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:18:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33716 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031500AbWLEVSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:18:07 -0500
Date: Tue, 5 Dec 2006 22:17:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20, scheduler bits
Message-ID: <20061205211723.GA7169@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0049]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> schedc-correct-comment-for-this_rq_lock-routine.patch
> sched-fix-migration-cost-estimator.patch
> sched-domain-move-sched-group-allocations-to-percpu-area.patch

(already acked)

> move_task_off_dead_cpu-should-be-called-with-disabled-ints.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-domain-increase-the-smt-busy-rebalance-interval.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-avoid-taking-rq-lock-in-wake_priority_sleeper.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-remove-staggering-of-load-balancing.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-disable-interrupts-for-locking-in-load_balance.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-extract-load-calculation-from-rebalance_tick.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-move-idle-status-calculation-into-rebalance_tick.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-use-softirq-for-load-balancing.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-call-tasklet-less-frequently.patch

patch is misnamed, otherwise:

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-add-option-to-serialize-load-balancing.patch
> sched-add-option-to-serialize-load-balancing-fix.patch

(please merge these two patches into one, the first one is not 
bisectable.)

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-improve-migration-accuracy.patch
> sched-improve-migration-accuracy-tidy.patch
> sched-improve-migration-accuracy-fix.patch

please merge into one patch.

Acked-by: Ingo Molnar <mingo@elte.hu>

> sched-decrease-number-of-load-balances.patch

this one goes away as per Ken's observation.

> sched-optimize-activate_task-for-rt-task.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

> kernel-schedc-whitespace-cleanups.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

i dont like these:

-               cost1 += measure_one(cache, size - i*1024, cpu1, cpu2);
+               cost1 += measure_one(cache, size - i * 1024, cpu1, cpu2);

as it's quite OK to have no spaces in "i*1024", just to indicate 
precedence of arithmetic ops. But the good bits dominate in this patch 
so lets have it and i'll undo the bad ones.

> kernel-schedc-whitespace-cleanups-more.patch

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
