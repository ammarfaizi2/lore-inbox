Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSGJNme>; Wed, 10 Jul 2002 09:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGJNmd>; Wed, 10 Jul 2002 09:42:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47866 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315191AbSGJNmd>;
	Wed, 10 Jul 2002 09:42:33 -0400
Date: Wed, 10 Jul 2002 19:19:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net
Subject: [OLS] RCU latency measurements
Message-ID: <20020710191903.A1915@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is again a summary of what was presented at the OLS 2002
RCU paper.

One other aspect of different RCU implementations that we have
been investigating is the update latency. That is, how long
it takes to complete the grace period and do the actual update.
Long latencies could result in system running out of memory.
I measured this for 3 different RCU implementations - rcu_poll,
rcu_ltimer and rcu_sched against varying number of clients in
dbench with the lockfree dcache lookup patch using RCU for dentries.

The results can be seen in the following graph -
http://lse.sourceforge.net/locking/ols2002/rcu/results/latency/latency.png
It is logscale on y axis, in case you don't notice it.

The patches are same as the ones used in overhead measurements -
http://lse.sourceforge.net/locking/ols2002/rcu/patches/

1. rcu_poll, with its forced reschedule and aggressive
polling, shows the best latency.

2. The latencies for all these RCU implementations remain
reasonably flat under increased load.

Comments/suggestions ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
