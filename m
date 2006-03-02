Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWCBPVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWCBPVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCBPVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:21:37 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17389 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751467AbWCBPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:21:36 -0500
Message-ID: <44070D26.40502@jp.fujitsu.com>
Date: Fri, 03 Mar 2006 00:20:06 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 4/4] PCI legacy I/O port free driver (take4) - Make Emulex
 lpfc driver legacy I/O port free
References: <44070B62.3070608@jp.fujitsu.com>
In-Reply-To: <44070B62.3070608@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Emulex lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/scsi/lpfc/lpfc_init.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.16-rc5-mm1/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/scsi/lpfc/lpfc_init.c	2006-03-01 13:53:27.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/scsi/lpfc/lpfc_init.c	2006-03-01 16:37:09.000000000 +0900
@@ -1368,6 +1368,9 @@
 	int i;
 	uint16_t iotag;
 
+	/* Don't need to use I/O port regions */
+	pdev->no_ioport = 1;
+
 	if (pci_enable_device(pdev))
 		goto out;
 	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))

