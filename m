Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSHJPYH>; Sat, 10 Aug 2002 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSHJPYG>; Sat, 10 Aug 2002 11:24:06 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30734 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317024AbSHJPYD>; Sat, 10 Aug 2002 11:24:03 -0400
Date: Sat, 10 Aug 2002 19:27:26 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: regdef.h [4/10]
Message-ID: <20020810192726.C20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, assembly routines included libc header <alpha/regdef.h>
for OSF/1 register names. With the new kernel build system
it doesn't work anymore. Make our own copy in <include/asm>.

Ivan.

--- 2.5.30/arch/alpha/lib/stxcpy.S	Fri Aug  2 01:16:14 2002
+++ linux/arch/alpha/lib/stxcpy.S	Thu Aug  8 19:28:01 2002
@@ -20,7 +20,7 @@
  * Furthermore, v0, a3-a5, t11, and t12 are untouched.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.30/arch/alpha/lib/ev6-stxcpy.S	Fri Aug  2 01:16:00 2002
+++ linux/arch/alpha/lib/ev6-stxcpy.S	Thu Aug  8 19:28:01 2002
@@ -30,7 +30,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.30/arch/alpha/lib/ev6-stxncpy.S	Fri Aug  2 01:16:33 2002
+++ linux/arch/alpha/lib/ev6-stxncpy.S	Thu Aug  8 19:28:01 2002
@@ -38,7 +38,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.30/arch/alpha/lib/strncpy_from_user.S	Fri Aug  2 01:16:06 2002
+++ linux/arch/alpha/lib/strncpy_from_user.S	Thu Aug  8 19:28:01 2002
@@ -12,7 +12,7 @@
 
 
 #include <asm/errno.h>
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.30/arch/alpha/lib/stxncpy.S	Fri Aug  2 01:16:45 2002
+++ linux/arch/alpha/lib/stxncpy.S	Thu Aug  8 19:28:01 2002
@@ -28,7 +28,7 @@
  * Furthermore, v0, a3-a5, t11, t12, and $at are untouched.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.30/arch/alpha/lib/ev67-strlen_user.S	Fri Aug  2 01:16:23 2002
+++ linux/arch/alpha/lib/ev67-strlen_user.S	Thu Aug  8 19:28:01 2002
@@ -23,7 +23,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.30/arch/alpha/lib/strchr.S	Fri Aug  2 01:16:24 2002
+++ linux/arch/alpha/lib/strchr.S	Thu Aug  8 19:28:01 2002
@@ -6,7 +6,7 @@
  * string, or null if it is not found.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.30/arch/alpha/lib/strlen_user.S	Fri Aug  2 01:16:26 2002
+++ linux/arch/alpha/lib/strlen_user.S	Thu Aug  8 19:28:01 2002
@@ -12,7 +12,7 @@
  * boundary when doing so.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.30/arch/alpha/lib/ev67-strrchr.S	Fri Aug  2 01:16:27 2002
+++ linux/arch/alpha/lib/ev67-strrchr.S	Thu Aug  8 19:28:01 2002
@@ -19,7 +19,7 @@
  */
 
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.30/arch/alpha/lib/ev67-strchr.S	Fri Aug  2 01:16:28 2002
+++ linux/arch/alpha/lib/ev67-strchr.S	Thu Aug  8 19:28:01 2002
@@ -16,7 +16,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.30/arch/alpha/lib/strrchr.S	Fri Aug  2 01:16:34 2002
+++ linux/arch/alpha/lib/strrchr.S	Thu Aug  8 19:28:01 2002
@@ -6,7 +6,7 @@
  * within a null-terminated string, or null if it is not found.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.30/arch/alpha/lib/ev6-strncpy_from_user.S	Fri Aug  2 01:16:45 2002
+++ linux/arch/alpha/lib/ev6-strncpy_from_user.S	Thu Aug  8 19:28:01 2002
@@ -27,7 +27,7 @@
 
 
 #include <asm/errno.h>
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.30/include/asm-alpha/regdef.h	Thu Jan  1 00:00:00 1970
+++ linux/include/asm-alpha/regdef.h	Thu Aug  8 19:28:02 2002
@@ -0,0 +1,44 @@
+#ifndef __alpha_regdef_h__
+#define __alpha_regdef_h__
+
+#define v0	$0	/* function return value */
+
+#define t0	$1	/* temporary registers (caller-saved) */
+#define t1	$2
+#define t2	$3
+#define t3	$4
+#define t4	$5
+#define t5	$6
+#define t6	$7
+#define t7	$8
+
+#define	s0	$9	/* saved-registers (callee-saved registers) */
+#define	s1	$10
+#define	s2	$11
+#define	s3	$12
+#define	s4	$13
+#define	s5	$14
+#define	s6	$15
+#define	fp	s6	/* frame-pointer (s6 in frame-less procedures) */
+
+#define a0	$16	/* argument registers (caller-saved) */
+#define a1	$17
+#define a2	$18
+#define a3	$19
+#define a4	$20
+#define a5	$21
+
+#define t8	$22	/* more temps (caller-saved) */
+#define t9	$23
+#define t10	$24
+#define t11	$25
+#define ra	$26	/* return address register */
+#define t12	$27
+
+#define pv	t12	/* procedure-variable register */
+#define AT	$at	/* assembler temporary */
+#define gp	$29	/* global pointer */
+#define sp	$30	/* stack pointer */
+#define zero	$31	/* reads as zero, writes are noops */
+
+#endif /* __alpha_regdef_h__ */
