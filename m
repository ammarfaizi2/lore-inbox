Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263794AbUDVH5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbUDVH5o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUDVHzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:55:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:35768 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263740AbUDVHzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:55:31 -0400
Subject: [PATCH] ppc64: Set ARCH_MIN_TASKALIGN
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082620432.2058.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Apr 2004 17:53:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need some alignement of those structs for proper operations
especially with FP and Altivec, or SLAB_DEBUG can break us

Please apply,
Ben.

===== include/asm-ppc64/processor.h 1.40 vs edited =====
--- 1.40/include/asm-ppc64/processor.h	Tue Apr 13 03:54:08 2004
+++ edited/include/asm-ppc64/processor.h	Thu Apr 22 17:51:46 2004
@@ -553,6 +553,8 @@
 #endif /* CONFIG_ALTIVEC */
 };
 
+#define ARCH_MIN_TASKALIGN 16
+
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 
 #define INIT_THREAD  { \


