Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTBRGJw>; Tue, 18 Feb 2003 01:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbTBRGIU>; Tue, 18 Feb 2003 01:08:20 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:12969 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267682AbTBRGF0>; Tue, 18 Feb 2003 01:05:26 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Use .balign rather than .align for v850 asm funcs
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061509.149C837C9@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:09 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a bunch of unnecessary nops... :-)
	
diff -ruN -X../cludes linux-2.5.62-uc0.orig/include/asm-v850/asm.h linux-2.5.62-uc0/include/asm-v850/asm.h
--- linux-2.5.62-uc0.orig/include/asm-v850/asm.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.5.62-uc0/include/asm-v850/asm.h	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/asm.h -- Macros for writing assembly code
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -12,7 +12,7 @@
  */
 
 #define G_ENTRY(name)							      \
-   .align 4;								      \
+   .balign 4;								      \
    .globl name;								      \
    .type  name,@function;						      \
    name
@@ -24,7 +24,7 @@
    .size  name,.-name
 
 #define L_ENTRY(name)							      \
-   .align 4;								      \
+   .balign 4;								      \
    .type  name,@function;						      \
    name
 #define L_DATA(name)							      \
