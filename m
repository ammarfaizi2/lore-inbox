Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbULBKLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbULBKLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbULBKLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:11:18 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51688 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261308AbULBKLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:11:07 -0500
Date: Thu, 2 Dec 2004 11:11:00 +0100 (MET)
Message-Id: <200412021011.iB2AB0xs004537@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 2/4: x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perfctr sysfs update part 2/4:
- Remove sys_perfctr_info() from x86.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/i386/kernel/entry.S  |    5 ++---
 include/asm-i386/unistd.h |   13 ++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff -rupN linux-2.6.10-rc2-mm4/arch/i386/kernel/entry.S linux-2.6.10-rc2-mm4.perfctr-x86-update/arch/i386/kernel/entry.S
--- linux-2.6.10-rc2-mm4/arch/i386/kernel/entry.S	2004-11-30 23:52:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-x86-update/arch/i386/kernel/entry.S	2004-12-02 02:39:20.000000000 +0100
@@ -900,9 +900,8 @@ ENTRY(sys_call_table)
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
-	.long sys_perfctr_info
-	.long sys_vperfctr_open		/* 290 */
-	.long sys_vperfctr_control
+	.long sys_vperfctr_open
+	.long sys_vperfctr_control	/* 290 */
 	.long sys_vperfctr_unlink
 	.long sys_vperfctr_iresume
 	.long sys_vperfctr_read
diff -rupN linux-2.6.10-rc2-mm4/include/asm-i386/unistd.h linux-2.6.10-rc2-mm4.perfctr-x86-update/include/asm-i386/unistd.h
--- linux-2.6.10-rc2-mm4/include/asm-i386/unistd.h	2004-11-30 23:53:03.000000000 +0100
+++ linux-2.6.10-rc2-mm4.perfctr-x86-update/include/asm-i386/unistd.h	2004-12-02 02:39:20.000000000 +0100
@@ -294,14 +294,13 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
-#define __NR_perfctr_info	289
-#define __NR_vperfctr_open	(__NR_perfctr_info+1)
-#define __NR_vperfctr_control	(__NR_perfctr_info+2)
-#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
-#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
-#define __NR_vperfctr_read	(__NR_perfctr_info+5)
+#define __NR_vperfctr_open	289
+#define __NR_vperfctr_control	(__NR_vperfctr_open+1)
+#define __NR_vperfctr_unlink	(__NR_vperfctr_open+2)
+#define __NR_vperfctr_iresume	(__NR_vperfctr_open+3)
+#define __NR_vperfctr_read	(__NR_vperfctr_open+4)
 
-#define NR_syscalls 295
+#define NR_syscalls 294
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
