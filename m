Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTFQFwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 01:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFQFwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 01:52:02 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:17849 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264601AbTFQFv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 01:51:59 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add __raw_ read/write ops to v850 io.h
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030617060540.D670E37E2@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 17 Jun 2003 15:05:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.72-moo/include/asm-v850/io.h linux-2.5.72-moo-v850-20030617/include/asm-v850/io.h
--- linux-2.5.72-moo/include/asm-v850/io.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.72-moo-v850-20030617/include/asm-v850/io.h	2003-06-17 14:23:12.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/io.h -- Misc I/O operations
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -30,6 +30,13 @@
 #define writel(b, addr) \
   (void)((*(volatile unsigned int *) (addr)) = (b))
 
+#define __raw_readb readb
+#define __raw_readw readw
+#define __raw_readl readl
+#define __raw_writeb writeb
+#define __raw_writew writew
+#define __raw_writel writel
+
 #define inb(addr)	readb (addr)
 #define inw(addr)	readw (addr)
 #define inl(addr)	readl (addr)
