Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUDOR1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDOR0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:26:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:16558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263136AbUDORYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:05 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1082049825687@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <10820498251037@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.8, 2004/03/31 14:53:59-08:00, rddunlap@osdl.org

[PATCH] PCI: move DMA_nnBIT_MASK to linux/dma-mapping.h


 include/linux/dma-mapping.h |    3 +++
 include/linux/pci.h         |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- a/include/linux/dma-mapping.h	Thu Apr 15 10:04:50 2004
+++ b/include/linux/dma-mapping.h	Thu Apr 15 10:04:50 2004
@@ -10,6 +10,9 @@
 	DMA_NONE = 3,
 };
 
+#define DMA_64BIT_MASK	0xffffffffffffffffULL
+#define DMA_32BIT_MASK	0x00000000ffffffffULL
+
 #include <asm/dma-mapping.h>
 
 /* Backwards compat, remove in 2.7.x */
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Apr 15 10:04:50 2004
+++ b/include/linux/pci.h	Thu Apr 15 10:04:50 2004
@@ -433,9 +433,6 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
-#define DMA_64BIT_MASK	0xffffffffffffffffULL
-#define DMA_32BIT_MASK	0x00000000ffffffffULL
-
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 

