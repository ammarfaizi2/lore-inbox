Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWALERw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWALERw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWALEP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22472 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965022AbWALEPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:32 -0500
Subject: [PATCH -mm 7/10] unshare system call -v5 : system call
	registration for i386
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137039006.7488.216.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 7/10] unshare system call: system call registration for i386

Registers system call for the i386 architecture.

Changes since -v4 of this patch submitted on 12/13/05:
	- Forward ported to 2.6.15-mm3 which modified the syscall number.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 arch/i386/kernel/syscall_table.S |    1 +
 include/asm-i386/unistd.h        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -Naurp 2.6.15-mm3/arch/i386/kernel/syscall_table.S 2.6.15-mm3+unsh-i386/arch/i386/kernel/syscall_table.S
--- 2.6.15-mm3/arch/i386/kernel/syscall_table.S	2006-01-11 20:21:43.000000000 +0000
+++ 2.6.15-mm3+unsh-i386/arch/i386/kernel/syscall_table.S	2006-01-12 00:32:53.000000000 +0000
@@ -307,3 +307,4 @@ ENTRY(sys_call_table)
 	.long sys_readlinkat		/* 305 */
 	.long sys_fchmodat
 	.long sys_faccessat
+	.long sys_unshare
diff -Naurp 2.6.15-mm3/include/asm-i386/unistd.h 2.6.15-mm3+unsh-i386/include/asm-i386/unistd.h
--- 2.6.15-mm3/include/asm-i386/unistd.h	2006-01-11 20:22:16.000000000 +0000
+++ 2.6.15-mm3+unsh-i386/include/asm-i386/unistd.h	2006-01-12 00:33:21.000000000 +0000
@@ -313,8 +313,9 @@
 #define __NR_readlinkat		305
 #define __NR_fchmodat		306
 #define __NR_faccessat		307
+#define __NR_unshare		308
 
-#define NR_syscalls 308
+#define NR_syscalls 309
 
 /*
  * user-visible error numbers are in the range -1 - -128: see


