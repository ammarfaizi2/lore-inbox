Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264261AbTCXQ4A>; Mon, 24 Mar 2003 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264281AbTCXQuE>; Mon, 24 Mar 2003 11:50:04 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:43754 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264261AbTCXQay>; Mon, 24 Mar 2003 11:30:54 -0500
Message-Id: <200303241642.h2OGg435008275@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:52 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: add another transparent bridge.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A proper PCI_DEVICE_ID... would have been nice,
but for now, this syncs with 2.4

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pci/quirks.c linux-2.5/drivers/pci/quirks.c
--- bk-linus/drivers/pci/quirks.c	2003-03-08 09:57:21.000000000 +0000
+++ linux-2.5/drivers/pci/quirks.c	2003-03-17 23:42:31.000000000 +0000
@@ -719,6 +719,7 @@ static struct pci_fixup pci_fixups[] __d
 	 * instead of 0x01.
 	 */
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge },
 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
 	
