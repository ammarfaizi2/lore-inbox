Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbTBRRPF>; Tue, 18 Feb 2003 12:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbTBRROt>; Tue, 18 Feb 2003 12:14:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:20682 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S267899AbTBRRMl>; Tue, 18 Feb 2003 12:12:41 -0500
Date: Tue, 18 Feb 2003 17:24:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Pam Delaney <pdelaney@lsil.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] broken MPT Fusion build
Message-ID: <Pine.LNX.4.44.0302181717440.7702-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.62's removal of scsi_set_pci_device broke the MPT Fusion build.

--- 2.5.62/drivers/message/fusion/mptbase.h	Thu Jan  2 09:06:16 2003
+++ linux/drivers/message/fusion/mptbase.h	Tue Feb 18 16:53:18 2003
@@ -603,7 +603,7 @@
 	dma_addr_t		 sense_buf_pool_dma;
 	u32			 sense_buf_low_dma;
 	int			 mtrr_reg;
-	void			*pcidev;	/* struct pci_dev pointer */
+	struct pci_dev		*pcidev;
 	u8			*memmap;	/* mmap address */
 	struct Scsi_Host	*sh;		/* Scsi Host pointer */
 	ScsiCfgData		spi_data;	/* Scsi config. data */

