Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJQVle>; Thu, 17 Oct 2002 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbSJQVle>; Thu, 17 Oct 2002 17:41:34 -0400
Received: from cerberus.stardot-tech.com ([67.105.126.66]:41490 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S262187AbSJQVlc>; Thu, 17 Oct 2002 17:41:32 -0400
Date: Thu, 17 Oct 2002 14:47:26 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: linux-kernel@vger.kernel.org
cc: Ed Vance <serial24@macrolink.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH 2.4] Add support for Lava Octopus serial card
Message-ID: <Pine.LNX.4.44.0210171443360.10886-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch (against BK-2.4) adds support for the Lava Octopus-550
PCI multiport serial card.  The necessary PCI device IDs have already been
added to pci_ids.h.

 char/serial.c |    8 ++++++++
 pci/pci.ids   |    2 ++
 2 files changed, 10 insertions

		Jim
--
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.794   -> 1.795  
#	 drivers/pci/pci.ids	1.30    -> 1.31   
#	drivers/char/serial.c	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/17	jim@stardot-tech.com	1.795
# Add support for Lava Octopus-550 PCI multiport serial card
# --------------------------------------------
#
diff -Nru a/drivers/char/serial.c b/drivers/char/serial.c
--- a/drivers/char/serial.c	Thu Oct 17 14:47:40 2002
+++ b/drivers/char/serial.c	Thu Oct 17 14:47:40 2002
@@ -4308,6 +4308,7 @@
 	pbn_b0_bt_2_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_4_460800,
 	pbn_b0_bt_2_921600,
 
 	pbn_b1_1_115200,
@@ -4389,6 +4390,7 @@
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 460800 }, /* pbn_b0_bt_4_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b0_bt_2_921600 */
 
 	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
@@ -4854,6 +4856,12 @@
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_1_115200 },
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Thu Oct 17 14:47:40 2002
+++ b/drivers/pci/pci.ids	Thu Oct 17 14:47:40 2002
@@ -4725,6 +4725,8 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
+	0180  Lava Octo A
+	0181  Lava Octo B
 	0200  Lava Port Plus
 	0201  Lava Quad A
 	0202  Lava Quad B

