Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUHPFsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUHPFsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUHPFsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:48:25 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28349 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267449AbUHPFsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:48:02 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816050248.GA16522@elte.hu>
References: <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092630122.810.25.camel@krustophenia.net>
	 <20040816043302.GA14979@elte.hu> <1092632236.801.1.camel@krustophenia.net>
	 <20040816050248.GA16522@elte.hu>
Content-Type: text/plain
Message-Id: <1092635332.793.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 01:48:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 01:02, Ingo Molnar wrote:
> yeah. If it's the first chunk then we could perhaps avoid it by doing it
> outside of the lock.
> 

Hmm, this is odd:

preemption latency trace v1.0
-----------------------------
 latency: 71 us, entries: 6 (6)
 process: XFree86/518, uid: 0
 nice: -10, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): sched_clock (schedule)
 0.000ms (+0.000ms): deactivate_task (schedule)
 0.000ms (+0.000ms): dequeue_task (deactivate_task)
 0.001ms (+0.000ms): __switch_to (schedule)
 0.068ms (+0.066ms): finish_task_switch (schedule)
 0.069ms (+0.000ms): check_preempt_timing (sub_preempt_count)

Lee

