Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVLMW4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVLMW4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVLMWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:55:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:63462 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030337AbVLMWy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:54:57 -0500
Subject: [PATCH -mm 3/9] unshare system call: system call registration for
	powerpc
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134514039.11972.186.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 17:54:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
[PATCH -mm 3/9] unshare system call: system call registration for powerpc

Registers system call for the powerpc architecture.

Changes since the first submission of this patch on 12/12/05:
	None.
 
Signed-off-by: Janak Desai <janak@us.ibm.com>
 
---
 
 arch/powerpc/kernel/systbl.S |    1 +
 include/asm-powerpc/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
 
diff -Naurp 2.6.15-rc5-mm2/arch/powerpc/kernel/systbl.S 2.6.15-rc5-mm2+powerpc/arch/powerpc/kernel/systbl.S
--- 2.6.15-rc5-mm2/arch/powerpc/kernel/systbl.S	2005-12-12 03:05:39.000000000 +0000
+++ 2.6.15-rc5-mm2+powerpc/arch/powerpc/kernel/systbl.S	2005-12-12 20:15:54.000000000 +0000
@@ -322,3 +322,4 @@ SYSCALL(inotify_rm_watch)
 SYSCALL(spu_run)
 SYSCALL(spu_create)
 SYSCALL(migrate_pages)
+SYSCALL(unshare)
diff -Naurp 2.6.15-rc5-mm2/include/asm-powerpc/unistd.h 2.6.15-rc5-mm2+powerpc/include/asm-powerpc/unistd.h
--- 2.6.15-rc5-mm2/include/asm-powerpc/unistd.h	2005-12-12 03:05:58.000000000 +0000
+++ 2.6.15-rc5-mm2+powerpc/include/asm-powerpc/unistd.h	2005-12-12 20:18:03.000000000 +0000
@@ -299,8 +299,9 @@
 #define __NR_spu_run		278
 #define __NR_spu_create		279
 #define __NR_migrate_pages	280
+#define __NR_unshare		281
 
-#define __NR_syscalls		281
+#define __NR_syscalls		282
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit


