Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSH1IT3>; Wed, 28 Aug 2002 04:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSH1IT0>; Wed, 28 Aug 2002 04:19:26 -0400
Received: from dp.samba.org ([66.70.73.150]:44996 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318771AbSH1ITU>;
	Wed, 28 Aug 2002 04:19:20 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] designated initializer patches for include_asm-i386
Date: Wed, 28 Aug 2002 17:59:12 +1000
Message-Id: <20020828032403.30D1C2C2A5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Art Haas <ahaas@neosoft.com>

  Here are a couple of patches for files in include/asm-i386. Patches
  are against 2.5.31.
  
  Art Haas
  -- 
  They that can give up essential liberty to obtain a little temporary
  safety deserve neither liberty nor safety.
   -- Benjamin Franklin, Historical Review of Pennsylvania, 1759

--- trivial-2.5.32/include/asm-i386/thread_info.h.orig	2002-08-28 17:53:12.000000000 +1000
+++ trivial-2.5.32/include/asm-i386/thread_info.h	2002-08-28 17:53:12.000000000 +1000
@@ -57,12 +57,12 @@
 #ifndef __ASSEMBLY__
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	task:		&tsk,			\
-	exec_domain:	&default_exec_domain,	\
-	flags:		0,			\
-	cpu:		0,			\
-	preempt_count:	1,			\
-	addr_limit:	KERNEL_DS,		\
+	.task		= &tsk,			\
+	.exec_domain	= &default_exec_domain,	\
+	.flags		= 0,			\
+	.cpu		= 0,			\
+	.preempt_count	= 1,			\
+	.addr_limit	= KERNEL_DS,		\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
--- trivial-2.5.32/include/asm-i386/xor.h.orig	2002-08-28 17:53:12.000000000 +1000
+++ trivial-2.5.32/include/asm-i386/xor.h	2002-08-28 17:53:12.000000000 +1000
@@ -519,19 +519,19 @@
 }
 
 static struct xor_block_template xor_block_pII_mmx = {
-	name: "pII_mmx",
-	do_2: xor_pII_mmx_2,
-	do_3: xor_pII_mmx_3,
-	do_4: xor_pII_mmx_4,
-	do_5: xor_pII_mmx_5,
+	.name = "pII_mmx",
+	.do_2 = xor_pII_mmx_2,
+	.do_3 = xor_pII_mmx_3,
+	.do_4 = xor_pII_mmx_4,
+	.do_5 = xor_pII_mmx_5,
 };
 
 static struct xor_block_template xor_block_p5_mmx = {
-	name: "p5_mmx",
-	do_2: xor_p5_mmx_2,
-	do_3: xor_p5_mmx_3,
-	do_4: xor_p5_mmx_4,
-	do_5: xor_p5_mmx_5,
+	.name = "p5_mmx",
+	.do_2 = xor_p5_mmx_2,
+	.do_3 = xor_p5_mmx_3,
+	.do_4 = xor_p5_mmx_4,
+	.do_5 = xor_p5_mmx_5,
 };
 
 #undef FPU_SAVE
@@ -848,11 +848,11 @@
 }
 
 static struct xor_block_template xor_block_pIII_sse = {
-        name: "pIII_sse",
-        do_2: xor_sse_2,
-        do_3: xor_sse_3,
-        do_4: xor_sse_4,
-        do_5: xor_sse_5,
+        .name = "pIII_sse",
+        .do_2 =  xor_sse_2,
+        .do_3 =  xor_sse_3,
+        .do_4 =  xor_sse_4,
+        .do_5 = xor_sse_5,
 };
 
 /* Also try the generic routines.  */
-- 
  Don't blame me: the Monkey is driving
  File: Art Haas <ahaas@neosoft.com>: [PATCH] designated initializer patches for include_asm-i386
