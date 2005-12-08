Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVLHWMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVLHWMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVLHWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:12:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40382 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751240AbVLHWMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:12:48 -0500
Subject: [PATCH -mm 3/5] New system call, unshare (powerpc)
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134079969.5476.14.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 08 Dec 2005 17:12:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 3/5] unshare system call: System call registration for
powerpc

Signed-off-by: Janak Desai


 arch/powerpc/kernel/systbl.S |    1 +
 include/asm-powerpc/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


diff -Naurp 2.6.15-rc5-mm1/arch/powerpc/kernel/systbl.S
2.6.15-rc5-mm1+unshare-powerpc/arch/powerpc/kernel/systbl.S
--- 2.6.15-rc5-mm1/arch/powerpc/kernel/systbl.S	2005-12-06
21:05:49.000000000 +0000
+++
2.6.15-rc5-mm1+unshare-powerpc/arch/powerpc/kernel/systbl.S	2005-12-08
19:12:56.000000000 +0000
@@ -319,3 +319,4 @@ COMPAT_SYS(ioprio_get)
 SYSCALL(inotify_init)
 SYSCALL(inotify_add_watch)
 SYSCALL(inotify_rm_watch)
+SYSCALL(unshare)
diff -Naurp 2.6.15-rc5-mm1/include/asm-powerpc/unistd.h
2.6.15-rc5-mm1+unshare-powerpc/include/asm-powerpc/unistd.h
--- 2.6.15-rc5-mm1/include/asm-powerpc/unistd.h	2005-12-06
21:06:19.000000000 +0000
+++
2.6.15-rc5-mm1+unshare-powerpc/include/asm-powerpc/unistd.h	2005-12-08
19:11:21.000000000 +0000
@@ -296,8 +296,9 @@
 #define __NR_inotify_init	275
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
+#define __NR_unshare		278
 
-#define __NR_syscalls		278
+#define __NR_syscalls		279
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit


