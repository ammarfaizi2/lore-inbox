Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUHSKmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUHSKmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUHSKmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:42:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:28292 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265106AbUHSKmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:42:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <1092911899.810.1.camel@krustophenia.net>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092902417.8432.108.camel@krustophenia.net>
	 <20040819084001.GA4098@elte.hu>
	 <1092905104.8432.116.camel@krustophenia.net>
	 <20040819085643.GA4751@elte.hu>  <1092911341.1739.1.camel@krustophenia.net>
	 <1092911899.810.1.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1092912215.810.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 06:43:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 06:38, Lee Revell wrote:
> On Thu, 2004-08-19 at 06:29, Lee Revell wrote:
> 
> > Yes, this takes care of it.  Now the dominant latency is the 142us
> > latency from the via-rhine driver, which is fixed by using the driver
> > from -mm (specifically it's fixed in bk-netdev.patch).
> > 
> 
> OK, this is a new one:
> 

This is the other common one:

preemption latency trace v1.0.1
-------------------------------
 latency: 74 us, entries: 9 (9)
    -----------------
    | task: XFree86/493, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: schedule+0x5b/0x590
 => ended at:   schedule+0x2f0/0x590
=======>
 0.000ms (+0.000ms): schedule (work_resched)
 0.000ms (+0.000ms): sched_clock (schedule)
 0.001ms (+0.001ms): dequeue_task (schedule)
 0.001ms (+0.000ms): recalc_task_prio (schedule)
 0.002ms (+0.000ms): effective_prio (recalc_task_prio)
 0.002ms (+0.000ms): enqueue_task (schedule)
 0.004ms (+0.002ms): __switch_to (schedule)
 0.072ms (+0.067ms): finish_task_switch (schedule)
 0.073ms (+0.000ms): sub_preempt_count (schedule)

Not sure what to make of this one.

Lee

