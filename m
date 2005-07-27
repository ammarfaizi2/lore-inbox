Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVG0PsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVG0PsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVG0Pra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:47:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29110 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262344AbVG0PpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:45:07 -0400
Subject: [patch] inotify: ppc32 syscalls.
From: Robert Love <rml@novell.com>
To: paulus@samba.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, The Cutch <ttb@tentacle.dhs.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 11:45:06 -0400
Message-Id: <1122479106.21253.158.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Paulus,

Add inotify system call stubs to PPC32.

Signed-off-by: Robert Love <rml@novell.com>

 arch/ppc/kernel/misc.S   |    3 +++
 include/asm-ppc/unistd.h |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff -urN linux-2.6.13-rc3-git8/arch/ppc/kernel/misc.S linux/arch/ppc/kernel/misc.S
--- linux-2.6.13-rc3-git8/arch/ppc/kernel/misc.S	2005-07-27 10:59:31.000000000 -0400
+++ linux/arch/ppc/kernel/misc.S	2005-07-27 11:25:43.000000000 -0400
@@ -1451,3 +1451,6 @@
 	.long sys_waitid
 	.long sys_ioprio_set
 	.long sys_ioprio_get
+	.long sys_inotify_init		/* 275 */
+	.long sys_inotify_add_watch
+	.long sys_inotify_rm_watch
diff -urN linux-2.6.13-rc3-git8/include/asm-ppc/unistd.h linux/include/asm-ppc/unistd.h
--- linux-2.6.13-rc3-git8/include/asm-ppc/unistd.h	2005-07-27 10:59:32.000000000 -0400
+++ linux/include/asm-ppc/unistd.h	2005-07-27 11:25:26.000000000 -0400
@@ -279,8 +279,11 @@
 #define __NR_waitid		272
 #define __NR_ioprio_set		273
 #define __NR_ioprio_get		274
+#define __NR_inotify_init	275
+#define __NR_inotify_add_watch	276
+#define __NR_inotify_rm_watch	277
 
-#define __NR_syscalls		275
+#define __NR_syscalls		278
 
 #define __NR(n)	#n
 


