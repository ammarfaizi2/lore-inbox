Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbUK3B6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUK3B6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUK3B5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:57:39 -0500
Received: from baikonur.stro.at ([213.239.196.228]:46017 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261820AbUK3B5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:22 -0500
Subject: [patch 04/11] Subject: ifdef typos: arch_ppc_syslib_ppc4xx_dma.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:19 +0100
Message-ID: <E1CYxGa-0002lo-0a@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ppc4xx_dma.h defines PPC4xx_DMA_64BIT.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/arch/ppc/syslib/ppc4xx_dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/ppc/syslib/ppc4xx_dma.c~ifdef-arch_ppc_syslib_ppc4xx_dma arch/ppc/syslib/ppc4xx_dma.c
--- linux-2.6.10-rc2-bk13/arch/ppc/syslib/ppc4xx_dma.c~ifdef-arch_ppc_syslib_ppc4xx_dma	2004-11-30 02:41:35.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/ppc/syslib/ppc4xx_dma.c	2004-11-30 02:41:35.000000000 +0100
@@ -48,7 +48,7 @@ ppc4xx_set_src_addr(int dmanr, phys_addr
 		return;
 	}
 
-#ifdef PPC4xx_DMA64BIT
+#ifdef PPC4xx_DMA_64BIT
 	mtdcr(DCRN_DMASAH0 + dmanr*2, (u32)(src_addr >> 32));
 #else
 	mtdcr(DCRN_DMASA0 + dmanr*2, (u32)src_addr);
@@ -63,7 +63,7 @@ ppc4xx_set_dst_addr(int dmanr, phys_addr
 		return;
 	}
 
-#ifdef PPC4xx_DMA64BIT
+#ifdef PPC4xx_DMA_64BIT
 	mtdcr(DCRN_DMADAH0 + dmanr*2, (u32)(dst_addr >> 32));
 #else
 	mtdcr(DCRN_DMADA0 + dmanr*2, (u32)dst_addr);
_
