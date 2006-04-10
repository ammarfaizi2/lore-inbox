Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWDJSjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDJSjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDJSjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:39:13 -0400
Received: from xenotime.net ([66.160.160.81]:16830 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932098AbWDJSjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:39:12 -0400
Date: Mon, 10 Apr 2006 11:41:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] hugetlbfs doc. update
Message-Id: <20060410114126.a17b7e11.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix typos, spelling, etc., in Doc/vm/hugetlbpage.txt.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/vm/hugetlbpage.txt |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-2617-rc1.orig/Documentation/vm/hugetlbpage.txt
+++ linux-2617-rc1/Documentation/vm/hugetlbpage.txt
@@ -27,7 +27,7 @@ number of free hugetlb pages at any time
 the configured hugepage size - this is needed for generating the proper
 alignment and size of the arguments to the above system calls.
 
-The output of "cat /proc/meminfo" will have output like:
+The output of "cat /proc/meminfo" will have lines like:
 
 .....
 HugePages_Total: xxx
@@ -42,11 +42,11 @@ pages in the kernel.  Super user can dyn
 pre-configured) hugepages.
 The allocation (or deallocation) of hugetlb pages is possible only if there are
 enough physically contiguous free pages in system (freeing of hugepages is
-possible only if there are enough hugetlb pages free that can be transfered
+possible only if there are enough hugetlb pages free that can be transferred
 back to regular memory pool).
 
-Pages that are used as hugetlb pages are reserved inside the kernel and can
-not be used for other purposes.
+Pages that are used as hugetlb pages are reserved inside the kernel and cannot
+be used for other purposes.
 
 Once the kernel with Hugetlb page support is built and running, a user can
 use either the mmap system call or shared memory system calls to start using
@@ -60,7 +60,7 @@ Use the following command to dynamically
 This command will try to configure 20 hugepages in the system.  The success
 or failure of allocation depends on the amount of physically contiguous
 memory that is preset in system at this time.  System administrators may want
-to put this command in one of the local rc init file.  This will enable the
+to put this command in one of the local rc init files.  This will enable the
 kernel to request huge pages early in the boot process (when the possibility
 of getting physical contiguous pages is still very high).
 
@@ -78,8 +78,8 @@ the uid and gid of the current process a
 mode of root of file system to value & 0777.  This value is given in octal.
 By default the value 0755 is picked. The size option sets the maximum value of
 memory (huge pages) allowed for that filesystem (/mnt/huge). The size is
-rounded down to HPAGE_SIZE.  The option nr_inode sets the maximum number of
-inodes that /mnt/huge can use.  If the size or nr_inode options are not
+rounded down to HPAGE_SIZE.  The option nr_inodes sets the maximum number of
+inodes that /mnt/huge can use.  If the size or nr_inodes options are not
 provided on command line then no limits are set.  For size and nr_inodes
 options, you can use [G|g]/[M|m]/[K|k] to represent giga/mega/kilo. For
 example, size=2K has the same meaning as size=2048. An example is given at
@@ -88,7 +88,7 @@ the end of this document.
 read and write system calls are not supported on files that reside on hugetlb
 file systems.
 
-A regular chown, chgrp and chmod commands (with right permissions) could be
+Regular chown, chgrp, and chmod commands (with right permissions) could be
 used to change the file attributes on hugetlbfs.
 
 Also, it is important to note that no such mount command is required if the
@@ -96,8 +96,8 @@ applications are going to use only shmat
 wish to use hugetlb page via shared memory segment should be a member of
 a supplementary group and system admin needs to configure that gid into
 /proc/sys/vm/hugetlb_shm_group.  It is possible for same or different
-applications to use any combination of mmaps and shm* calls.  Though the
-mount of filesystem will be required for using mmaps.
+applications to use any combination of mmaps and shm* calls, though the
+mount of filesystem will be required for using mmap calls.
 
 *******************************************************************
 


---
