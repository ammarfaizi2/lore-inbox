Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWFZF2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWFZF2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWFZF2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:28:04 -0400
Received: from xenotime.net ([66.160.160.81]:46557 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964771AbWFZF2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:28:03 -0400
Date: Sun, 25 Jun 2006 22:30:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] IOAT: fix sparse ulong warning
Message-Id: <20060625223049.f7d2f249.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix sparse warning:
drivers/dma/ioatdma.c:444:32: warning: constant 0xFFFFFFFFFFFFFFC0 is so big it is unsigned long

Also needs a MAINTAINERS entry.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/dma/ioatdma_registers.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g9.orig/drivers/dma/ioatdma_registers.h
+++ linux-2617-g9/drivers/dma/ioatdma_registers.h
@@ -76,7 +76,7 @@
 #define IOAT_CHANSTS_OFFSET			0x04	/* 64-bit Channel Status Register */
 #define IOAT_CHANSTS_OFFSET_LOW			0x04
 #define IOAT_CHANSTS_OFFSET_HIGH		0x08
-#define IOAT_CHANSTS_COMPLETED_DESCRIPTOR_ADDR	0xFFFFFFFFFFFFFFC0
+#define IOAT_CHANSTS_COMPLETED_DESCRIPTOR_ADDR	0xFFFFFFFFFFFFFFC0UL
 #define IOAT_CHANSTS_SOFT_ERR			0x0000000000000010
 #define IOAT_CHANSTS_DMA_TRANSFER_STATUS	0x0000000000000007
 #define IOAT_CHANSTS_DMA_TRANSFER_STATUS_ACTIVE	0x0


---
