Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWDFDZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWDFDZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWDFDZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:25:10 -0400
Received: from dvhart.com ([64.146.134.43]:36806 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750861AbWDFDZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:25:09 -0400
From: Darren Hart <darren@dvhart.com>
To: linux-kernel@vger.kernel.org
Subject: RT task scheduling
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Date: Wed, 5 Apr 2006 20:25:04 -0700
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604052025.05679.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My last mail specifically addresses preempt-rt, but I'd like to know people's 
thoughts regarding this issue in the mainline kernel.  Please see my previous 
post "realtime-preempt scheduling - rt_overload behavior" for a testcase that 
produces unpredictable scheduling results.

Part of the issue here is to define what we consider "correct behavior" for 
SCHED_FIFO realtime tasks.  Do we (A) need to strive for "strict realtime 
priority scheduling" where the NR_CPUS highest priority runnable SCHED_FIFO 
tasks are _always_ running?  Or do we (B) take the best effort approach with 
an upper limit RT priority imbalances, where an imbalance may occur (say at 
wakeup or exit) but will be remedied within 1 tick.  The smpnice patches 
improve load balancing, but don't provide (A).

More details in the previous mail...

Thanks,

--Darren
