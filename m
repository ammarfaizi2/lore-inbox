Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRDRQUk>; Wed, 18 Apr 2001 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbRDRQUa>; Wed, 18 Apr 2001 12:20:30 -0400
Received: from ns.caldera.de ([212.34.180.1]:15881 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135217AbRDRQUS>;
	Wed, 18 Apr 2001 12:20:18 -0400
Date: Wed, 18 Apr 2001 18:20:12 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] toshoboe pci enable
Message-ID: <20010418182012.A24112@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Enable PCI for toshoboe IRDA adapters.

Ciao, Marcus

Index: drivers/net/irda/toshoboe.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/net/irda/toshoboe.c,v
retrieving revision 1.12
diff -u -r1.12 toshoboe.c
--- drivers/net/irda/toshoboe.c	2001/04/17 17:26:03	1.12
+++ drivers/net/irda/toshoboe.c	2001/04/18 16:18:24
@@ -722,6 +722,9 @@
       return -ENOMEM;
     }
 
+  if ((err=pci_enable_device(pci_dev)))
+	  return err;
+
   self = kmalloc (sizeof (struct toshoboe_cb), GFP_KERNEL);
 
   if (self == NULL)
