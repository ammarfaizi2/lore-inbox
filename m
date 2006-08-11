Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWHKTdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWHKTdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHKTds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:33:48 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:54908 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932280AbWHKTdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:33:47 -0400
From: Daniel Drake <dsd@gentoo.org>
To: akpm@osdl.org
Cc: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: jeff@garzik.org
Cc: bzolnier@gmail.com
Subject: [PATCH resend] via82cxxx: Add VIA VT8237A southbridge ID
Message-Id: <20060811193346.E2D0C8E75CD@zog.reactivated.net>
Date: Fri, 11 Aug 2006 20:33:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some motherboards based on the KT890 chipset include this southbridge. Adding
it allows the via82cxxx IDE driver to be used on these systems.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

---

No respose from Bart on this one, and the ide git tree seems rather dead.
Can this go direct to Linus from here?

Index: linux/drivers/ide/pci/via82cxxx.c
===================================================================
--- linux.orig/drivers/ide/pci/via82cxxx.c
+++ linux/drivers/ide/pci/via82cxxx.c
@@ -81,6 +81,7 @@ static struct via_isa_bridge {
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
