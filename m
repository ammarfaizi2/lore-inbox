Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVIGRnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVIGRnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVIGRnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:43:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60588 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751253AbVIGRnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:43:17 -0400
Date: Wed, 7 Sep 2005 13:43:09 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: viro@ZenIV.linux.org.uk, akpm@osdl.org
cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] (repost) New System call, unshare
Message-ID: <Pine.WNT.4.63.0509071340570.3520@IBM-AIP3070F3AM>
X-X-Sender: janak@imap.linux.ibm.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[PATCH 2/2] unshare system call: System Call setup for i386 arch

Signed-off-by: Janak Desai


 arch/i386/kernel/syscall_table.S |    1 +
 include/asm-i386/unistd.h        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


diff -Naurp linux-2.6.13-mm1/arch/i386/kernel/syscall_table.S linux-2.6.13-mm1+unshare-patch2/arch/i386/kernel/syscall_table.S
--- linux-2.6.13-mm1/arch/i386/kernel/syscall_table.S	2005-09-07 13:24:01.000000000 +0000
+++ linux-2.6.13-mm1+unshare-patch2/arch/i386/kernel/syscall_table.S	2005-09-07 13:40:42.000000000 +0000
@@ -300,3 +300,4 @@ ENTRY(sys_call_table)
 	.long sys_vperfctr_control
 	.long sys_vperfctr_write
 	.long sys_vperfctr_read
+	.long sys_unshare		/* 300 */
diff -Naurp linux-2.6.13-mm1/include/asm-i386/unistd.h linux-2.6.13-mm1+unshare-patch2/include/asm-i386/unistd.h
--- linux-2.6.13-mm1/include/asm-i386/unistd.h	2005-09-07 13:24:52.000000000 +0000
+++ linux-2.6.13-mm1+unshare-patch2/include/asm-i386/unistd.h	2005-09-07 13:40:42.000000000 +0000
@@ -305,8 +305,9 @@
 #define __NR_vperfctr_control	(__NR_vperfctr_open+1)
 #define __NR_vperfctr_write	(__NR_vperfctr_open+2)
 #define __NR_vperfctr_read	(__NR_vperfctr_open+3)
+#define __NR_unshare		300
 
-#define NR_syscalls 300
+#define NR_syscalls 301
 
 /*
  * user-visible error numbers are in the range -1 - -128: see

