Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbSLRXgZ>; Wed, 18 Dec 2002 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbSLRXgZ>; Wed, 18 Dec 2002 18:36:25 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:57069 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267442AbSLRXgY>; Wed, 18 Dec 2002 18:36:24 -0500
Date: Wed, 18 Dec 2002 15:35:35 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mj@ucw.cz
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, andre@linux-ide.org, mlan@cpu.lu,
       toe@unlserve.unl.edu, kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Patch(2.5.52): Add missing PCI ID's for nVidia IDE and PlanB frame grabber
Message-ID: <20021218153535.A9491@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

	This patch adds two pci device id definitions needed to make
a couple of drivers compile in 2.5.52:

	drivers/ide/pci/nvidia.c needs PCI_DEVICE_IDE_NVIDIA_NFORCE_IDE
	drivers/media/video/planb.c needs PCI_DEVICE_IDE_APPLE_PLANB

	If nobody complains, could you please forward these changes to
Linus and confirm to me that you have done this (so I can have a
better idea of what to do if they not appear in 2.5.53)?  Thanks in
advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci_ids.diff"

--- linux-2.5.52/include/linux/pci_ids.h	2002-12-15 18:07:54.000000000 -0800
+++ linux/include/linux/pci_ids.h	2002-12-18 15:07:29.000000000 -0800
@@ -700,6 +700,7 @@
 #define PCI_VENDOR_ID_APPLE		0x106b
 #define PCI_DEVICE_ID_APPLE_BANDIT	0x0001
 #define PCI_DEVICE_ID_APPLE_GC		0x0002
+#define PCI_DEVICE_ID_APPLE_PLANB	0x0004
 #define PCI_DEVICE_ID_APPLE_HYDRA	0x000e
 #define PCI_DEVICE_ID_APPLE_UNI_N_FW	0x0018
 #define PCI_DEVICE_ID_APPLE_KL_USB	0x0019
@@ -946,6 +947,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL	0x017B
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL	0x017C
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_2		0x0202

--SUOF0GtieIMvvwua--
