Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266454AbRGCHJX>; Tue, 3 Jul 2001 03:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265565AbRGCHJN>; Tue, 3 Jul 2001 03:09:13 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:60431 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266454AbRGCHJF>; Tue, 3 Jul 2001 03:09:05 -0400
Date: Tue, 3 Jul 2001 09:08:34 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] fix TI 1410 lockups
Message-ID: <20010703090834.I639@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes machine lockups with a TI 1410 cardbus bridge (as used
on Lucent PCI-PCMCIA adapter for Orinoco cards). The patch is against
linux-2.4.5-ac23.

Index: include/linux/pci_ids.h
===================================================================
RCS file: /home/erik/cvsroot/elinux/include/linux/pci_ids.h,v
retrieving revision 1.1.1.90
diff -u -r1.1.1.90 pci_ids.h
--- include/linux/pci_ids.h	2001/07/03 00:30:13	1.1.1.90
+++ include/linux/pci_ids.h	2001/07/03 06:48:16
@@ -524,6 +524,7 @@
 #define PCI_DEVICE_ID_TI_1251B		0xac1f
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
+#define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1420		0xac51
 
 #define PCI_VENDOR_ID_SONY		0x104d
Index: drivers/pcmcia/yenta.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/drivers/pcmcia/yenta.c,v
retrieving revision 1.1.1.61
diff -u -r1.1.1.61 yenta.c
--- drivers/pcmcia/yenta.c	2001/07/03 00:27:54	1.1.1.61
+++ drivers/pcmcia/yenta.c	2001/07/03 06:48:51
@@ -793,6 +793,7 @@
 	{ PD(TI,1251A),	&ti_ops },
 	{ PD(TI,1211),	&ti_ops },
 	{ PD(TI,1251B),	&ti_ops },
+	{ PD(TI,1410),	&ti_ops },
 	{ PD(TI,1420),	&ti_ops },
 	{ PD(TI,4410),	&ti_ops },
 	{ PD(TI,4451),	&ti_ops },


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
