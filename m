Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVKCP0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVKCP0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKCP0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:26:09 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:34921 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1030273AbVKCP0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:26:08 -0500
Date: Thu, 03 Nov 2005 17:25:44 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH] perform maintenance on Documentation/vm/hugetlbpage.txt
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, muli@il.ibm.com
Message-id: <20051103152544.GF31790@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following updates to
Documentation/vm/hugetlbpage.txt: 

- there's no need to select HUGETLB_PAGE manually and it's no longer
under the processor menu. Update the text accordingly.
- fix typos and trim trailing whitespace.

Please apply...

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>

Cheers,
Muli
---

diff -r 1c8a2bbe228fb4553cf46e812942865e333434df -r 07d03d8f01090efaece445637354bc0f9daec26d Documentation/vm/hugetlbpage.txt
--- a/Documentation/vm/hugetlbpage.txt	Wed Nov  2 05:58:06 2005
+++ b/Documentation/vm/hugetlbpage.txt	Thu Nov  3 15:17:25 2005
@@ -13,12 +13,13 @@
 Users can use the huge page support in Linux kernel by either using the mmap
 system call or standard SYSv shared memory system calls (shmget, shmat).
 
-First the Linux kernel needs to be built with CONFIG_HUGETLB_PAGE (present
-under Processor types and feature)  and CONFIG_HUGETLBFS (present under file
-system option on config menu) config options.
+First the Linux kernel needs to be built with the CONFIG_HUGETLBFS
+(present under "File systems") and CONFIG_HUGETLB_PAGE (selected
+automatically when CONFIG_HUGETLBFS is selected) configuration
+options.
 
 The kernel built with hugepage support should show the number of configured
-hugepages in the system by running the "cat /proc/meminfo" command.  
+hugepages in the system by running the "cat /proc/meminfo" command.
 
 /proc/meminfo also provides information about the total number of hugetlb
 pages configured in the kernel.  It also displays information about the
@@ -38,19 +39,19 @@
 
 /proc/sys/vm/nr_hugepages indicates the current number of configured hugetlb
 pages in the kernel.  Super user can dynamically request more (or free some
-pre-configured) hugepages. 
-The allocation( or deallocation) of hugetlb pages is posible only if there are
+pre-configured) hugepages.
+The allocation (or deallocation) of hugetlb pages is possible only if there are
 enough physically contiguous free pages in system (freeing of hugepages is
-possible only if there are enough hugetlb pages free that can be transfered 
+possible only if there are enough hugetlb pages free that can be transfered
 back to regular memory pool).
 
 Pages that are used as hugetlb pages are reserved inside the kernel and can
-not be used for other purposes. 
+not be used for other purposes.
 
 Once the kernel with Hugetlb page support is built and running, a user can
 use either the mmap system call or shared memory system calls to start using
 the huge pages.  It is required that the system administrator preallocate
-enough memory for huge page purposes.  
+enough memory for huge page purposes.
 
 Use the following command to dynamically allocate/deallocate hugepages:
 
@@ -80,9 +81,9 @@
 rounded down to HPAGE_SIZE.  The option nr_inode sets the maximum number of
 inodes that /mnt/huge can use.  If the size or nr_inode options are not
 provided on command line then no limits are set.  For size and nr_inodes
-options, you can use [G|g]/[M|m]/[K|k] to represent giga/mega/kilo. For 
-example, size=2K has the same meaning as size=2048. An example is given at 
-the end of this document. 
+options, you can use [G|g]/[M|m]/[K|k] to represent giga/mega/kilo. For
+example, size=2K has the same meaning as size=2048. An example is given at
+the end of this document.
 
 read and write system calls are not supported on files that reside on hugetlb
 file systems.

-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

