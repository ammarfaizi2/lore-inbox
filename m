Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUJYB7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUJYB7m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUJYB7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:59:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:20941 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261664AbUJYB7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:59:11 -0400
Subject: [PATCH] ppc64: remove unused cruft from prom.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 11:57:05 +1000
Message-Id: <1098669425.26697.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes some bogus struct definitions from prom.h that aren't
used anymore after the other pending ppc64 patches have been applied.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc64/prom.h
===================================================================
--- linux-work.orig/include/asm-ppc64/prom.h	2004-09-24 14:36:14.000000000 +1000
+++ linux-work/include/asm-ppc64/prom.h	2004-10-25 11:55:43.447229784 +1000
@@ -93,33 +93,6 @@
 	unsigned int size;
 };
 
-struct pci_range32 {
-	struct pci_address child_addr;
-	unsigned int  parent_addr;
-  	unsigned long size; 
-};
-
-struct pci_range64 {
-	struct pci_address child_addr;
-  	unsigned long parent_addr;
-        unsigned long size; 
-};
-
-union pci_range {
-	struct {
-		struct pci_address addr;
-		u32 phys;
-		u32 size_hi;
-	} pci32;
-	struct {
-		struct pci_address addr;
-		u32 phys_hi;
-		u32 phys_lo;
-		u32 size_hi;
-		u32 size_lo;
-	} pci64;
-};
-
 struct of_tce_table {
 	phandle node;
 	unsigned long base;


