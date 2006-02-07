Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWBGOBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWBGOBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWBGOBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:01:16 -0500
Received: from mo00.po.2iij.Net ([210.130.202.204]:12031 "EHLO
	mo00.po.2iij.net") by vger.kernel.org with ESMTP id S965092AbWBGOBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:01:14 -0500
Date: Tue, 7 Feb 2006 23:00:58 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: add new PCI serial card support
Message-Id: <20060207230058.24587a3e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds new PCI serial card support.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -urN -X dontdiff rc2-orig/drivers/serial/8250_pci.c rc2/drivers/serial/8250_pci.c
--- rc2-orig/drivers/serial/8250_pci.c	2006-02-07 11:09:22.125034500 +0900
+++ rc2/drivers/serial/8250_pci.c	2006-02-07 22:35:31.421954750 +0900
@@ -1868,6 +1868,10 @@
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_4, 0, 0,
 		pbn_b0_4_1843200 },
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
+		PCI_VENDOR_ID_AFAVLAB,
+		PCI_SUBDEVICE_ID_AFAVLAB_P061, 0, 0,
+		pbn_b0_4_1152000 },
 	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232, 0, 0,
diff -urN -X dontdiff rc2-orig/include/linux/pci_ids.h rc2/include/linux/pci_ids.h
--- rc2-orig/include/linux/pci_ids.h	2006-02-07 11:09:53.470993500 +0900
+++ rc2/include/linux/pci_ids.h	2006-02-07 22:34:26.277883500 +0900
@@ -1829,6 +1829,7 @@
 #define PCI_VENDOR_ID_AFAVLAB		0x14db
 #define PCI_DEVICE_ID_AFAVLAB_P028	0x2180
 #define PCI_DEVICE_ID_AFAVLAB_P030	0x2182
+#define PCI_SUBDEVICE_ID_AFAVLAB_P061	0x2150
 
 #define PCI_VENDOR_ID_BROADCOM		0x14e4
 #define PCI_DEVICE_ID_TIGON3_5752	0x1600


