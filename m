Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVDVR0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVDVR0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVDVR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:26:24 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:10749 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262074AbVDVR0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:26:18 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: PATCH adding pluto2 to dvb-kernel CVS insmod
Date: Fri, 22 Apr 2005 19:26:09 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yOTaCI4+g3GTvah"
Message-Id: <200504221926.10014.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_yOTaCI4+g3GTvah
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi, here is patch adding pluto2 to insmod.sh in dvb-kernel

Michal

--Boundary-00=_yOTaCI4+g3GTvah
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="ins.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ins.patch"

--- build-2.6/insmod.sh	2005-04-22 19:22:00.000000000 +0200
+++ build-2.6/insmod.sh	2005-04-22 19:21:35.000000000 +0200
@@ -74,6 +74,9 @@
 	insmod ./dvb-usb-a800.ko
 	insmod ./dvb-usb-nova-t-usb2.ko
 	insmod ./dvb-usb-umt-010.ko
+	# pluto2
+	insmod ./pluto2.ko
+	insmod ./pluto_fe.ko
 	echo
 	;;
     debug)
@@ -145,12 +148,12 @@
 		budget-av budget-ci budget-core ttusb_dec dvb-ttusb-budget \
 		ttpci-eeprom dvb-usb-nova-t-usb2.ko dvb-usb-a800.ko dvb-usb-umt-010.ko \
 		dvb-usb-dibusb-mc.ko dvb-usb-dibusb-mb.ko dvb-usb-dibusb-common.ko \
-		dvb-usb-vp7045.ko dvb-usb-dtt200u.ko dvb-usb.ko
+		dvb-usb-vp7045.ko dvb-usb-dtt200u.ko dvb-usb.ko pluto2.ko
 
 # frontends
 	rmmod dib3000mb dib3000mc dib3000_common nxt2002 ves1x93 sp8870 cx22700 \
 			stv0299 ves1820 cinergyT2 ttusbdecfe tda1004x l64781 tda8083 \
-			cx24110 cx22702 stv0297 tda10021 mt352 mt312 dvb-pll
+			cx24110 cx22702 stv0297 tda10021 mt352 mt312 dvb-pll pluto_fe.ko
 
 # chips and helpers
 	rmmod saa7146_vv saa7146 video-buf v4l2-common v4l1-compat dvb-core \

--Boundary-00=_yOTaCI4+g3GTvah--
