Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSGZWwF>; Fri, 26 Jul 2002 18:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318614AbSGZWwE>; Fri, 26 Jul 2002 18:52:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63664 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318608AbSGZWwE>;
	Fri, 26 Jul 2002 18:52:04 -0400
Date: Sat, 27 Jul 2002 00:54:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] comment fix, 2.5.28
In-Reply-To: <Pine.LNX.4.44.0207262147150.21525-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207270052540.29065-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes a comment that got incorrect via the
set_thread_area() changes.

	Ingo

--- linux/arch/i386/kernel/head.S.orig2	Sat Jul 27 00:53:40 2002
+++ linux/arch/i386/kernel/head.S	Sat Jul 27 00:54:49 2002
@@ -412,10 +412,7 @@
 
 ALIGN
 /*
- * This contains typically 140 quadwords, depending on NR_CPUS.
- *
- * NOTE! Make sure the gdt descriptor in head.S matches this if you
- * change anything.
+ * The Global Descriptor Table contains 20 quadwords, per-CPU.
  */
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */

