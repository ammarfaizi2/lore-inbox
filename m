Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161418AbWBUGft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161418AbWBUGft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWBUGfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:35:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55685 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161418AbWBUGfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:35:47 -0500
Message-ID: <43FAB444.7010401@jp.fujitsu.com>
Date: Tue, 21 Feb 2006 15:33:40 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: [PATCH 6/6] PCI legacy I/O port free driver (take2) - Make Emulex
 lpfc driver legacy I/O port free
References: <43FAB283.8090206@jp.fujitsu.com>
In-Reply-To: <43FAB283.8090206@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes lpfc driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/scsi/lpfc/lpfc_init.c |   54 +++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

Index: linux-2.6.16-rc4/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/scsi/lpfc/lpfc_init.c	2006-02-21 14:40:03.000000000 +0900
+++ linux-2.6.16-rc4/drivers/scsi/lpfc/lpfc_init.c	2006-02-21 14:40:57.000000000 +0900
@@ -1715,59 +1715,59 @@
 
 static struct pci_device_id lpfc_id_table[] = {
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_VIPER,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_FIREFLY,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_THOR,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_PEGASUS,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_CENTAUR,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_DRAGONFLY,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_SUPERFLY,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_RFLY,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_PFLY,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_NEPTUNE,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_NEPTUNE_SCSP,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_NEPTUNE_DCSP,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_HELIOS,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_HELIOS_SCSP,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_HELIOS_DCSP,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_BMID,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_BSMB,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZEPHYR,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZEPHYR_SCSP,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZEPHYR_DCSP,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZMID,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZSMB,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_TFLY,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_LP101,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_LP10000S,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_LP11000S,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_LPE11000S,
-		PCI_ANY_ID, PCI_ANY_ID, },
+	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},
 	{ 0 }
 };
 


