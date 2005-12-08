Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVLHWL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVLHWL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVLHWL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:11:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1980 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751238AbVLHWL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:11:27 -0500
Subject: [PATCH -mm 2/5] New system call, unshare (i386)
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134079889.5476.11.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 08 Dec 2005 17:11:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 2/5] unshare system call: System call registration for i386

Signed-off-by: Janak Desai


 arch/i386/kernel/syscall_table.S |    1 +
 include/asm-i386/unistd.h        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


diff -Naurp 2.6.15-rc5-mm1/arch/i386/kernel/syscall_table.S
2.6.15-rc5-mm1+unshare-i386/arch/i386/kernel/syscall_table.S
--- 2.6.15-rc5-mm1/arch/i386/kernel/syscall_table.S	2005-10-28
00:02:08.000000000 +0000
+++
2.6.15-rc5-mm1+unshare-i386/arch/i386/kernel/syscall_table.S	2005-12-07
15:24:35.000000000 +0000
@@ -294,3 +294,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_unshare
diff -Naurp 2.6.15-rc5-mm1/include/asm-i386/unistd.h
2.6.15-rc5-mm1+unshare-i386/include/asm-i386/unistd.h
--- 2.6.15-rc5-mm1/include/asm-i386/unistd.h	2005-12-06
21:06:18.000000000 +0000
+++ 2.6.15-rc5-mm1+unshare-i386/include/asm-i386/unistd.h	2005-12-07
15:26:05.000000000 +0000
@@ -299,8 +299,9 @@
 #define __NR_inotify_init	291
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
+#define __NR_unshare		294
 
-#define NR_syscalls 294
+#define NR_syscalls 295
 
 /*
  * user-visible error numbers are in the range -1 - -128: see


