Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUJ1PQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUJ1PQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUJ1POW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:14:22 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:4906 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261169AbUJ1PJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:09:35 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Date: Thu, 28 Oct 2004 10:02:26 -0500
Message-ID: <OF167DB04B.77CF149C-ON86256F3B.00529EAD-86256F3B.00529EE5@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/28/2004 10:02:28 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built with V0.5.1 and on a relatively idle system saw a number
of traces with > 4000 entries, with a wide range of latencies.
For example:

lt001.v1k1/lt.00: latency: 98910 us, entries: 4000 (24040)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.01: latency: 4021 us, entries: 4000 (11139)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.02: latency: 6597 us, entries: 4000 (13361)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.03: latency: 8873 us, entries: 4000 (16109)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.04: latency: 9092 us, entries: 4000 (17525)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.05: latency: 10079 us, entries: 4000 (22351)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.06: latency: 1976 us, entries: 2148 (2148)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.07: latency: 50675 us, entries: 4000 (12102)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.08: latency: 2822 us, entries: 4000 (7318)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.09: latency: 5817 us, entries: 4000 (9574)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.10: latency: 10811 us, entries: 4000 (26175)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.11: latency: 2511 us, entries: 4000 (6204)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.12: latency: 9194 us, entries: 4000 (28039)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.13: latency: 12068 us, entries: 4000 (37143)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.14: latency: 36768 us, entries: 4000 (101483)   |   [VP:0
KP:1 SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.15: latency: 96154 us, entries: 4000 (21364)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.16: latency: 2759 us, entries: 4000 (7153)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.17: latency: 6653 us, entries: 4000 (15161)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.18: latency: 7322 us, entries: 4000 (12684)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.19: latency: 7440 us, entries: 4000 (15368)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]
lt001.v1k1/lt.20: latency: 13838 us, entries: 4000 (30923)   |   [VP:0 KP:1
SP:1 HP:1 #CPUS:2]

It did not take long to collect this information. These may be false
positives, here is the start of one example (note 00000000 for preempt
count in some of the lines).

preemption latency trace v1.0.7 on 2.6.9-mm1-RT-V0.5.1
-------------------------------------------------------
 latency: 1976 us, entries: 2148 (2148)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/3673, uid:0 nice:0 policy:1 rt_prio:50
    -----------------
 => started at: try_to_wake_up+0x1cc/0x330 <c011c1cc>
 => ended at:   finish_task_switch+0x41/0xc0 <c011c7e1>
=======>
80000000 0.000ms (+0.000ms): _spin_unlock (try_to_wake_up)
80000000 0.000ms (+0.000ms): (105) ((140))
80000000 0.000ms (+0.000ms): (6) ((0))
80000000 0.000ms (+0.000ms): resched_task (try_to_wake_up)
80000000 0.001ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
80000000 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000000 0.001ms (+0.000ms): preempt_schedule (cpu_idle)
80000000 0.002ms (+0.000ms): __sched_text_start (preempt_schedule)
80000000 0.002ms (+0.000ms): sched_clock (__sched_text_start)
80000000 0.002ms (+0.000ms): _spin_lock_irq (__sched_text_start)
80000000 0.003ms (+0.000ms): _spin_lock_irqsave (__sched_text_start)
80000000 0.003ms (+0.000ms): dequeue_task (__sched_text_start)
80000000 0.004ms (+0.000ms): recalc_task_prio (__sched_text_start)
80000000 0.004ms (+0.000ms): effective_prio (recalc_task_prio)
80000000 0.004ms (+0.000ms): enqueue_task (__sched_text_start)
80000000 0.005ms (+0.000ms): __switch_to (__sched_text_start)
80000000 0.005ms (+0.000ms): (0) ((6))
80000000 0.005ms (+0.000ms): (140) ((105))
80000000 0.006ms (+0.000ms): finish_task_switch (__sched_text_start)
80000000 0.006ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
80000000 0.006ms (+0.000ms): (6) ((105))
80000000 0.006ms (+0.000ms): _spin_lock (trace_stop_sched_switched)
80000000 0.007ms (+0.000ms): _spin_unlock (finish_task_switch)
80000000 0.007ms (+0.000ms): _spin_unlock_irq (finish_task_switch)
00000000 0.008ms (+0.000ms): _do_softirq (ksoftirqd)
80000000 0.008ms (+0.000ms): ___do_softirq (_do_softirq)
00000000 0.008ms (+0.000ms): run_timer_softirq (___do_softirq)
... ends like this ...
80000000 1.856ms (+0.000ms): rwsem_owner_del (__up_write)
80000000 1.857ms (+0.000ms): _spin_unlock (__up_write)
80000000 1.857ms (+0.000ms): _spin_unlock (__up_write)
00000000 1.858ms (+0.000ms): up (real_lookup)
00000000 1.858ms (+0.000ms): _up_write (up)
00000000 1.858ms (+0.000ms): __up_write (_up_write)
80000000 1.859ms (+0.000ms): _spin_lock (__up_write)
80000000 1.859ms (+0.000ms): _spin_lock (__up_write)
80000000 1.860ms (+0.000ms): rwsem_owner_del (__up_write)
80000000 1.861ms (+0.000ms): _spin_unlock (__up_write)
80000000 1.861ms (+0.000ms): _spin_unlock (__up_write)
00000000 1.862ms (+0.001ms): follow_mount (link_path_walk)
00000000 1.863ms (+33179.004ms): dput (link_path_walk)

I haven't run the stress tests yet but will send the system log
and these traces in a separate message so you can see what I'm seeing.

  --Mark

