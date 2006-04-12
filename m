Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWDLRtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWDLRtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWDLRtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:49:43 -0400
Received: from xenotime.net ([66.160.160.81]:35767 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932297AbWDLRtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:49:39 -0400
Date: Wed, 12 Apr 2006 10:52:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, wli@holomorphy.com
Subject: [PATCH] Doc; vm/hugetlbpage update-2
Message-Id: <20060412105206.41a3521c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add new line of /proc/meminfo output.
Explain the HugePage_ lines in /proc/meminfo (from Bill Irwin).
Change KB to kB since the latter is what is used in the kernel.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/vm/hugetlbpage.txt |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- linux-2617-rc1.orig/Documentation/vm/hugetlbpage.txt
+++ linux-2617-rc1/Documentation/vm/hugetlbpage.txt
@@ -32,7 +32,16 @@ The output of "cat /proc/meminfo" will h
 .....
 HugePages_Total: xxx
 HugePages_Free:  yyy
-Hugepagesize:    zzz KB
+HugePages_Rsvd:  www
+Hugepagesize:    zzz kB
+
+where:
+HugePages_Total is the size of the pool of hugepages.
+HugePages_Free is the number of hugepages in the pool that are not yet
+allocated.
+HugePages_Rsvd is short for "reserved," and is the number of hugepages
+for which a commitment to allocate from the pool has been made, but no
+allocation has yet been made. It's vaguely analogous to overcommit.
 
 /proc/filesystems should also show a filesystem of type "hugetlbfs" configured
 in the kernel.


---
~Randy
