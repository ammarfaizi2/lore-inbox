Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVCVCQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVCVCQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVCVCPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:15:25 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:47499 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262334AbVCVBgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:18 -0500
Message-Id: <20050322013455.516571000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:42 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-readme.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 09/48] dibusb readme update
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dibusb readme update (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 README.dibusb |   57 +++++++++++++++++++++++++--------------------------------
 1 files changed, 25 insertions(+), 32 deletions(-)

Index: linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/README.dibusb	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb	2005-03-22 00:15:04.000000000 +0100
@@ -1,7 +1,7 @@
 Documentation for dib3000mb frontend driver and dibusb device driver
 ====================================================================
 
-Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de),
+Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de),
 
 dibusb and dib3000mb/mc drivers based on GPL code, which has
 
@@ -46,7 +46,7 @@ Produced and reselled by KWorld:
 
 Others:
 -------
-- Ultima Electronic/Artec T1 USB TVBOX (AN2135, AN2235, AN2235 with Panasonic Tuner) 
+- Ultima Electronic/Artec T1 USB TVBOX (AN2135, AN2235, AN2235 with Panasonic Tuner)
 	http://82.161.246.249/products-tvbox.html
 
 - Compro Videomate DVB-U2000 - DVB-T USB (2)
@@ -77,16 +77,17 @@ Supported devices USB2.0
 - DiBcom USB2.0 DVB-T reference device (non-public)
 
 1) It is working almost.
-2) No test reports received yet. 
+2) No test reports received yet.
 
 
 0. NEWS:
+  2004-01-31 - distorted streaming is finally gone for USB1.1 devices
   2004-01-13 - moved the mirrored pid_filter_table back to dvb-dibusb
              - first almost working version for HanfTek UMT-010
              - found out, that Yakumo/HAMA/Typhoon are predessors of the HanfTek
   2004-01-10 - refactoring completed, now everything is very delightful
              - tuner quirks for some weird devices (Artec T1 AN2235 device has sometimes a
-               Panasonic Tuner assembled). Tunerprobing implemented. Thanks a lot to Gunnar Wittich. 
+               Panasonic Tuner assembled). Tunerprobing implemented. Thanks a lot to Gunnar Wittich.
   2004-12-29 - after several days of struggling around bug of no returning URBs fixed.
   2004-12-26 - refactored the dibusb-driver, splitted into separate files
              - i2c-probing enabled
@@ -106,7 +107,7 @@ Supported devices USB2.0
   2004-09-28 - added support for a new device (Unkown, vendor ID is Hyper-Paltek)
   2004-09-20 - added support for a new device (Compro DVB-U2000), thanks
                to Amaury Demol for reporting
-             - changed usb TS transfer method (several urbs, stopping transfer 
+             - changed usb TS transfer method (several urbs, stopping transfer
                before setting a new pid)
   2004-09-13 - added support for a new device (Artec T1 USB TVBOX), thanks
                to Christian Motschke for reporting
@@ -191,13 +192,13 @@ turned on.
 
 At this point you should be able to start a dvb-capable application. For myself
 I used mplayer, dvbscan, tzap and kaxtv, they are working. Using the device
-in vdr (at least the USB2.0 one) is working. 
+in vdr is working now also.
 
 2. Known problems and bugs
 
 - none this time
 
-2.1. Adding support for devices 
+2.1. Adding support for devices
 
 It is not possible to determine the range of devices based on the DiBcom
 reference designs. This is because the reference design of DiBcom can be sold
@@ -213,53 +214,45 @@ of the device. I will add it to this lis
 others.
 
 If you are familar with C you can also add the VID and PID of the device to
-the dvb-dibusb.h-file and create a patch and send it over to me or to 
+the dvb-dibusb-core.c-file and create a patch and send it over to me or to
 the linux-dvb mailing list, _after_ you have tried compiling and modprobing
 it.
 
 2.2. USB1.1 Bandwidth limitation
 
-Most of the current supported devices are USB1.1 and thus they have a
+Most of the currently supported devices are USB1.1 and thus they have a
 maximum bandwidth of about 5-6 MBit/s when connected to a USB2.0 hub.
 This is not enough for receiving the complete transport stream of a
 DVB-T channel (which can be about 16 MBit/s). Normally this is not a
 problem, if you only want to watch TV (this does not apply for HDTV),
-but watching a channel while recording another channel on the same 
-frequency simply does not work. This applies to all USB1.1 DVB-T 
-devices, not only dibusb)
-
-A special problem of the dibusb for the USB1.1 is, that the USB control
-IC has a problem with write accesses while having MPEG2-streaming
-enabled. When you set another pid while receiving MPEG2-TS it happens, that
-the stream is disturbed and probably data is lost (results in distortions of
-the video or strange beeps within the audio stream). DiBcom is preparing a
-firmware especially for Linux which perhaps solves the problem.
-
-Especially VDR users are victoms of this bug. VDR frequently requests new PIDs
-due the automatic scanning (introduced in 1.3.x, afaik) and epg-scan. Disabling
-these features is maybe a solution. Additionally this behaviour of VDR exceeds
-the USB1.1 bandwidth.
-
-Update:
-For the USB1.1 and VDR some work has been done (patches and comments are still 
-very welcome). Maybe the problem is solved in the meantime because I now use
-the dmx_sw_filter function instead of dmx_sw_filter_packet. I hope the
+but watching a channel while recording another channel on the same
+frequency simply does not work very well. This applies to all USB1.1
+DVB-T devices, not just dibusb)
+
+Update: For the USB1.1 and VDR some work has been done (patches and comments
+are still very welcome). Maybe the problem is solved in the meantime because I
+now use the dmx_sw_filter function instead of dmx_sw_filter_packet. I hope the
 linux-dvb software filter is able to get the best of the garbled TS.
 
+The bug, where the TS is distorted by a heavy usage of the device is gone
+definitely.  All dibusb-devices I was using (Twinhan, Kworld, DiBcom) are
+working like charm now with VDR. Sometimes I even was able to record a channel
+and watch another one.
+
 2.3. Comments
 
-Patches, comments and suggestions are very very welcome
+Patches, comments and suggestions are very very welcome.
 
 3. Acknowledgements
 	Amaury Demol (ademol@dibcom.fr) and Francois Kanounnikoff from DiBcom for
-    providing specs, code and help, on which the dvb-dibusb, dib3000mb and 
+    providing specs, code and help, on which the dvb-dibusb, dib3000mb and
     dib3000mc are based.
 
    David Matthews for identifying a new device type (Artec T1 with AN2235)
     and for extending dibusb with remote control event handling. Thank you.
 
    Alex Woods for frequently answering question about usb and dvb
-    stuff, a big thank you
+    stuff, a big thank you.
 
    Bernd Wagner for helping with huge bug reports and discussions.
 

--

