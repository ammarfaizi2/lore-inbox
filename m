Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbULBKNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbULBKNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULBKNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:13:24 -0500
Received: from aun.it.uu.se ([130.238.12.36]:44265 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261397AbULBKMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:12:16 -0500
Date: Thu, 2 Dec 2004 11:12:10 +0100 (MET)
Message-Id: <200412021012.iB2ACA1w004553@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 4/4: ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perfctr sysfs update part 4/4:
- Remove sys_perfctr_info() from ppc32.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/ppc/kernel/misc.S   |    5 ++---
 include/asm-ppc/unistd.h |   13 ++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff -rupN linux-2.6.10-rc2-mm4/arch/ppc/kernel/misc.S linux-2.6.10-rc2-mm4.perfctr-ppc-update/arch/ppc/kernel/misc.S
--- linux-2.6.10-rc2-mm4/arch/ppc/kernel/misc.S	2004-11-30 23:52:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-ppc-update/arch/ppc/kernel/misc.S	2004-12-02 02:41:34.000000000 +0100
@@ -1450,9 +1450,8 @@ _GLOBAL(sys_call_table)
 	.long sys_add_key
 	.long sys_request_key		/* 270 */
 	.long sys_keyctl
-	.long sys_perfctr_info
 	.long sys_vperfctr_open
 	.long sys_vperfctr_control
-	.long sys_vperfctr_unlink	/* 275 */
-	.long sys_vperfctr_iresume
+	.long sys_vperfctr_unlink
+	.long sys_vperfctr_iresume	/* 275 */
 	.long sys_vperfctr_read
diff -rupN linux-2.6.10-rc2-mm4/include/asm-ppc/unistd.h linux-2.6.10-rc2-mm4.perfctr-ppc-update/include/asm-ppc/unistd.h
--- linux-2.6.10-rc2-mm4/include/asm-ppc/unistd.h	2004-11-30 23:53:03.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-ppc-update/include/asm-ppc/unistd.h	2004-12-02 02:41:34.000000000 +0100
@@ -276,14 +276,13 @@
 #define __NR_add_key		269
 #define __NR_request_key	270
 #define __NR_keyctl		271
-#define __NR_perfctr_info	272
-#define __NR_vperfctr_open	(__NR_perfctr_info+1)
-#define __NR_vperfctr_control	(__NR_perfctr_info+2)
-#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
-#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
-#define __NR_vperfctr_read	(__NR_perfctr_info+5)
+#define __NR_vperfctr_open	272
+#define __NR_vperfctr_control	(__NR_vperfctr_open+1)
+#define __NR_vperfctr_unlink	(__NR_vperfctr_open+2)
+#define __NR_vperfctr_iresume	(__NR_vperfctr_open+3)
+#define __NR_vperfctr_read	(__NR_vperfctr_open+4)
 
-#define __NR_syscalls		278
+#define __NR_syscalls		277
 
 #define __NR(n)	#n
 
