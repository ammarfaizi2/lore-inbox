Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUHODH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUHODH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 23:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUHODH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 23:07:28 -0400
Received: from gate.ebshome.net ([66.92.248.57]:34953 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S266334AbUHODHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 23:07:21 -0400
Date: Sat, 14 Aug 2004 20:07:17 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][PPC32] export __dma_sync & __dma_sync_page
Message-ID: <20040815030717.GA23796@gate.ebshome.net>
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing exports for __dma_sync and __dma_sync_page (DMA API 
helpers for non-coherent cache PPCs).

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

===== dma-mapping.c 1.2 vs edited =====
--- 1.2/arch/ppc/kernel/dma-mapping.c	2004-07-28 21:58:35 -07:00
+++ edited/dma-mapping.c	2004-08-14 19:15:56 -07:00
@@ -381,6 +381,7 @@
 		break;
 	}
 }
+EXPORT_SYMBOL(__dma_sync);
 
 #ifdef CONFIG_HIGHMEM
 /*
@@ -438,3 +439,4 @@
 	__dma_sync((void *)start, size, direction);
 #endif
 }
+EXPORT_SYMBOL(__dma_sync_page);
