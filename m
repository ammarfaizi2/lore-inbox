Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVBTPCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVBTPCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 10:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBTO6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:58:52 -0500
Received: from aun.it.uu.se ([130.238.12.36]:27830 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261843AbVBTO5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:57:15 -0500
Date: Sun, 20 Feb 2005 15:57:06 +0100 (MET)
Message-Id: <200502201457.j1KEv63e029559@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-rc3-mm2] perfctr-2.7.10 API update 4/4: ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.10 update, 4/4:
- Update ppc32 syscall table for perfctr-2.7.10 API changes.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/ppc/kernel/misc.S   |    5 ++---
 include/asm-ppc/unistd.h |    7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff -rupN linux-2.6.11-rc3-mm2/arch/ppc/kernel/misc.S linux-2.6.11-rc3-mm2.perfctr-2.7.10-ppc32-syscalls-update/arch/ppc/kernel/misc.S
--- linux-2.6.11-rc3-mm2/arch/ppc/kernel/misc.S	2005-02-20 12:39:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-ppc32-syscalls-update/arch/ppc/kernel/misc.S	2005-02-20 13:10:06.000000000 +0100
@@ -1452,6 +1452,5 @@ _GLOBAL(sys_call_table)
 	.long sys_keyctl
 	.long sys_vperfctr_open
 	.long sys_vperfctr_control
-	.long sys_vperfctr_unlink
-	.long sys_vperfctr_iresume	/* 275 */
-	.long sys_vperfctr_read
+	.long sys_vperfctr_write
+	.long sys_vperfctr_read		/* 275 */
diff -rupN linux-2.6.11-rc3-mm2/include/asm-ppc/unistd.h linux-2.6.11-rc3-mm2.perfctr-2.7.10-ppc32-syscalls-update/include/asm-ppc/unistd.h
--- linux-2.6.11-rc3-mm2/include/asm-ppc/unistd.h	2005-02-20 12:39:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-ppc32-syscalls-update/include/asm-ppc/unistd.h	2005-02-20 13:10:06.000000000 +0100
@@ -278,11 +278,10 @@
 #define __NR_keyctl		271
 #define __NR_vperfctr_open	272
 #define __NR_vperfctr_control	(__NR_vperfctr_open+1)
-#define __NR_vperfctr_unlink	(__NR_vperfctr_open+2)
-#define __NR_vperfctr_iresume	(__NR_vperfctr_open+3)
-#define __NR_vperfctr_read	(__NR_vperfctr_open+4)
+#define __NR_vperfctr_write	(__NR_vperfctr_open+2)
+#define __NR_vperfctr_read	(__NR_vperfctr_open+3)
 
-#define __NR_syscalls		277
+#define __NR_syscalls		276
 
 #define __NR(n)	#n
 
