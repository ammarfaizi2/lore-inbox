Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUHGBpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUHGBpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 21:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUHGBpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 21:45:13 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:27280 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S265792AbUHGBpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 21:45:04 -0400
Message-ID: <41143419.6000407@bigpond.net.au>
Date: Sat, 07 Aug 2004 11:44:57 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>
Subject: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3.1 of the various single priority array scheduler patches for 
2.6.7, 2.6.8-rc2 and 2.6.8-rc3 kernels are now available for evaluation.

This is a bug fix release to fix a problem caused by sched_clock() not 
being monotonic.  This meant that when measuring small time intervals by 
taking the difference between successive calls to sched_clock() there is 
a possibility of obtaining a negative value (or, as unsigned long longs 
are being used, a very big one).  One unfortunate consequence of this is 
that adding to non zero intervals together could lead to a zero result 
and possible divide by zero problems.


1. [ZAPHOD] Runtime selectable choice between a priority based or 
entitlement based O(1) scheduler with active/expired arrays replaced by 
a single array and an O(1) promotion mechanism plus scheduling 
statistics with new interactive bonus mechanism and throughput bonus 
mechanism:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_zaphod_FULL-v3.1?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_zaphod_FULL-v3.1?download>
2.6.8-rc3 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc3-spa_zaphod_FULL-v3.1?download>

2. Slightly modified version of Con Kolivas's staircase O(1) scheduler 
with active/expired arrays replaced by a single array and an O(1) 
promotion mechanism:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_sc_FULL-v3.1?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_sc_FULL-v3.1?download>
2.6.8-rc3 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc3-spa_sc_FULL-v3.1?download>

3. [HYDRA] Runtime selection between staircase, priority based and 
entitlement based O(1) schedulers:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v3.1?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_hydra_FULL-v3.1?download>
2.6.8-rc3 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc3-spa_hydra_FULL-v3.1?download>

Other schedulers are also available from 
<https://sourceforge.net/projects/cpuse/>

So as not to interfere with the staircase scheduler's evaluation I do 
not propose to release patches for rc3-mm kernels unless requested.

I'm in the process of simplifying my schedulers (I got carried away with 
the theory) in order to reduce their overhead and hope to release a new 
slimmer version early next week.  Also on the "to do" list are CPU rate 
caps.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

