Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVAKD4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVAKD4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAKDzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:55:46 -0500
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:4299 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S262441AbVAKDxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:53:41 -0500
Message-ID: <41E34DBD.3050804@bigpond.net.au>
Date: Tue, 11 Jan 2005 14:53:33 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jake Moilanen <moilanen@austin.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: [PATCH] V-6.1 ZAPHOD Single Priority Array O(1) CPU Scheduler
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 6.1 of the ZAPHOD single priority array scheduler patches for
the 2.6.10 kernel are now available for download and evaluation from:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.10-spa_zaphod_FULL-v6.1?download>

This contains the extra per runqueue CPU statistics for improving GA 
fitness functions that we discussed.

struct runq_cpustats {
#ifdef CONFIG_SMP
	unsigned long long timestamp_last_tick;
#endif
	unsigned long long total_delay;
	unsigned long long total_rt_delay;
	unsigned long long total_intr_delay;
	unsigned long long total_fork_delay;
	unsigned long long total_sinbin;
};

total_delay - is total time spent by tasks waiting for CPU on this runqueue
total_rt_delay - as for total_delay but only for real time tasks
total_intr_delay - is total time spent by tasks waiting for CPU on this 
runqueue after being woken to service an interrupt
total_fork_delay - is total time spent by tasks waiting for CPU on this 
runqueue for their first time slice after forking

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
