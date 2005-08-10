Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVHJUHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVHJUHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVHJUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:07:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:41186 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030240AbVHJUHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:07:08 -0400
Subject: [patch] SH: inotify and ioprio syscalls
From: Robert Love <rml@novell.com>
To: Mr Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       The Cutch <ttb@tentacle.dhs.org>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 16:07:09 -0400
Message-Id: <1123704429.23297.11.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add inotify and ioprio syscall stubs to SH.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 arch/sh/kernel/entry.S  |    5 +++++
 include/asm-sh/unistd.h |    8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff -urN linux-2.6.13-rc6-git2/arch/sh/kernel/entry.S linux/arch/sh/kernel/entry.S
--- linux-2.6.13-rc6-git2/arch/sh/kernel/entry.S	2005-06-17 15:48:29.000000000 -0400
+++ linux/arch/sh/kernel/entry.S	2005-08-10 15:54:44.000000000 -0400
@@ -1145,5 +1145,10 @@
 	.long sys_add_key		/* 285 */
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_ioprio_set
+	.long sys_ioprio_get
+	.long sys_inotify_init		/* 290 */
+	.long sys_inotify_add_watch
+	.long sys_inotify_rm_watch
 
 /* End of entry.S */
diff -urN linux-2.6.13-rc6-git2/include/asm-sh/unistd.h linux/include/asm-sh/unistd.h
--- linux-2.6.13-rc6-git2/include/asm-sh/unistd.h	2005-06-17 15:48:29.000000000 -0400
+++ linux/include/asm-sh/unistd.h	2005-08-10 15:55:41.000000000 -0400
@@ -295,8 +295,14 @@
 #define __NR_add_key		285
 #define __NR_request_key	286
 #define __NR_keyctl		287
+#define __NR_ioprio_set		288
+#define __NR_ioprio_get		289
+#define __NR_inotify_init	290
+#define __NR_inotify_add_watch	291
+#define __NR_inotify_rm_watch	292
 
-#define NR_syscalls 288
+
+#define NR_syscalls 293
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-sh/errno.h> */
 




