Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270342AbTGRTuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTGRTuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:50:20 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:48806 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S270342AbTGRTuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:50:08 -0400
Subject: [PATCH] 2.4.22-pre6-ac1 add five USB help texts to Configure.help
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1058557971.17070.23.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 18 Jul 2003 13:52:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds help texts for the following:

CONFIG_USB_BRLVGER
CONFIG_USB_KBTAB
CONFIG_USB_SERIAL_EDGEPORT_TI
CONFIG_USB_SERIAL_KEYSPAN_MPR
CONFIG_USB_SPEEDTOUCH

The patch was made for 2.4.22-pre6-ac1, but can be applied to Marcelo's
tree if the first hunk for CONFIG_USB_SPEEDTOUCH is removed.  Help for
that option is already in Marcelo's Configure.help.  This patch places
that help text in the same position (following USB_DSBR) as in Marcelo's
tree.

The help texts were obtained from the 2.6 Kconfig usb file.

Steven

--- linux-2.4.22-pre6-ac1/Documentation/Configure.help.ac1	Fri Jul 18 12:52:04 2003
+++ linux-2.4.22-pre6-ac1/Documentation/Configure.help	Fri Jul 18 13:24:27 2003
@@ -15286,6 +15286,17 @@
   The module will be called dsbr100.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+Alcatel Speedtouch USB support
+CONFIG_USB_SPEEDTOUCH
+  Say Y here if you have an Alcatel SpeedTouch USB or SpeedTouch 330
+  modem.  In order to use your modem you will need to install some user
+  space tools, see <http://www.linux-usb.org/SpeedTouch/> for details.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called speedtch.o. If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.
+
 Always do synchronous disk IO for UBD
 CONFIG_BLK_DEV_UBD_SYNC
   The User-Mode Linux port includes a driver called UBD which will let
@@ -25421,6 +25432,44 @@
   brave people.  System crashes and other bad things are likely to occur if
   you use this driver.  If in doubt, select N.
 
+Tieman Voyager USB Braille display support (EXPERIMENTAL)
+CONFIG_USB_BRLVGER
+  Say Y here if you want to use the Voyager USB Braille display from
+  Tieman. See <file:Documentation/usb/brlvger.txt> for more
+  information.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called brlvger.o. If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.
+
+KB Gear JamStudio tablet support
+CONFIG_USB_KBTAB
+  Say Y here if you want to use the USB version of the KB Gear
+  JamStudio tablet.  Make sure to say Y to "Mouse support"
+  (CONFIG_INPUT_MOUSEDEV) and/or "Event interface support"
+  (CONFIG_INPUT_EVDEV) as well.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called kbtab.o.  If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.
+
+USB Inside Out Edgeport Serial Driver (TI devices)
+CONFIG_USB_SERIAL_EDGEPORT_TI
+  Say Y here if you want to use any of the devices from Inside Out
+  Networks (Digi) that are not supported by the io_edgeport driver.
+  This includes the Edgeport/1 device.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called io_ti.o.  If you want to compile it
+  as a module, say M here and read <file:Documentation/modules.txt>.
+
+USB Keyspan MPR Firmware
+CONFIG_USB_SERIAL_KEYSPAN_MPR
+  Say Y here to include firmware for the Keyspan MPR converter.
+
 Winbond W83977AF IrDA Device Driver
 CONFIG_WINBOND_FIR
   Say Y here if you want to build IrDA support for the Winbond




