Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUGXS4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUGXS4K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGXS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:56:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3810 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262106AbUGXS4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:56:07 -0400
Date: Sat, 24 Jul 2004 11:56:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Export some DMA API symbols
Message-ID: <20040724115605.B32427@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exports some DMA API symbols so module clients work.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/kernel/dma-mapping.c 1.1 vs edited =====
--- 1.1/arch/ppc/kernel/dma-mapping.c	Sat May 29 10:56:08 2004
+++ edited/arch/ppc/kernel/dma-mapping.c	Fri Jun  4 14:08:41 2004
@@ -254,6 +254,7 @@
  no_page:
 	return NULL;
 }
+EXPORT_SYMBOL(__dma_alloc_coherent);
 
 /*
  * free a page as defined by the above mapping.
@@ -317,7 +318,7 @@
 	       __func__, vaddr);
 	dump_stack();
 }
-EXPORT_SYMBOL(dma_free_coherent);
+EXPORT_SYMBOL(__dma_free_coherent);
 
 /*
  * Initialise the consistent memory allocation.
