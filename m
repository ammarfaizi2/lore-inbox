Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTBYD3R>; Mon, 24 Feb 2003 22:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTBYD2U>; Mon, 24 Feb 2003 22:28:20 -0500
Received: from [24.77.48.240] ([24.77.48.240]:29283 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S266186AbTBYD10>;
	Mon, 24 Feb 2003 22:27:26 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bjv32725@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - privilege
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    priviledge -> privilege
    priviledged -> privileged
    unpriviledged -> unprivileged
    nonpriviledged -> nonprivileged

Fixes 7 occurrences in all.

diff -ur 2.5.63a/arch/alpha/kernel/traps.c 2.5.63b/arch/alpha/kernel/traps.c
--- 2.5.63a/arch/alpha/kernel/traps.c	Mon Feb 24 11:05:40 2003
+++ 2.5.63b/arch/alpha/kernel/traps.c	Mon Feb 24 16:08:23 2003
@@ -411,7 +411,7 @@
 }
 
 /* There is an ifdef in the PALcode in MILO that enables a 
-   "kernel debugging entry point" as an unpriviledged call_pal.
+   "kernel debugging entry point" as an unprivileged call_pal.
 
    We don't want to have anything to do with it, but unfortunately
    several versions of MILO included in distributions have it enabled,
diff -ur 2.5.63a/arch/i386/kernel/cpu/intel.c 2.5.63b/arch/i386/kernel/cpu/intel.c
--- 2.5.63a/arch/i386/kernel/cpu/intel.c	Mon Feb 24 11:05:14 2003
+++ 2.5.63b/arch/i386/kernel/cpu/intel.c	Mon Feb 24 16:07:56 2003
@@ -151,7 +151,7 @@
 #ifdef CONFIG_X86_F00F_BUG
 	/*
 	 * All current models of Pentium and Pentium with MMX technology CPUs
-	 * have the F0 0F bug, which lets nonpriviledged users lock up the system.
+	 * have the F0 0F bug, which lets nonprivileged users lock up the system.
 	 * Note that the workaround only should be initialized once...
 	 */
 	c->f00f_bug = 0;
diff -ur 2.5.63a/drivers/net/wireless/airo.c 2.5.63b/drivers/net/wireless/airo.c
--- 2.5.63a/drivers/net/wireless/airo.c	Mon Feb 24 11:05:08 2003
+++ 2.5.63b/drivers/net/wireless/airo.c	Mon Feb 24 16:07:40 2003
@@ -5126,7 +5126,7 @@
 	Resp rsp;
 
 	/* Note : you may have realised that, as this is a SET operation,
-	 * this is priviledged and therefore a normal user can't
+	 * this is privileged and therefore a normal user can't
 	 * perform scanning.
 	 * This is not an error, while the device perform scanning,
 	 * traffic doesn't flow, so it's a perfect DoS...
diff -ur 2.5.63a/include/asm-arm/bitops.h 2.5.63b/include/asm-arm/bitops.h
--- 2.5.63a/include/asm-arm/bitops.h	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/include/asm-arm/bitops.h	Mon Feb 24 16:06:05 2003
@@ -9,7 +9,7 @@
  *
  * Please note that the code in this file should never be included
  * from user space.  Many of these are not implemented in assembler
- * since they would be too costly.  Also, they require priviledged
+ * since they would be too costly.  Also, they require privileged
  * instructions (which are not available from user mode) to ensure
  * that they are atomic.
  */
diff -ur 2.5.63a/include/asm-mips/mipsregs.h 2.5.63b/include/asm-mips/mipsregs.h
--- 2.5.63a/include/asm-mips/mipsregs.h	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/include/asm-mips/mipsregs.h	Mon Feb 24 16:06:26 2003
@@ -528,7 +528,7 @@
 #define CE1_SP_HINT_TO_SHARED_SC_BLOCKS	15
 
 /*
- * These flags define in which priviledge mode the counters count events
+ * These flags define in which privilege mode the counters count events
  */
 #define CEB_USER	8	/* Count events in user mode, EXL = ERL = 0 */
 #define CEB_SUPERVISOR	4	/* Count events in supvervisor mode EXL = ERL = 0 */
diff -ur 2.5.63a/include/asm-mips64/mipsregs.h 2.5.63b/include/asm-mips64/mipsregs.h
--- 2.5.63a/include/asm-mips64/mipsregs.h	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/include/asm-mips64/mipsregs.h	Mon Feb 24 16:07:20 2003
@@ -310,7 +310,7 @@
 #define CE1_SP_HINT_TO_SHARED_SC_BLOCKS	15
 
 /*
- * These flags define in which priviledge mode the counters count events
+ * These flags define in which privilege mode the counters count events
  */
 #define CEB_USER	8	/* Count events in user mode, EXL = ERL = 0 */
 #define CEB_SUPERVISOR	4	/* Count events in supvervisor mode EXL = ERL = 0 */
diff -ur 2.5.63a/net/sunrpc/auth_unix.c 2.5.63b/net/sunrpc/auth_unix.c
--- 2.5.63a/net/sunrpc/auth_unix.c	Mon Feb 24 11:05:34 2003
+++ 2.5.63b/net/sunrpc/auth_unix.c	Mon Feb 24 16:08:37 2003
@@ -163,7 +163,7 @@
 	memcpy(p, clnt->cl_nodename, n);
 	p += (n + 3) >> 2;
 
-	/* Note: we don't use real uid if it involves raising priviledge */
+	/* Note: we don't use real uid if it involves raising privilege */
 	if (ruid && cred->uc_puid != 0 && cred->uc_pgid != 0) {
 		*p++ = htonl((u32) cred->uc_puid);
 		*p++ = htonl((u32) cred->uc_pgid);
Only in 2.5.63b: out
