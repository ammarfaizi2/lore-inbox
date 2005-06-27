Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVF0Nby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVF0Nby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVF0N3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:29:46 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:20965 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262068AbVF0MQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:45 -0400
Message-Id: <20050627121418.869330000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:46 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-doc-update.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 46/51] usb doc update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

o removed device listing (they are all in the linuxtv wiki now)
o misc updates

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/README.dvb-usb |  100 +++++----------------------------------
 1 files changed, 15 insertions(+), 85 deletions(-)

Index: linux-2.6.12-git8/Documentation/dvb/README.dvb-usb
===================================================================
--- linux-2.6.12-git8.orig/Documentation/dvb/README.dvb-usb	2005-06-27 13:18:18.000000000 +0200
+++ linux-2.6.12-git8/Documentation/dvb/README.dvb-usb	2005-06-27 13:26:18.000000000 +0200
@@ -13,14 +13,17 @@ different way: With the help of a dvb-us
 The framework provides generic functions (mostly kernel API calls), such as:
 
 - Transport Stream URB handling in conjunction with dvb-demux-feed-control
-  (bulk and isoc (TODO) are supported)
+  (bulk and isoc are supported)
 - registering the device for the DVB-API
 - registering an I2C-adapter if applicable
 - remote-control/input-device handling
 - firmware requesting and loading (currently just for the Cypress USB
-  controller)
+  controllers)
 - other functions/methods which can be shared by several drivers (such as
   functions for bulk-control-commands)
+- TODO: a I2C-chunker. It creates device-specific chunks of register-accesses
+  depending on length of a register and the number of values that can be
+  multi-written and multi-read.
 
 The source code of the particular DVB USB devices does just the communication
 with the device via the bus. The connection between the DVB-API-functionality
@@ -36,93 +39,17 @@ the dvb-usb-lib.
 TODO: dynamic enabling and disabling of the pid-filter in regard to number of
 feeds requested.
 
-Supported devices USB1.1
+Supported devices
 ========================
 
-Produced and reselled by Twinhan:
----------------------------------
-- TwinhanDTV USB-Ter DVB-T Device (VP7041)
-	http://www.twinhan.com/product_terrestrial_3.asp
+See the LinuxTV DVB Wiki at www.linuxtv.org for a complete list of
+cards/drivers/firmwares:
 
-- TwinhanDTV Magic Box (VP7041e)
-	http://www.twinhan.com/product_terrestrial_4.asp
-
-- HAMA DVB-T USB device
-	http://www.hama.de/portal/articleId*110620/action*2598
-
-- CTS Portable (Chinese Television System) (2)
-	http://www.2cts.tv/ctsportable/
-
-- Unknown USB DVB-T device with vendor ID Hyper-Paltek
-
-
-Produced and reselled by KWorld:
---------------------------------
-- KWorld V-Stream XPERT DTV DVB-T USB
-	http://www.kworld.com.tw/en/product/DVBT-USB/DVBT-USB.html
-
-- JetWay DTV DVB-T USB
-	http://www.jetway.com.tw/evisn/product/lcd-tv/DVT-USB/dtv-usb.htm
-
-- ADSTech Instant TV DVB-T USB
-	http://www.adstech.com/products/PTV-333/intro/PTV-333_intro.asp?pid=PTV-333
-
-
-Others:
--------
-- Ultima Electronic/Artec T1 USB TVBOX (AN2135, AN2235, AN2235 with Panasonic Tuner)
-	http://82.161.246.249/products-tvbox.html
-
-- Compro Videomate DVB-U2000 - DVB-T USB (2)
-	http://www.comprousa.com/products/vmu2000.htm
-
-- Grandtec USB DVB-T
-	http://www.grand.com.tw/
-
-- AVerMedia AverTV DVBT USB
-	http://www.avermedia.com/
-
-- DiBcom USB DVB-T reference device (non-public)
-
-
-Supported devices USB2.0-only
-=============================
-- Twinhan MagicBox II
-	http://www.twinhan.com/product_terrestrial_7.asp
-
-- TwinhanDTV Alpha
-	http://www.twinhan.com/product_terrestrial_8.asp
-
-- DigitalNow TinyUSB 2 DVB-t Receiver
-	http://www.digitalnow.com.au/DigitalNow%20tinyUSB2%20Specifications.html
-
-- Hanftek UMT-010
-	http://www.globalsources.com/si/6008819757082/ProductDetail/Digital-TV/product_id-100046529
-
-
-Supported devices USB2.0 and USB1.1
-=============================
-- Typhoon/Yakumo/HAMA/Yuan DVB-T mobile USB2.0
-	http://www.yakumo.de/produkte/index.php?pid=1&ag=DVB-T
-	http://www.yuan.com.tw/en/products/vdo_ub300.html
-	http://www.hama.de/portal/articleId*114663/action*2563
-	http://www.anubisline.com/english/articlec.asp?id=50502&catid=002
-
-- Artec T1 USB TVBOX (FX2) (2)
-
-- Hauppauge WinTV NOVA-T USB2
-	http://www.hauppauge.com/
-
-- KWorld/ADSTech Instant DVB-T USB2.0 (DiB3000M-B)
-
-- DiBcom USB2.0 DVB-T reference device (non-public)
-
-- AVerMedia AverTV A800 DVB-T USB2.0
-
-1) It is working almost - work-in-progress.
-2) No test reports received yet.
+http://www.linuxtv.org/wiki/index.php/DVB_USB
 
 0. History & News:
+  2005-05-30 - added basic isochronous support to the dvb-usb-framework
+               added support for Conexant Hybrid reference design and Nebula DigiTV USB
   2005-04-17 - all dibusb devices ported to make use of the dvb-usb-framework
   2005-04-02 - re-enabled and improved remote control code.
   2005-03-31 - ported the Yakumo/Hama/Typhoon DVB-T USB2.0 device to dvb-usb.
@@ -289,6 +216,9 @@ Patches, comments and suggestions are ve
    Gunnar Wittich and Joachim von Caron for their trust for providing
     root-shells on their machines to implement support for new devices.
 
+   Allan Third and Michael Hutchinson for their help to write the Nebula
+    digitv-driver.
+
    Glen Harris for bringing up, that there is a new dibusb-device and Jiun-Kuei
     Jung from AVerMedia who kindly provided a special firmware to get the device
     up and running in Linux.
@@ -305,4 +235,4 @@ Patches, comments and suggestions are ve
    Ulf Hermenau for helping me out with traditional chinese.
 
    André Smoktun and Christian Frömmel for supporting me with
-    hardware and listening to my problems very patient.
+    hardware and listening to my problems very patiently.

--

