Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282976AbRLQWnr>; Mon, 17 Dec 2001 17:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282988AbRLQWnh>; Mon, 17 Dec 2001 17:43:37 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:5328 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S282976AbRLQWn1>; Mon, 17 Dec 2001 17:43:27 -0500
From: Ronald Lembcke <es186@fen-net.de>
Date: Mon, 17 Dec 2001 23:42:26 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] alpha jensen, sync pci-noop.c to pci.h (for <= 2.4.17rc1)
Message-ID: <20011217224226.GA14912@defiant.crash>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patche fixes a few dummy-functions only used for the old
Alpha - Jensen computers.

asm/pci.h got changed but pci-noop was left unchanged, resulting
in compile errors. The bug has probably been there for some time
(at least 2.4.16, didn't check earlier)


--- linux/arch/alpha/kernel/pci-noop.c_2.4.17rc1	Sun Dec 16 22:17:59 2001
+++ linux/arch/alpha/kernel/pci-noop.c	Sun Dec 16 22:17:54 2001
@@ -104,21 +104,21 @@
 }
 /* stubs for the routines in pci_iommu.c */
 void *
-pci_alloc_consistent(struct pci_dev *pdev, long size, dma_addr_t *dma_addrp)
+pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
 {
 }
 void
-pci_free_consistent(struct pci_dev *pdev, long size, void *cpu_addr,
+pci_free_consistent(struct pci_dev *pdev, size_t size, void *cpu_addr,
 		    dma_addr_t dma_addr)
 {
 }
 dma_addr_t
-pci_map_single(struct pci_dev *pdev, void *cpu_addr, long size,
+pci_map_single(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	       int direction)
 {
 }
 void
-pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, long size,
+pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, size_t size,
 		 int direction)
 {
 }

