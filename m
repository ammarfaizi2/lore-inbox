Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268119AbTAJDu3>; Thu, 9 Jan 2003 22:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbTAJDu3>; Thu, 9 Jan 2003 22:50:29 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:28385 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S268119AbTAJDu2>; Thu, 9 Jan 2003 22:50:28 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Add __gpl_ksymtab section to v850 linker script
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030110035906.E2AF43701@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 10 Jan 2003 12:59:06 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.55-moo.orig/arch/v850/vmlinux.lds.S linux-2.5.55-moo/arch/v850/vmlinux.lds.S
--- linux-2.5.55-moo.orig/arch/v850/vmlinux.lds.S	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.5.55-moo/arch/v850/vmlinux.lds.S	2003-01-09 15:27:41.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/vmlinux.lds.S -- kernel linker script for v850 platforms
  *
- *  Copyright (C) 2002  NEC Electronics Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -51,6 +51,9 @@
 		___start___ksymtab = . ;/* Kernel symbol table.  */	      \
 			*(__ksymtab)					      \
 		___stop___ksymtab = . ;					      \
+		___start___gpl_ksymtab = . ; /* Same for GPL symbols.  */     \
+			*(__gpl_ksymtab)				      \
+		___stop___gpl_ksymtab = . ;				      \
 		. = ALIGN (4) ;						      \
 		__etext = . ;
 
