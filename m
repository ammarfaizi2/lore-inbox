Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272150AbTHIAcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272161AbTHIAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:32:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:50623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272150AbTHIAcE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:04 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1060389134592@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.6.0-test2
In-Reply-To: <10603891342225@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 17:32:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1119.1.3, 2003/08/06 16:16:40-07:00, alex_williamson@hp.com

[PATCH] PCI: trivial 2.4/2.6 PCI name change/addition

   This patch renames the PCI-X adapter found in HP zx1 and sx1000
ia64 systems to something more generic and descriptive.  It also
adds an ID for the PCI adapter used in sx1000.  Patches against
2.4.21+ia64 and 2.6.0-test2+ia64 attached.  Thanks,


 drivers/char/agp/hp-agp.c |    2 +-
 drivers/pci/pci.ids       |    3 ++-
 include/linux/pci_ids.h   |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
--- a/drivers/char/agp/hp-agp.c	Fri Aug  8 17:25:07 2003
+++ b/drivers/char/agp/hp-agp.c	Fri Aug  8 17:25:07 2003
@@ -398,7 +398,7 @@
 	bridge->driver = &hp_zx1_driver;
 
 	fake_bridge_dev.vendor = PCI_VENDOR_ID_HP;
-	fake_bridge_dev.device = PCI_DEVICE_ID_HP_ZX1_LBA;
+	fake_bridge_dev.device = PCI_DEVICE_ID_HP_PCIX_LBA;
 	bridge->dev = &fake_bridge_dev;
 
 	return agp_add_bridge(bridge);
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Fri Aug  8 17:25:07 2003
+++ b/drivers/pci/pci.ids	Fri Aug  8 17:25:07 2003
@@ -1286,6 +1286,7 @@
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
+	1054  PCI Local Bus Adapter
 	1064  79C970 PCnet Ethernet Controller
 	108b  Visualize FXe
 	10c1  NetServer Smart IRQ Router
@@ -1297,7 +1298,7 @@
 	121c  NetServer PCI COM Port Decoder
 	1229  zx1 System Bus Adapter
 	122a  zx1 I/O Controller
-	122e  zx1 Local Bus Adapter
+	122e  PCI-X/AGP Local Bus Adapter
 	1290  Auxiliary Diva Serial Port
 	2910  E2910A PCIBus Exerciser
 	2925  E2925A 32 Bit, 33 MHzPCI Exerciser & Analyzer
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri Aug  8 17:25:07 2003
+++ b/include/linux/pci_ids.h	Fri Aug  8 17:25:07 2003
@@ -608,6 +608,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_TOSCA1	0x1049
 #define PCI_DEVICE_ID_HP_DIVA_TOSCA2	0x104A
 #define PCI_DEVICE_ID_HP_DIVA_MAESTRO	0x104B
+#define PCI_DEVICE_ID_HP_PCI_LBA	0x1054
 #define PCI_DEVICE_ID_HP_REO_SBA	0x10f0
 #define PCI_DEVICE_ID_HP_REO_IOC	0x10f1
 #define PCI_DEVICE_ID_HP_VISUALIZE_FXE	0x108b
@@ -616,7 +617,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_POWERBAR	0x1227
 #define PCI_DEVICE_ID_HP_ZX1_SBA	0x1229
 #define PCI_DEVICE_ID_HP_ZX1_IOC	0x122a
-#define PCI_DEVICE_ID_HP_ZX1_LBA	0x122e
+#define PCI_DEVICE_ID_HP_PCIX_LBA	0x122e
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290

