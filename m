Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbULMV0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbULMV0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbULMV0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:26:14 -0500
Received: from pD953A0E2.dip.t-dialin.net ([217.83.160.226]:19349 "EHLO
	tglx.tec.linutronix.de") by vger.kernel.org with ESMTP
	id S261162AbULMV0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:26:07 -0500
Date: Mon, 13 Dec 2004 22:25:41 +0100
From: tglx@linutronix.de
Message-ID: <20041213222539.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix debug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the debug of setup-irq.c compile and work again

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
--- drivers/pci/setup-irq.c	(revision 8)
+++ drivers/pci/setup-irq.c	(working copy)
@@ -53,7 +53,8 @@
 		irq = 0;
 	dev->irq = irq;
 
-	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", dev->dev.name, dev->irq));
+	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", 
+		dev->dev.kobj.name, dev->irq));
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
