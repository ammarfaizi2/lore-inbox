Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbTAIJiN>; Thu, 9 Jan 2003 04:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAIJiN>; Thu, 9 Jan 2003 04:38:13 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:25046 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262414AbTAIJiI>; Thu, 9 Jan 2003 04:38:08 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Define `read_barrier_depends' on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030109094642.66914374A@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu,  9 Jan 2003 18:46:42 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.55-moo.orig/include/asm-v850/system.h linux-2.5.55-moo/include/asm-v850/system.h
--- linux-2.5.55-moo.orig/include/asm-v850/system.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.55-moo/include/asm-v850/system.h	2003-01-09 14:07:36.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/system.h -- Low-level interrupt/thread ops
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -67,6 +67,7 @@
 #define mb()			__asm__ __volatile__ ("" ::: "memory")
 #define rmb()			mb ()
 #define wmb()			mb ()
+#define read_barrier_depends()	((void)0)
 #define set_rmb(var, value)	do { xchg (&var, value); } while (0)
 #define set_mb(var, value)	set_rmb (var, value)
 #define set_wmb(var, value)	do { var = value; wmb (); } while (0)
