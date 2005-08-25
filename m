Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVHYFVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVHYFVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVHYFVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57547 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964801AbVHYFVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:00 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (5/22) static vs. extern in amigaints.h
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADe-0005b9-51@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

extern declaration of static object removed from header

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-sun3_pgtable/include/asm-m68k/amigaints.h RC13-rc7-amigaints/include/asm-m68k/amigaints.h
--- RC13-rc7-sun3_pgtable/include/asm-m68k/amigaints.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-amigaints/include/asm-m68k/amigaints.h	2005-08-25 00:54:07.000000000 -0400
@@ -109,8 +109,6 @@
 extern void amiga_do_irq(int irq, struct pt_regs *fp);
 extern void amiga_do_irq_list(int irq, struct pt_regs *fp);
 
-extern unsigned short amiga_intena_vals[];
-
 /* CIA interrupt control register bits */
 
 #define CIA_ICR_TA	0x01
