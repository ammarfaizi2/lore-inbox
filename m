Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266790AbSKHIdX>; Fri, 8 Nov 2002 03:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbSKHIbs>; Fri, 8 Nov 2002 03:31:48 -0500
Received: from dp.samba.org ([66.70.73.150]:50374 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266794AbSKHIbq>;
	Fri, 8 Nov 2002 03:31:46 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] vmalloc.h needs pgprot_t
Date: Fri, 08 Nov 2002 19:29:35 +1100
Message-Id: <20021108083828.55D2A2C453@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

  Again, uncovered in PPC compile.
  

--- trivial-2.5-bk/include/linux/vmalloc.h.orig	2002-11-08 18:47:15.000000000 +1100
+++ trivial-2.5-bk/include/linux/vmalloc.h	2002-11-08 18:47:15.000000000 +1100
@@ -2,6 +2,7 @@
 #define _LINUX_VMALLOC_H
 
 #include <linux/spinlock.h>
+#include <asm/page.h>		/* pgprot_t */
 
 /* bits in vm_struct->flags */
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
-- 
  Don't blame me: the Monkey is driving
  File: Rusty Russell <rusty@rustcorp.com.au>: [PATCH] vmalloc.h needs pgprot_t
