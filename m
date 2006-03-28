Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWC1XB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWC1XB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWC1W7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:08 -0500
Received: from [198.99.130.12] ([198.99.130.12]:18115 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964782AbWC1W7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:02 -0500
Message-Id: <200603282300.k2SMxxOe022962@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/10] UML - Redeclare highmem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 17:59:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The earlier printf patch missed a corresponding change in the printed
variable.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.16-mm.orig/arch/um/include/user_util.h	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/include/user_util.h	2006-03-28 15:59:38.000000000 -0500
@@ -31,7 +31,7 @@ extern unsigned long uml_physmem;
 extern unsigned long uml_reserved;
 extern unsigned long end_vm;
 extern unsigned long start_vm;
-extern unsigned long highmem;
+extern unsigned long long highmem;
 
 extern char host_info[];
 
Index: linux-2.6.16-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/mem.c	2006-03-28 15:55:28.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/mem.c	2006-03-28 15:59:33.000000000 -0500
@@ -30,7 +30,7 @@ extern char __binary_start;
 unsigned long *empty_zero_page = NULL;
 unsigned long *empty_bad_page = NULL;
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
-unsigned long highmem;
+unsigned long long highmem;
 int kmalloc_ok = 0;
 
 static unsigned long brk_end;

