Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSKKGXE>; Mon, 11 Nov 2002 01:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265581AbSKKGXE>; Mon, 11 Nov 2002 01:23:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:21708 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265568AbSKKGXD>;
	Mon, 11 Nov 2002 01:23:03 -0500
Message-ID: <3DCF4E57.AA92B134@digeo.com>
Date: Sun, 10 Nov 2002 22:29:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.47-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 06:29:43.0938 (UTC) FILETIME=[B903C620:01C2894B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.47/2.5.47-mm1/

Nothing much new here, except for the rbtree-based IO scheduler.
This needs a lot of benching please.

And reiserfs doesn't immediately oops this time.



Since 2.5.46-mm2:

-genksyms-hurts.patch

 Wrong, dropped.

-misc.patch
-writev-bad-seg-fix.patch
-wli-01-iowait.patch
-wli-02-zap_hugetlb_resources.patch
-wli-03-remove-unlink_vma.patch
-wli-04-internalize-hugetlb-init.patch
-wli-05-sysctl-cleanup.patch
-wli-06-cleanup-proc.patch
-wli-07-hugetlb-static.patch
-msec-fix.patch
-touch_buffer-fix.patch
-pgalloc-accounting-fix.patch
-nuke-disk-stats.patch

 Merged

+genksyms-fix.patch

 Really fix the exporting of per-cpu data to modules with modversioning.

+buffer-debug.patch

 Add some printk's to catch what appears to be a blockdev pagecache invalidation
 problem.

+mbcache-cleanup.patch

 Some fs/mbcache work from Andreas, in for some testing.

+ip6-mcast-timer.patch

 Init a timer in ipv6

+reiserfs-readpages-fix.patch

 Fix reiserfs3

+swapcache-throttle.patch

 Random change to VM throttling which doesn't do much.
