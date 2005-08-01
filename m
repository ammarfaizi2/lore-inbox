Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVHAPlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVHAPlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVHAPlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:41:15 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:58358 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262120AbVHAPjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:39:04 -0400
Date: Tue, 2 Aug 2005 00:38:15 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: remove obsolete GIU function call for vr41xx
Message-Id: <20050802003815.27bee9ea.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has removed obsolete GIU function call for vr41xx.
This patch already has been applied to mips tree.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc4-orig/arch/mips/pci/fixup-tb0219.c rc4/arch/mips/pci/fixup-tb0219.c
--- rc4-orig/arch/mips/pci/fixup-tb0219.c	2005-07-29 07:44:44.000000000 +0900
+++ rc4/arch/mips/pci/fixup-tb0219.c	2005-07-30 01:23:53.000000000 +0900
@@ -29,27 +29,12 @@
 
 	switch (slot) {
 	case 12:
-		vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN,
-				     LEVEL_LOW);
 		irq = TB0219_PCI_SLOT1_IRQ;
 		break;
 	case 13:
-		vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN,
-				     LEVEL_LOW);
 		irq = TB0219_PCI_SLOT2_IRQ;
 		break;
 	case 14:
-		vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN,
-				     LEVEL_LOW);
 		irq = TB0219_PCI_SLOT3_IRQ;
 		break;
 	default:
