Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTBRGJx>; Tue, 18 Feb 2003 01:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTBRGIW>; Tue, 18 Feb 2003 01:08:22 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:4265 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267675AbTBRGFS>; Tue, 18 Feb 2003 01:05:18 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Remove unused compile-time configuration options on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061507.3F74437BE@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:07 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.62-uc0.orig/include/asm-v850/entry.h linux-2.5.62-uc0/include/asm-v850/entry.h
--- linux-2.5.62-uc0.orig/include/asm-v850/entry.h	2002-11-05 11:25:31.000000000 +0900
+++ linux-2.5.62-uc0/include/asm-v850/entry.h	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/entry.h -- Definitions used by low-level trap handlers
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -19,21 +19,6 @@
 #include <asm/machdep.h>
 
 
-/* If true, system calls save and restore all registers (except result
-   registers, of course).  If false, then `call clobbered' registers
-   will not be preserved, on the theory that system calls are basically
-   function calls anyway, and the caller should be able to deal with it.
-   This is a security risk, of course, as `internal' values may leak out
-   after a system call, but that certainly doesn't matter very much for
-   a processor with no MMU protection!  For a protected-mode kernel, it
-   would be faster to just zero those registers before returning.  */
-#define TRAPS_PRESERVE_CALL_CLOBBERED_REGS	0
-
-/* If TRAPS_PRESERVE_CALL_CLOBBERED_REGS is false, then zero `call
-   clobbered' registers before returning from a system call.  */
-#define TRAPS_ZERO_CALL_CLOBBERED_REGS		0
-
-
 /* These are special variables using by the kernel trap/interrupt code
    to save registers in, at a time when there are no spare registers we
    can use to do so, and we can't depend on the value of the stack
