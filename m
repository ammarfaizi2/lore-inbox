Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWCVXy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWCVXy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWCVXy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:54:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932421AbWCVXyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:54:55 -0500
Date: Wed, 22 Mar 2006 15:51:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: cpu scheduler merge plans
Message-Id: <20060322155122.2745649f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So it's that time again.  We need to decide which of the queued sched
patches should be merged into 2.6.17.

I have:

sched-fix-task-interactivity-calculation.patch
small-schedule-microoptimization.patch
#
sched-implement-smpnice.patch
sched-smpnice-apply-review-suggestions.patch
sched-smpnice-fix-average-load-per-run-queue-calculations.patch
sched-store-weighted-load-on-up.patch
sched-add-discrete-weighted-cpu-load-function.patch
sched-add-above-background-load-function.patch
# Suresh had problems
# con:
sched-cleanup_task_activated.patch
sched-make_task_noninteractive_use_sleep_type.patch
sched-dont_decrease_idle_sleep_avg.patch
sched-include_noninteractive_sleep_in_idle_detect.patch
sched-remove-on-runqueue-requeueing.patch
sched-activate-sched-batch-expired.patch
sched-reduce-overhead-of-calc_load.patch
#
sched-fix-interactive-task-starvation.patch
#
# "strange load balancing problems": pwil3058@bigpond.net.au
sched-new-sched-domain-for-representing-multi-core.patch
sched-fix-group-power-for-allnodes_domains.patch
x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch


I'm not sure what the "Suresh had problems" comment refers to - perhaps a
now-removed patch.

afaik, the load balancing problem which Peter observed remains unresolved.

Has smpnice had appropriate testing for regressions?
