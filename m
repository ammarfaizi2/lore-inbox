Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJQVoE>; Thu, 17 Oct 2002 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJQVoD>; Thu, 17 Oct 2002 17:44:03 -0400
Received: from cerberus.stardot-tech.com ([67.105.126.66]:45074 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S262210AbSJQVnv>; Thu, 17 Oct 2002 17:43:51 -0400
Date: Thu, 17 Oct 2002 14:49:48 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: linux-kernel@vger.kernel.org
cc: Russell King <rmk+serial@arm.linux.org.uk>, <linux-serial@vger.kernel.org>
Subject: [PATCH 2.5] Add support for Lava Octopus-550 PCI multiport serial
 card
Message-ID: <Pine.LNX.4.44.0210171447300.10886-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch (against BK-2.5) adds support for the Lava Octopus-550
PCI multiport serial card.  The necessary PCI device IDs have already been
added to pci_ids.h.

 pci/pci.ids       |    2 ++
 serial/8250_pci.c |    8 ++++++++
 2 files changed, 10 insertions

		Jim

--
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.791   -> 1.792  
#	 drivers/pci/pci.ids	1.35    -> 1.36   
#	drivers/serial/8250_pci.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/17	jim@stardot-tech.com	1.792
# Add support for Lava Octopus-550 PCI multiport serial card
# --------------------------------------------
#
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Thu Oct 17 14:47:54 2002
+++ b/drivers/pci/pci.ids	Thu Oct 17 14:47:55 2002
@@ -4726,6 +4726,8 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
+	0180  Lava Octo A
+	0181  Lava Octo B
 	0200  Lava Port Plus
 	0201  Lava Quad A
 	0202  Lava Quad B
diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Thu Oct 17 14:47:55 2002
+++ b/drivers/serial/8250_pci.c	Thu Oct 17 14:47:55 2002
@@ -464,6 +464,7 @@
 	pbn_b0_bt_8_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_4_460800,
 
 	pbn_b1_1_115200,
 	pbn_b1_2_115200,
@@ -544,6 +545,7 @@
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 8, 115200 }, /* pbn_b0_bt_8_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 460800 }, /* pbn_b0_bt_4_460800 */
 
 	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
 	{ SPCI_FL_BASE1, 2, 115200 },		/* pbn_b1_2_115200 */
@@ -1094,6 +1096,12 @@
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
+	{       PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
+	{       PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_460800 },


