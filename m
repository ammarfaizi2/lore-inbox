Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317990AbSGPUzd>; Tue, 16 Jul 2002 16:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGPUzB>; Tue, 16 Jul 2002 16:55:01 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:53464 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317985AbSGPUyN>;
	Tue, 16 Jul 2002 16:54:13 -0400
Date: Tue, 16 Jul 2002 13:57:09 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir255_comments.diff
Message-ID: <20020716135709.G28412@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir255_comments.diff :
-------------------
	o [FEATURE] Update MAINTAINERS file
	o [FEATURE] Update OHCI comment in irda-usb


diff -u -p linux/MAINTAINERS.d2 linux/MAINTAINERS
--- linux/MAINTAINERS.d2	Tue Jul 16 10:27:15 2002
+++ linux/MAINTAINERS	Tue Jul 16 10:34:34 2002
@@ -834,8 +834,15 @@ S:	Maintained
 IRDA SUBSYSTEM
 P:	Dag Brattli
 M:	Dag Brattli <dag@brattli.net>
-L:	linux-irda@pasta.cs.uit.no
+L:	irda-users@lists.sourceforge.net
 W:	http://irda.sourceforge.net/
+S:	Orphan
+
+IRDA CORE STACK + IRNET (Excluding other IrDA drivers/protocols)
+P:	Jean Tourrilhes
+M:	jt@hpl.hp.com
+L:	irda-users@lists.sourceforge.net
+W:	http://www.hpl.hp.com/personal/Jean_Tourrilhes/IrDA/
 S:	Maintained
 
 ISAPNP
diff -u -p linux/drivers/net/irda/irda-usb.d2.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d2.c	Tue Jul 16 10:02:27 2002
+++ linux/drivers/net/irda/irda-usb.c	Tue Jul 16 10:37:13 2002
@@ -30,19 +30,15 @@
  *			    IMPORTANT NOTE
  *			    --------------
  *
- * As of kernel 2.5.20, this is the state of compliance and testing of
+ * As of kernel 2.5.26, this is the state of compliance and testing of
  * this driver (irda-usb) with regards to the USB low level drivers...
  *
  * This driver has been tested SUCCESSFULLY with the following drivers :
- *	o usb-uhci-hcd	(For Intel/Via USB controllers)
- *	o uhci-hcd	(Alternate/JE driver for Intel/Via USB controllers)
+ *	o uhci-hcd	(For Intel/Via USB controllers)
+ *	o ohci-hcd	(For other USB controllers)
  *
  * This driver has NOT been tested with the following drivers :
  *	o ehci-hcd	(USB 2.0 controllers)
- *
- * This driver DOESN'T SEEM TO WORK with the following drivers :
- *	o ohci-hcd	(For other USB controllers)
- * The first outgoing URB never calls its completion/failure callback.
  *
  * Note that all HCD drivers do USB_ZERO_PACKET and timeout properly,
  * so we don't have to worry about that anymore.
