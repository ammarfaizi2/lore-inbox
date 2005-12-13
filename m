Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVLMNnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVLMNnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVLMNnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:6801 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932181AbVLMNnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:18 -0500
Subject: [PATCH -mm 3/9] unshare system call : system call registration for
	powerpc
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481298.25431.183.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:43:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 3/9] unshare system call: System call registration for powerpc
                                                                                
Signed-off-by: Janak Desai


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


