Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264590AbUDWTP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbUDWTP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUDWTP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:15:27 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:2475 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S264590AbUDWTPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:15:22 -0400
Date: Fri, 23 Apr 2004 21:14:29 +0200
To: trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] include/asm-ppc/dma-mapping.h: dma_unmap_page()
Message-ID: <20040423191429.GA14356@mars>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org> <20040114161306.GA16950@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114161306.GA16950@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Duplicate definition of dma_unmap_single() should actually be
dma_unmap_page().

Against 2.6.6-rc2. Thanks.


 dma-mapping.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


--- a/include/asm-ppc/dma-mapping.h	2004-04-11 14:05:45.000000000 +0200
+++ b/include/asm-ppc/dma-mapping.h	2004-04-22 18:06:53.000000000 +0200
@@ -77,7 +77,7 @@ dma_map_page(struct device *dev, struct 
 }
 
 /* We do nothing. */
-#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
+#define dma_unmap_page(dev, addr, size, dir)	do { } while (0)
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
