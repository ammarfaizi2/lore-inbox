Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUJLASu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUJLASu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUJLARW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:17:22 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:10115
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269381AbUJLAQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:16:56 -0400
Subject: [patch 3/6] uml: finish update for 2.6.8 API changes
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:16:28 +0200
Message-Id: <20041012001629.0C80B868D@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some updates for API changes in 2.6.8 which were not included in the original
UML patch; these fixes were detected by some warnings, so I probably missed some more
ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/dma-mapping.h |    2 ++
 1 files changed, 2 insertions(+)

diff -puN include/asm-um/dma-mapping.h~uml-update-2.6.8-finish include/asm-um/dma-mapping.h
--- linux-2.6.9-current/include/asm-um/dma-mapping.h~uml-update-2.6.8-finish	2004-10-12 01:06:00.296443160 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/dma-mapping.h	2004-10-12 01:06:00.298442856 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <asm/scatterlist.h>
+
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
_
