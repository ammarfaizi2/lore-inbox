Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUDNWoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUDNWmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:42:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:53919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261989AbUDNWZQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:16 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <1081981450639@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:11 -0700
Message-Id: <108198145169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.13, 2004/04/02 11:02:40-08:00, mochel@digitalimplant.org

[PATCH] I2C: Add support for the ALi 1563 in the PCI IRQ routing code.


 arch/i386/pci/irq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Wed Apr 14 15:13:55 2004
+++ b/arch/i386/pci/irq.c	Wed Apr 14 15:13:55 2004
@@ -590,12 +590,13 @@
 {
 	switch(device)
 	{
-		case PCI_DEVICE_ID_AL_M1533:
+	case PCI_DEVICE_ID_AL_M1533:
+	case PCI_DEVICE_ID_AL_M1563:
+		printk("PCI: Using ALI IRQ Router\n");
 			r->name = "ALI";
 			r->get = pirq_ali_get;
 			r->set = pirq_ali_set;
 			return 1;
-		/* Should add 156x some day */
 	}
 	return 0;
 }

