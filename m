Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267428AbUHPEr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267428AbUHPEr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHPEr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:47:26 -0400
Received: from ozlabs.org ([203.10.76.45]:11986 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267428AbUHPErY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:47:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16672.14100.498440.264776@cargo.ozlabs.ibm.com>
Date: Mon, 16 Aug 2004 14:24:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, ananth@in.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 set tbl->it_type in iommu code
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that sets struct iommu_table->it_type to TCE_PCI in
pSeries_iommu.c.  This is just for code completeness (and it is
updated in iSeries_iommu.c, but was somehow missed in
pSeries_iommu.c).

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Naurp temp/arch/ppc64/kernel/pSeries_iommu.c risc/arch/ppc64/kernel/pSeries_iommu.c
--- temp/arch/ppc64/kernel/pSeries_iommu.c	2004-07-18 09:57:47.000000000 +0500
+++ risc/arch/ppc64/kernel/pSeries_iommu.c	2004-07-22 16:24:53.000000000 +0500
@@ -211,6 +211,7 @@ static void iommu_table_setparms(struct
 	tbl->it_index = 0;
 	tbl->it_entrysize = sizeof(union tce_entry);
 	tbl->it_blocksize = 16;
+	tbl->it_type = TCE_PCI;
 }

 /*
@@ -246,6 +247,7 @@ static void iommu_table_setparms_lpar(st
 	tbl->it_index  = dma_window[0];
 	tbl->it_entrysize = sizeof(union tce_entry);
 	tbl->it_blocksize  = 16;
+	tbl->it_type = TCE_PCI;
 }


