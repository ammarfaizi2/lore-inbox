Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbULCTfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbULCTfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbULCTcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:32:02 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:28676
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262475AbULCTam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:30:42 -0500
Message-Id: <200412032146.iB3LkbZW004745@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - Fix highmem compilation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:46:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a reference to an unused variable.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/mem.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/mem.c	2004-12-03 12:46:55.000000000 -0500
+++ 2.6.9/arch/um/kernel/mem.c	2004-12-03 12:58:23.000000000 -0500
@@ -65,9 +65,6 @@
 	unsigned long start;
 
 	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
-#ifdef CONFIG_HIGHMEM
-	highmem_start_page = pfn_to_page(phys_to_pfn(__pa(high_physmem)));
-#endif
 
         /* clear the zero-page */
         memset((void *) empty_zero_page, 0, PAGE_SIZE);

