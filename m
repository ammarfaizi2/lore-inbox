Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWBVWQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWBVWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWBVWQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:16:30 -0500
Received: from fmr20.intel.com ([134.134.136.19]:28038 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751499AbWBVWLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:01 -0500
Date: Wed, 22 Feb 2006 14:02:48 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 11/13] ATA ACPI: fix pata host typo
Message-Id: <20060222140248.5a6e745e.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Fix a typo.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
@@ -4920,7 +4920,7 @@ int ata_pci_init_one (struct pci_dev *pd
 	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		printk(KERN_DEBUG "%s: NO_LEGACY == 0\n", __FUNCTION__);
 		port[0]->host_flags |= ATA_FLAG_PATA_MODE;
-		port[0]->host_flags &= ATA_FLAG_SATA;
+		port[0]->host_flags &= ~ATA_FLAG_SATA;
 		/* TODO: What if one channel is in native mode ... */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
