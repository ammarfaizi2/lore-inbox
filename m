Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWALERx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWALERx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWALEPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14053 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965023AbWALEPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:34 -0500
Subject: [PATCH -mm 8/10] unshare system call -v5 : system call
	registration for powerpc
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137039008.7488.218.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 8/10] unshare system call: system call registration for powerpc

Registers system call for the powerpc architecture.

Changes since -v4 of this patch submitted on 12/13/05:
        - Forward ported to 2.6.15-mm3 which modified the syscall number.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 arch/powerpc/kernel/systbl.S |    1 +
 include/asm-powerpc/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -Naurp 2.6.15-mm3/arch/powerpc/kernel/systbl.S 2.6.15-mm3+unsh-powerpc/arch/powerpc/kernel/systbl.S
--- 2.6.15-mm3/arch/powerpc/kernel/systbl.S	2006-01-11 20:21:45.000000000 +0000
+++ 2.6.15-mm3+unsh-powerpc/arch/powerpc/kernel/systbl.S	2006-01-12 00:36:51.000000000 +0000
@@ -321,3 +321,4 @@ SYSCALL(inotify_add_watch)
 SYSCALL(inotify_rm_watch)
 SYSCALL(spu_run)
 SYSCALL(spu_create)
+SYSCALL(unshare)
diff -Naurp 2.6.15-mm3/include/asm-powerpc/unistd.h 2.6.15-mm3+unsh-powerpc/include/asm-powerpc/unistd.h
--- 2.6.15-mm3/include/asm-powerpc/unistd.h	2006-01-11 20:22:17.000000000 +0000
+++ 2.6.15-mm3+unsh-powerpc/include/asm-powerpc/unistd.h	2006-01-12 00:37:40.000000000 +0000
@@ -298,8 +298,9 @@
 #define __NR_inotify_rm_watch	277
 #define __NR_spu_run		278
 #define __NR_spu_create		279
+#define __NR_unshare		280
 
-#define __NR_syscalls		280
+#define __NR_syscalls		281
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit


