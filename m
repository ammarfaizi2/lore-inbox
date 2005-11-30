Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVK3AAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVK3AAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVK3AAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:00:38 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:34499 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751415AbVK3AAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:00:36 -0500
Date: Wed, 30 Nov 2005 01:00:35 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000545.1009.64699.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
References: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 5/6] drivers/*rest*: Replace pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 parport/parport_serial.c |    2 +-
 pcmcia/vrc4173_cardu.c   |    2 +-
 serial/serial_txx9.c     |    2 +-
 video/cyblafb.c          |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -Narup a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
--- a/drivers/serial/serial_txx9.c	2005-11-29 11:04:52.000000000 +0100
+++ b/drivers/serial/serial_txx9.c	2005-11-29 16:35:25.000000000 +0100
@@ -1195,7 +1195,7 @@ static int __init serial_txx9_init(void)
 		serial_txx9_register_ports(&serial_txx9_reg);
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
-		ret = pci_module_init(&serial_txx9_pci_driver);
+		ret = pci_register_driver(&serial_txx9_pci_driver);
 #endif
 	}
 	return ret;
diff -Narup a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
--- a/drivers/video/cyblafb.c	2005-11-29 11:09:00.000000000 +0100
+++ b/drivers/video/cyblafb.c	2005-11-29 16:46:18.000000000 +0100
@@ -1440,7 +1440,7 @@ static int __devinit cyblafb_init(void)
 		}
 #endif
 	output("CyblaFB version %s initializing\n",VERSION);
-	return pci_module_init(&cyblafb_pci_driver);
+	return pci_register_driver(&cyblafb_pci_driver);
 }
 
 static void __exit cyblafb_exit(void)
diff -Narup a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
--- a/drivers/parport/parport_serial.c	2005-11-29 11:04:52.000000000 +0100
+++ b/drivers/parport/parport_serial.c	2005-11-29 16:33:13.000000000 +0100
@@ -464,7 +464,7 @@ static struct pci_driver parport_serial_
 
 static int __init parport_serial_init (void)
 {
-	return pci_module_init (&parport_serial_pci_driver);
+	return pci_register_driver (&parport_serial_pci_driver);
 }
 
 static void __exit parport_serial_exit (void)
diff -Narup a/drivers/pcmcia/vrc4173_cardu.c b/drivers/pcmcia/vrc4173_cardu.c
--- a/drivers/pcmcia/vrc4173_cardu.c	2005-11-29 11:04:48.000000000 +0100
+++ b/drivers/pcmcia/vrc4173_cardu.c	2005-11-29 16:32:23.000000000 +0100
@@ -604,7 +604,7 @@ static int __devinit vrc4173_cardu_init(
 {
 	vrc4173_cardu_slots = 0;
 
-	return pci_module_init(&vrc4173_cardu_driver);
+	return pci_register_driver(&vrc4173_cardu_driver);
 }
 
 static void __devexit vrc4173_cardu_exit(void)
