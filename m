Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHKI6s>; Sun, 11 Aug 2002 04:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318154AbSHKI6s>; Sun, 11 Aug 2002 04:58:48 -0400
Received: from mta01.alltel.net ([166.102.165.143]:1776 "EHLO
	mta01-srv.alltel.net") by vger.kernel.org with ESMTP
	id <S318047AbSHKI6r>; Sun, 11 Aug 2002 04:58:47 -0400
Subject: [PATCH] unusual_devs.h, kernel linux-2.4.19
From: Roger <roger123@alltel.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-uzYhlZIybiiZK/PCBlQI"
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 11 Aug 2002 05:02:04 -0400
Message-Id: <1029056525.14519.3.camel@localhost3.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uzYhlZIybiiZK/PCBlQI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is for the Minolta Dimage 7i digital camera to be recognized
when it is attached to a usb port. 
http://www.dimage.minolta.com/d7i/index.html

The digital camera has a usb-1.0 port for downloading images when the
compactflash card is inserted.  Firmware is probably also transfered via
the same method. 


-- 
Roger
-----
Verify my pgp/gnupg signature on my HomePage:
http://www.eskimo.com/~roger/



--- linux-2.4.19/drivers/usb/storage/unusual_devs.h Fri Aug  2 20:39:45
2002 
+++ linux-2.4.19/drivers/usb/storage/unusual_devs.h Sun Aug 11 03:42:50
2002 
@@ -334,6 +334,13 @@ 
                 US_SC_SCSI, US_PR_BULK, NULL, 
                 US_FL_START_STOP ), 

+/* Submitted by roger@linuxfreemail.com */ 
+UNUSUAL_DEV( 0x0686, 0x400b, 0x0001, 0x0001, 
+ "Minolta", 
+ "Dimage 7i", 
+ US_SC_SCSI, US_PR_BULK, NULL, 
+ US_FL_START_STOP ), 
+ 
/* Submitted by f.brugmans@hccnet.nl
  * Needed for START_STOP flag */ 
UNUSUAL_DEV( 0x0686, 0x4007, 0x0001, 0x0001,

--=-uzYhlZIybiiZK/PCBlQI
Content-Disposition: attachment; filename=minolta-dimage7i.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; name=minolta-dimage7i.patch; charset=ISO-8859-1

--- linux/drivers/usb/storage/unusual_devs.h	Fri Aug  2 20:39:45 2002
+++ linux-2.4.19/drivers/usb/storage/unusual_devs.h	Sun Aug 11 03:42:50 200=
2
@@ -334,6 +334,13 @@
                 US_SC_SCSI, US_PR_BULK, NULL,
                 US_FL_START_STOP ),
=20
+/* Submitted by roger@linuxfreemail.com */
+UNUSUAL_DEV( 0x0686, 0x400b, 0x0001, 0x0001,
+		"Minolta",
+		"Dimage 7i",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP ),
+							=09
 /* Submitted by f.brugmans@hccnet.nl
  * Needed for START_STOP flag */
 UNUSUAL_DEV( 0x0686, 0x4007, 0x0001, 0x0001,

--=-uzYhlZIybiiZK/PCBlQI--

