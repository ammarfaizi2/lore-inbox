Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWBNGMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWBNGMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWBNGMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:12:14 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:6837 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030481AbWBNGMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:12:12 -0500
Message-ID: <43F1744A.7080109@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 15:10:18 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [RFC][PATCH 4/4] PCI legacy I/O port free driver - Make Emulex lpfc
 driver legacy I/O port free
References: <43F172BA.1020405@jp.fujitsu.com>
In-Reply-To: <43F172BA.1020405@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes lpfc driver pci legacy free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/scsi/lpfc/lpfc_init.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.16-rc3/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.16-rc3.orig/drivers/scsi/lpfc/lpfc_init.c	2006-02-14 12:25:10.000000000 +0900
+++ linux-2.6.16-rc3/drivers/scsi/lpfc/lpfc_init.c	2006-02-14 12:28:08.000000000 +0900
@@ -1368,6 +1368,7 @@
 	int i;
 	uint16_t iotag;
 
+	pci_set_bar_mask_by_resource(pdev, IORESOURCE_MEM);
 	if (pci_enable_device(pdev))
 		goto out;
 	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))


