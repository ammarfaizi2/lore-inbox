Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbTGaXAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274898AbTGaW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:59:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274886AbTGaW5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:57:44 -0400
Date: Thu, 31 Jul 2003 15:57:29 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Charles Lepple <clepple@ghz.cc>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reorganize USB submenu's
Message-Id: <20030731155729.138e3aaa.shemminger@osdl.org>
In-Reply-To: <20030731201659.GA4385@kroah.com>
References: <20030731101144.32a3f0d7.shemminger@osdl.org>
	<23979.216.12.38.216.1059672599.squirrel@www.ghz.cc>
	<20030731125032.785ffba1.shemminger@osdl.org>
	<20030731201659.GA4385@kroah.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same again without the USB_GADGET changes.  That menu is confusing but correct
as it stands.

diff -urN -X dontdiff linux-2.5/drivers/usb/image/Kconfig usb/drivers/usb/image/Kconfig
--- linux-2.5/drivers/usb/image/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/image/Kconfig	2003-07-31 12:10:51.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Imageing devices configuration
 #
-comment "USB Imaging devices"
+menu "USB Imaging devices"
 	depends on USB
 
 config USB_MDC800
@@ -53,3 +53,4 @@
 	  The scanner will be accessible as a SCSI device.
 	  This can be compiled as a module, called hpusbscsi.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/input/Kconfig usb/drivers/usb/input/Kconfig
--- linux-2.5/drivers/usb/input/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/input/Kconfig	2003-07-31 14:12:24.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Input driver configuration
 #
-comment "USB Human Interface Devices (HID)"
+menu "USB Input devices"
 	depends on USB
 
 config USB_HID
@@ -205,3 +205,4 @@
 	  The module will be called xpad.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/media/Kconfig usb/drivers/usb/media/Kconfig
--- linux-2.5/drivers/usb/media/Kconfig	2003-06-05 10:04:40.000000000 -0700
+++ usb/drivers/usb/media/Kconfig	2003-07-31 11:48:11.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Multimedia device configuration
 #
-comment "USB Multimedia devices"
+menu "USB Multimedia devices"
 	depends on USB
 
 config USB_DABUSB
@@ -194,3 +194,4 @@
 	  The module will be called stv680. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/misc/Kconfig usb/drivers/usb/misc/Kconfig
--- linux-2.5/drivers/usb/misc/Kconfig	2003-06-05 10:04:41.000000000 -0700
+++ usb/drivers/usb/misc/Kconfig	2003-07-31 11:48:39.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Miscellaneous driver configuration
 #
-comment "USB Miscellaneous drivers"
+menu "USB Miscellaneous drivers"
 	depends on USB
 
 config USB_EMI26
@@ -117,4 +117,4 @@
 
 	  See <http://www.linux-usb.org/usbtest> for more information,
 	  including sample test device firmware and "how to use it".
-
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/net/Kconfig usb/drivers/usb/net/Kconfig
--- linux-2.5/drivers/usb/net/Kconfig	2003-06-20 09:49:37.000000000 -0700
+++ usb/drivers/usb/net/Kconfig	2003-07-31 12:45:59.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # USB Network devices configuration
 #
-comment "USB Network adaptors"
+menu "USB Network adaptors"
 	depends on USB
 
 comment "Networking support is needed for USB Networking device support"
@@ -266,3 +266,4 @@
 	  IEEE 802 "local assignment" bit is set in the address, a "usbX"
 	  name is used instead.
 
+endmenu
diff -urN -X dontdiff linux-2.5/drivers/usb/serial/Kconfig usb/drivers/usb/serial/Kconfig
--- linux-2.5/drivers/usb/serial/Kconfig	2003-06-05 10:04:41.000000000 -0700
+++ usb/drivers/usb/serial/Kconfig	2003-07-31 14:05:26.000000000 -0700
@@ -2,10 +2,7 @@
 # USB Serial device configuration
 #
 
-menu "USB Serial Converter support"
-	depends on USB!=n
-
-config USB_SERIAL
+menuconfig  USB_SERIAL
 	tristate "USB Serial Converter support"
 	depends on USB
 	---help---
@@ -438,8 +435,5 @@
 
 config USB_EZUSB
 	bool
-	depends on USB_SERIAL_KEYSPAN_PDA || USB_SERIAL_XIRCOM || USB_SERIAL_KEYSPAN || USB_SERIAL_WHITEHEAT
+	depends on USB_SERIAL && (USB_SERIAL_KEYSPAN_PDA || USB_SERIAL_XIRCOM || USB_SERIAL_KEYSPAN || USB_SERIAL_WHITEHEAT)
 	default y
-
-endmenu
-
diff -urN -X dontdiff linux-2.5/drivers/usb/storage/Kconfig usb/drivers/usb/storage/Kconfig
--- linux-2.5/drivers/usb/storage/Kconfig	2003-06-05 10:04:41.000000000 -0700
+++ usb/drivers/usb/storage/Kconfig	2003-07-31 14:05:18.000000000 -0700
@@ -1,10 +1,11 @@
 #
 # USB Storage driver configuration
 #
+
 comment "SCSI support is needed for USB Storage"
 	depends on USB && SCSI=n
 
-config USB_STORAGE
+menuconfig USB_STORAGE
 	tristate "USB Mass Storage support"
 	depends on USB && SCSI
 	---help---
