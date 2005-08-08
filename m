Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVHHNgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVHHNgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVHHNgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:36:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31966 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750871AbVHHNgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:36:53 -0400
Date: Mon, 8 Aug 2005 09:36:40 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, sds@tycho.nsa.gov,
       linuxram@us.ibm.com, ericvh@gmail.com, dwalsh@redhat.com,
       jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org, gh@us.ibm.com,
       linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] New system call, unshare
Message-ID: <Pine.WNT.4.63.0508080933330.3668@IBM-AIP3070F3AM>
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



diff -Naurp 2.6.13-rc5-mm1/arch/i386/kernel/syscall_table.S 2.6.13-rc5-mm1+unshare/arch/i386/kernel/syscall_table.S
--- 2.6.13-rc5-mm1/arch/i386/kernel/syscall_table.S	2005-08-07 15:33:07.000000000 +0000
+++ 2.6.13-rc5-mm1+unshare/arch/i386/kernel/syscall_table.S	2005-08-07 18:35:57.000000000 +0000
@@ -300,3 +300,4 @@ ENTRY(sys_call_table)
 	.long sys_vperfctr_control
 	.long sys_vperfctr_write
 	.long sys_vperfctr_read
+	.long sys_unshare		/* 300 */
diff -Naurp 2.6.13-rc5-mm1/include/asm-i386/unistd.h 2.6.13-rc5-mm1+unshare/include/asm-i386/unistd.h
--- 2.6.13-rc5-mm1/include/asm-i386/unistd.h	2005-08-07 15:33:40.000000000 +0000
+++ 2.6.13-rc5-mm1+unshare/include/asm-i386/unistd.h	2005-08-07 18:36:37.000000000 +0000
@@ -305,8 +305,9 @@
 #define __NR_vperfctr_control	(__NR_vperfctr_open+1)
 #define __NR_vperfctr_write	(__NR_vperfctr_open+2)
 #define __NR_vperfctr_read	(__NR_vperfctr_open+3)
+#define __NR_unshare		300
 
-#define NR_syscalls 300
+#define NR_syscalls 301
 
 /*
  * user-visible error numbers are in the range -1 - -128: see

