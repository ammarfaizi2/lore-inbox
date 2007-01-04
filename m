Return-Path: <linux-kernel-owner+w=401wt.eu-S1751067AbXADCOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbXADCOt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 21:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXADCOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 21:14:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:8467 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbXADCOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 21:14:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="32737316:sNHT20035386"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Date: Wed, 3 Jan 2007 18:14:11 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C01A4FC37@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <20070104012709.GC31943@gnuppy.monkey.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Thread-Index: Accvn5kd6FyeLx+yQ5Kb9puf/7bXTwABkKhg
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Bill Huey \(hui\)" <billh@gnuppy.monkey.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 04 Jan 2007 02:14:12.0727 (UTC) FILETIME=[06B9E070:01C72FA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> This should have the fix.
> 
>
http://mmlinux.sf.net/public/patch-2.6.20-rc2-rt2.3.lock_stat.patch
> 
> If you can rerun it and post the results, it'll hopefully show the
> behavior of that lock acquisition better.
> 

Here's the run with fix to produce correct statistics.

Tim

@contention events = 848858
@failure_events = 10
@lookup_failed_scope = 175
@lookup_failed_static = 47
@static_found = 17
[2, 0, 0 -- 1, 0]               {journal_init_common, fs/jbd/journal.c,
667}
[2, 0, 0 -- 31, 0]              {blk_init_queue_node, block/ll_rw_blk.c,
1910}
[2, 0, 0 -- 31, 0]              {create_workqueue_thread,
kernel/workqueue.c, 474}
[3, 3, 2 -- 16384, 0]           {tcp_init, net/ipv4/tcp.c, 2426}
[4, 4, 1 -- 1, 0]               {lock_kernel, -, 0}
[19, 0, 0 -- 1, 0]              {kmem_cache_alloc, -, 0}
[25, 0, 0 -- 1, 0]              {kfree, -, 0}
[49, 0, 0 -- 2, 0]              {kmem_cache_free, -, 0}
[69, 38, 176 -- 1, 0]           {lock_timer_base, -, 0}
[211, 117, 517 -- 3, 0]         {init_timers_cpu, kernel/timer.c, 1842}
[1540, 778, 365 -- 7326, 0]             {sock_lock_init,
net/core/sock.c, 817}
[112584, 150, 6 -- 256, 0]              {init, kernel/futex.c, 2781}
[597012, 183895, 136277 -- 9546, 0]             {mm_init, kernel/fork.c,
369}
