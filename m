Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTEaWFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264475AbTEaWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:05:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1764 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264473AbTEaWFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:05:40 -0400
Date: Sun, 1 Jun 2003 00:18:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [2.5 patch] let USB_GADGET depend on USB
Message-ID: <20030531221855.GM29425@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB_GADGET is still selectable even with USB disabled. It seems the 
following is intended:


--- linux-2.5.70-mm3/drivers/usb/gadget/Kconfig.old	2003-06-01 00:15:30.000000000 +0200
+++ linux-2.5.70-mm3/drivers/usb/gadget/Kconfig	2003-06-01 00:15:49.000000000 +0200
@@ -8,7 +8,7 @@
 #
 menuconfig USB_GADGET
 	tristate "Support for USB Gadgets"
-	depends on EXPERIMENTAL
+	depends on USB && EXPERIMENTAL
 	help
 	   USB is a master/slave protocol, organized with one master
 	   host (such as a PC) controlling up to 127 peripheral devices.



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

