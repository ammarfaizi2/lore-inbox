Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSLLNBx>; Thu, 12 Dec 2002 08:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSLLNBx>; Thu, 12 Dec 2002 08:01:53 -0500
Received: from [195.6.148.114] ([195.6.148.114]:51117 "EHLO mail.meditrans.fr")
	by vger.kernel.org with ESMTP id <S262812AbSLLNBw>;
	Thu, 12 Dec 2002 08:01:52 -0500
From: Thomas Poindessous <thomas@poindessous.com>
To: linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net
Subject: [PATCH] usb-storage : support for sony DSC-U10, kernel 2.4.20 & 2.5.51
Date: Thu, 12 Dec 2002 14:09:35 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PqI+9AOdsBuk2Bv"
Message-Id: <200212121409.35863.thomas@poindessous.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PqI+9AOdsBuk2Bv
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
here are two patch to support sony DSC-U10 digital camera.

I found them on google.

It works very well with 2.4.20 kernel. I didn't test it on a 2.5.x kernel.

Can someone apply them ?

thanks.

-- 
Thomas Poindessous

--Boundary-00=_PqI+9AOdsBuk2Bv
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="kernel-source-2.4.20_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kernel-source-2.4.20_patch"

--- kernel-source-2.4.20/drivers/usb/storage/unusual_devs.h.orig	2002-12-11 20:42:21.000000000 +0100
+++ kernel-source-2.4.20/drivers/usb/storage/unusual_devs.h	2002-12-11 21:41:25.000000000 +0100
@@ -213,6 +213,12 @@
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
 
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0430, 
+		"Sony",
+		"DSC-U10", 
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+		
 /* Reported by wim@geeks.nl */
 UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100, 
 		"Sony",

--Boundary-00=_PqI+9AOdsBuk2Bv
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="linux-2.5.51_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.5.51_patch"

--- linux-2.5.51/drivers/usb/storage/unusual_devs.h.orig	2002-12-11 22:48:33.000000000 +0100
+++ linux-2.5.51/drivers/usb/storage/unusual_devs.h	2002-12-11 22:48:36.000000000 +0100
@@ -220,6 +220,12 @@
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
 
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0430, 
+		"Sony",
+		"DSC-U10", 
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
 /* Reported by wim@geeks.nl */
 UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100, 
 		"Sony",

--Boundary-00=_PqI+9AOdsBuk2Bv--
