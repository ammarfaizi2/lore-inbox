Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaSVG>; Sun, 31 Dec 2000 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaSU5>; Sun, 31 Dec 2000 13:20:57 -0500
Received: from waste.org ([209.173.204.2]:1907 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129324AbQLaSUm>;
	Sun, 31 Dec 2000 13:20:42 -0500
Date: Sun, 31 Dec 2000 11:50:14 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: <jerdfelt@valinux.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patchlet] enable HP 8200e USB CDRW
Message-ID: <Pine.LNX.4.30.0012311148340.20511-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchlet lets me use my HP CDRW.

--- linux/drivers/usb/Config.in~	Mon Nov 27 20:10:35 2000
+++ linux/drivers/usb/Config.in	Tue Dec 19 12:21:56 2000
@@ -32,6 +32,9 @@
    if [ "$CONFIG_USB_STORAGE" != "n" ]; then
       bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
       bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM
+      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+          bool '    HP8200e support (EXPERIMENTAL)' CONFIG_USB_STORAGE_HP8200e
+      fi
    fi
    dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
    dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
