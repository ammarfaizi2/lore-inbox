Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265309AbSJXEWd>; Thu, 24 Oct 2002 00:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbSJXEWd>; Thu, 24 Oct 2002 00:22:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:39675 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265309AbSJXEWc>;
	Thu, 24 Oct 2002 00:22:32 -0400
Message-ID: <3DB776F5.C5AA1922@digeo.com>
Date: Wed, 23 Oct 2002 21:28:37 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.44-mm4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 04:28:37.0339 (UTC) FILETIME=[D25942B0:01C27B15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm4/

Having a few stability problems so most of the new things have been
removed.  Once this thing is working properly we can start moving
forward again.

If the people who had problem with -mm4 could please retest?  If
problems remain, please try popping off shpte-ng.patch.

Also be suspicious of CONFIG_PREEMPT=y.  For me, with preempt, smp
and spinlock debugging the kernel dies immediately doing an unlock
of already-unlocked kernel_flag when bringing up the first migration
thread.  That's on base 2.5.44.  May not be a preempt problem; could
be that preempt is simply exposing it.

+read-barrier-depends.patch

 RCU fix

+deferred-lru-add-fix.patch

 lru_cache_add fix

-for-each-cpu.patch

 Dropped.  Rusty has a different cpu iterator patch

-task-unmapped-base-fix.patch

 Folded into ingo-mmap-speedup

-larger-cpu-masks.patch
-adam-loop.patch
-rcu-stats.patch
-generic-nonlinear-mappings-D0.patch

 Over in experimental/

+md-01-driverfs-core.patch
+md-02-driverfs-topology.patch
+md-03-numa-meminfo.patch
+md-04-memblk_online_map.patch
+md-05-node_online_map.patch

 The NUMA driverfs interfaces from Matt Dobson.  Queued up in
 experimental/ too.  It all adds only a few hundred bytes to a
 non-NUMA build.
