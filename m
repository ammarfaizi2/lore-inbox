Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUI0GYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUI0GYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 02:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUI0GYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 02:24:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:39306 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266181AbUI0GYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 02:24:41 -0400
Subject: [PATCH] ppc64: Fix spelling error in callback name
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096266173.1102.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 16:22:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

A small spelling error slipped into a new ppc_md. platform call I added
in my last patch. Not very problematic but worth fixing before any code
using the new call gets pushed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc64/machdep.h 1.32 vs edited =====
--- 1.32/include/asm-ppc64/machdep.h	2004-09-21 16:07:38 +10:00
+++ edited/include/asm-ppc64/machdep.h	2004-09-27 16:20:10 +10:00
@@ -58,7 +58,7 @@
 					    int local);
 	/* special for kexec, to be called in real mode, linar mapping is
 	 * destroyed as well */
-	void		(*htpe_clear_all)(void);
+	void		(*hpte_clear_all)(void);
 
 	void		(*tce_build)(struct iommu_table * tbl,
 				     long index,
===== arch/ppc64/kernel/pSeries_lpar.c 1.41 vs edited =====
--- 1.41/arch/ppc64/kernel/pSeries_lpar.c	2004-09-22 14:40:30 +10:00
+++ edited/arch/ppc64/kernel/pSeries_lpar.c	2004-09-27 16:20:05 +10:00
@@ -439,7 +439,7 @@
 	ppc_md.hpte_insert	= pSeries_lpar_hpte_insert;
 	ppc_md.hpte_remove	= pSeries_lpar_hpte_remove;
 	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
-	ppc_md.htpe_clear_all   = pSeries_lpar_hptab_clear;
+	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
 
 	htab_finish_init();
 }


