Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVAQDkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVAQDkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVAQDfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:35:37 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:19972
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262544AbVAQDdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:51 -0500
Message-Id: <200501170556.j0H5uMkY006077@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/10] UML - Fix __pud_alloc definition to match the declaration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/include/asm-um/pgtable.h
===================================================================
--- 2.6.10.orig/include/asm-um/pgtable.h	2005-01-13 18:35:22.000000000 -0500
+++ 2.6.10/include/asm-um/pgtable.h	2005-01-13 19:11:25.000000000 -0500
@@ -9,6 +9,7 @@
 #define __UM_PGTABLE_H
 
 #include "linux/sched.h"
+#include "linux/linkage.h"
 #include "asm/processor.h"
 #include "asm/page.h"
 #include "asm/fixmap.h"
@@ -154,8 +155,8 @@
 #define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
 #define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
 
-static inline pud_t *__pud_alloc(struct mm_struct *mm, pgd_t *pgd,
-				 unsigned long addr)
+static inline pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd,
+					  unsigned long addr)
 {
 	BUG();
 }

