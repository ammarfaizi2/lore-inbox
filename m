Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVHJUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVHJUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVHJUN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:13:29 -0400
Received: from loon.tech9.net ([69.20.54.92]:21690 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S1030239AbVHJUN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:13:28 -0400
Subject: [patch] SH64: inotify and ioprio syscalls
From: Robert Love <rlove@rlove.org>
To: Mr Morton <akpm@osdl.org>
Cc: The Cutch <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 16:13:17 -0400
Message-Id: <1123704797.23297.13.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add inotify and ioprio syscall stubs to SH64.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 arch/sh64/kernel/syscalls.S |    5 +++++
 include/asm-sh64/unistd.h   |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff -urN linux-2.6.13-rc6-git2/arch/sh64/kernel/syscalls.S linux/arch/sh64/kernel/syscalls.S
--- linux-2.6.13-rc6-git2/arch/sh64/kernel/syscalls.S	2005-06-17 15:48:29.000000000 -0400
+++ linux/arch/sh64/kernel/syscalls.S	2005-08-10 16:12:24.000000000 -0400
@@ -342,4 +342,9 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl		/* 315 */
+	.long sys_ioprio_set
+	.long sys_ioprio_get
+	.long sys_inotify_init
+	.long sys_inotify_add_watch
+	.long sys_inotify_rm_watch	/* 320 */
 
diff -urN linux-2.6.13-rc6-git2/include/asm-sh64/unistd.h linux/include/asm-sh64/unistd.h
--- linux-2.6.13-rc6-git2/include/asm-sh64/unistd.h	2005-06-17 15:48:29.000000000 -0400
+++ linux/include/asm-sh64/unistd.h	2005-08-10 16:12:10.000000000 -0400
@@ -338,8 +338,13 @@
 #define __NR_add_key		313
 #define __NR_request_key	314
 #define __NR_keyctl		315
+#define __NR_ioprio_set		316
+#define __NR_ioprio_get		317
+#define __NR_inotify_init	318
+#define __NR_inotify_add_watch	319
+#define __NR_inotify_rm_watch	320
 
-#define NR_syscalls 316
+#define NR_syscalls 321
 
 /* user-visible error numbers are in the range -1 - -125: see <asm-sh64/errno.h> */
 


