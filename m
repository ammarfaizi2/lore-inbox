Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVACOYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVACOYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVACOYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:24:05 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:1519 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261457AbVACOYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:24:01 -0500
Date: Mon, 3 Jan 2005 15:24:08 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] s390: fix pgd_index() compile warnings
Message-ID: <20050103142408.GA12380@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the patch below fixes a few compile warnings due to missing parenthesizes.

Please apply. Thanks,

Heiko

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2005-01-03 14:56:02.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2005-01-03 15:05:38.000000000 +0100
@@ -681,7 +681,7 @@
 #define pgd_page_kernel(pgd) (pgd_val(pgd) & PAGE_MASK)
 
 /* to find an entry in a page-table-directory */
-#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
 
 /* to find an entry in a kernel page-table-directory */
