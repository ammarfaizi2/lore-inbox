Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVG0QEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVG0QEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVG0QCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 12:02:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38838 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262405AbVG0P6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:58:20 -0400
Subject: [patch] inotify: ia64 syscalls.
From: Robert Love <rml@novell.com>
To: tony.luck@intel.com
Cc: The Cutch <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 11:58:17 -0400
Message-Id: <1122479897.21253.160.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony.

Attached patch adds the inotify syscalls to ia64.

Signed-off-by: Robert Love <rml@novell.com>

 arch/ia64/kernel/entry.S  |    6 +++---
 include/asm-ia64/unistd.h |    3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff -urN linux-2.6.13-rc3-git8/arch/ia64/kernel/entry.S linux/arch/ia64/kernel/entry.S
--- linux-2.6.13-rc3-git8/arch/ia64/kernel/entry.S	2005-07-27 10:59:31.000000000 -0400
+++ linux/arch/ia64/kernel/entry.S	2005-07-27 11:51:20.000000000 -0400
@@ -1574,8 +1574,8 @@
 	data8 sys_ioprio_set
 	data8 sys_ioprio_get			// 1275
 	data8 sys_set_zone_reclaim
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+	data8 sys_inotify_init
+	data8 sys_inotify_add_watch
+	data8 sys_inotify_rm_watch
 
 	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
diff -urN linux-2.6.13-rc3-git8/include/asm-ia64/unistd.h linux/include/asm-ia64/unistd.h
--- linux-2.6.13-rc3-git8/include/asm-ia64/unistd.h	2005-07-27 10:59:32.000000000 -0400
+++ linux/include/asm-ia64/unistd.h	2005-07-27 11:56:43.000000000 -0400
@@ -266,6 +266,9 @@
 #define __NR_ioprio_set			1274
 #define __NR_ioprio_get			1275
 #define __NR_set_zone_reclaim		1276
+#define __NR_inotify_init		1277
+#define __NR_inotify_add_watch		1278
+#define __NR_inotify_rm_watch		1279
 
 #ifdef __KERNEL__
 


