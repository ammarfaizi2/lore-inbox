Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVLMNoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVLMNoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVLMNnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:50 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:8684 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932201AbVLMNnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:21 -0500
Subject: [PATCH -mm 2/9] unshare system call : system call registration for
	i386
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481292.25431.181.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:43:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 2/9] unshare system call: System call registration for i386
                                                                                
Signed-off-by: Janak Desai
                                                                                

 arch/i386/kernel/syscall_table.S |    1 +
 include/asm-i386/unistd.h        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
 
 
diff -Naurp 2.6.15-rc5-mm2/arch/i386/kernel/syscall_table.S 2.6.15-rc5-mm2+i386/arch/i386/kernel/syscall_table.S
--- 2.6.15-rc5-mm2/arch/i386/kernel/syscall_table.S	2005-12-12 03:05:36.000000000 +0000
+++ 2.6.15-rc5-mm2+i386/arch/i386/kernel/syscall_table.S	2005-12-12 19:59:42.000000000 +0000
@@ -296,3 +296,4 @@ ENTRY(sys_call_table)
 	.long sys_migrate_pages
 	.long sys_preadv		/* 295 */
 	.long sys_pwritev
+	.long sys_unshare
diff -Naurp 2.6.15-rc5-mm2/include/asm-i386/unistd.h 2.6.15-rc5-mm2+i386/include/asm-i386/unistd.h
--- 2.6.15-rc5-mm2/include/asm-i386/unistd.h	2005-12-12 03:05:58.000000000 +0000
+++ 2.6.15-rc5-mm2+i386/include/asm-i386/unistd.h	2005-12-12 20:00:10.000000000 +0000
@@ -302,8 +302,9 @@
 #define __NR_migrate_pages	294
 #define __NR_preadv		295
 #define __NR_pwritev		296
+#define __NR_unshare		297
 
-#define NR_syscalls 297
+#define NR_syscalls 298
 
 /*
  * user-visible error numbers are in the range -1 - -128: see


