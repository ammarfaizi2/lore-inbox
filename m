Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSKROGc>; Mon, 18 Nov 2002 09:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKROGb>; Mon, 18 Nov 2002 09:06:31 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:5248 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262692AbSKROGa>;
	Mon, 18 Nov 2002 09:06:30 -0500
Date: Mon, 18 Nov 2002 15:13:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bttv & 2.5.48
Message-ID: <20021118141328.GA10815@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,
   I did not saw this patch posted... PCI now does not have its own name,
and it uses dev's name. Please apply.
							Petr Vandrovec
							vandrove@vc.cvut.cz


diff -urdN linux/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux/drivers/media/video/bttv-cards.c	2002-11-18 13:50:42.000000000 +0000
+++ linux/drivers/media/video/bttv-cards.c	2002-11-18 13:55:51.000000000 +0000
@@ -2990,7 +2990,7 @@
 
 	/* print which chipset we have */
 	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
-		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);
+		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->dev.name);
 
 	/* print warnings about any quirks found */
 	if (triton1)
