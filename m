Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbULAPzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbULAPzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbULAPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:55:46 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:41408 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261284AbULAPzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:55:20 -0500
Date: Wed, 1 Dec 2004 16:55:24 +0100
From: Kronos <kronos@people.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.29-pre1] Add new PCI id to radeonfb
Message-ID: <20041201155524.GA14588@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
this is a trivial patch for 2.4.29-pre1.

Add support for the following radeon board (thanks to Jurriaan):

lspci:
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AQ [Radeon 9600]
0000:01:00.1 Display controller: ATI Technologies Inc RV350 AQ [Radeon 9600] (Secondary)

lspci -n:
0000:01:00.0 Class 0300: 1002:4151
0000:01:00.1 Class 0380: 1002:4171

Signed-off-by: Luca Tettamanti <kronos@people.it>

--- a/drivers/video/radeonfb.c	2004-11-30 20:53:05.000000000 +0100
+++ b/drivers/video/radeonfb.c	2004-11-30 20:37:33.000000000 +0100
@@ -218,6 +218,7 @@
 	RADEON_NH,
 	RADEON_NI,
 	RADEON_AP,
+	RADEON_AQ,
 	RADEON_AR,
 };
 
@@ -279,6 +280,7 @@
 	{ "9800 NH", RADEON_R350 },
 	{ "9800 NI", RADEON_R350 },
 	{ "9600 AP", RADEON_RV350 },
+	{ "9600 AQ", RADEON_RV350 },
 	{ "9600 AR", RADEON_RV350 },
 };
 
@@ -334,6 +336,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yd},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AD},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AP},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AQ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AQ},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AR},
 	{ 0, }
 };
--- a/include/linux/pci_ids.h	2004-11-30 20:52:58.000000000 +0100
+++ b/include/linux/pci_ids.h	2004-11-30 20:37:58.000000000 +0100
@@ -303,6 +303,7 @@
 #define PCI_DEVICE_ID_ATI_RADEON_NI	0x4e49
 /* Radeon RV350 (9600) */
 #define PCI_DEVICE_ID_ATI_RADEON_AP	0x4150
+#define PCI_DEVICE_ID_ATI_RADEON_AQ	0x4151
 #define PCI_DEVICE_ID_ATI_RADEON_AR	0x4152
 /* Radeon M6 */
 #define PCI_DEVICE_ID_ATI_RADEON_LY	0x4c59


Luca
-- 
Home: http://kronoz.cjb.net
Sono un mirabile incrocio tra Tarzan e Giacomo Leopardi.
In me convivono tutte le doti intelluttuali di Tarzan e
tutta la prestanza fisica di Giacomo Leopardi.
A. Borsani
