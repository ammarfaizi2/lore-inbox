Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTBRGFP>; Tue, 18 Feb 2003 01:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267675AbTBRGFP>; Tue, 18 Feb 2003 01:05:15 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:63912 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267671AbTBRGFN>; Tue, 18 Feb 2003 01:05:13 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Add v850 version of `init_irq_proc' for sysctl
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061507.6134837C2@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:07 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/irq.c linux-2.5.62-uc0/arch/v850/kernel/irq.c
--- linux-2.5.62-uc0.orig/arch/v850/kernel/irq.c	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/irq.c	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/irq.c -- High-level interrupt handling
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1994-2000  Ralf Baechle
  *  Copyright (C) 1992  Linus Torvalds
  *
@@ -713,3 +713,9 @@
 		base_irq += interval;
 	}
 }
+
+#if defined(CONFIG_PROC_FS) && defined(CONFIG_SYSCTL)
+void init_irq_proc(void)
+{
+}
+#endif /* CONFIG_PROC_FS && CONFIG_SYSCTL */
