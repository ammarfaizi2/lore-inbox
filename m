Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVAJR06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVAJR06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVAJRYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:24:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38289 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262361AbVAJRVH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:07 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776562762@kroah.com>
Date: Mon, 10 Jan 2005 09:20:56 -0800
Message-Id: <11053776563881@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.1, 2004/12/16 15:58:28-08:00, tglx@linutronix.de

[PATCH] PCI: Fix debug statement

Make the debug of setup-irq.c compile and work again

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/setup-irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
--- a/drivers/pci/setup-irq.c	2005-01-10 09:06:59 -08:00
+++ b/drivers/pci/setup-irq.c	2005-01-10 09:06:59 -08:00
@@ -53,7 +53,8 @@
 		irq = 0;
 	dev->irq = irq;
 
-	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", dev->dev.name, dev->irq));
+	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", 
+		dev->dev.kobj.name, dev->irq));
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */

