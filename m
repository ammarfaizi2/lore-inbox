Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTA0Ojh>; Mon, 27 Jan 2003 09:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbTA0Ojh>; Mon, 27 Jan 2003 09:39:37 -0500
Received: from 217-126-167-95.uc.nombres.ttd.es ([217.126.167.95]:43164 "EHLO
	alobbs.com") by vger.kernel.org with ESMTP id <S267196AbTA0Ojf>;
	Mon, 27 Jan 2003 09:39:35 -0500
From: Alvaro Lopez Ortega <alvaro@alobbs.com>
To: linux-kernel@vger.kernel.org
Subject: radeonfb and `Radeon Mobility 9000'
Date: Mon, 27 Jan 2003 15:47:47 +0100
User-Agent: KMail/1.5
Cc: Ani Joshi <ajoshi@unixbox.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TaUN+7bUnGous9Q"
Message-Id: <200301271547.47046.alvaro@alobbs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_TaUN+7bUnGous9Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

	This little patch adds `Radeon Mobility 9000' support to the Radeon 
Framebuffer driver.

	It works on my laptop (Dell Inspiron).

-- 
Greetings, alo.

--Boundary-00=_TaUN+7bUnGous9Q
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="radeon-Mobility9000-linux-2.4.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="radeon-Mobility9000-linux-2.4.20.diff"

--- radeonfb_orig.c	2003-01-27 09:50:16.000000000 +0100
+++ radeonfb.c	2003-01-27 10:05:15.000000000 +0100
@@ -19,6 +19,7 @@
  *	2001-11-18	DFP fixes, Kevin Hendricks, 0.1.3
  *	2001-11-29	more cmap, backlight fixes, Benjamin Herrenschmidt
  *	2002-01-18	DFP panel detection via BIOS, Michael Clark, 0.1.4
+ *	2003-01-28	added Radeon Mobility 9000, Alvaro Lopez Ortega
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
@@ -101,7 +102,8 @@
 	RADEON_LW,	/* Radeon Mobility M7 */
 	RADEON_LY,	/* Radeon Mobility M6 */
 	RADEON_LZ,	/* Radeon Mobility M6 */
-	RADEON_PM	/* Radeon Mobility P/M */
+	RADEON_L9,     /* Radeon Mobility 9000 */
+	RADEON_PM  	/* Radeon Mobility P/M */
 };
 
 
@@ -128,6 +130,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LW, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LW},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LY, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LY},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LZ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LZ},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_L9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_L9},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_PM, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_PM},
 	{ 0, }
 };
@@ -858,7 +861,11 @@
 			strcpy(rinfo->name, "Radeon M6 LZ ");
 			rinfo->hasCRTC2 = 1;
 			break;
-	        case PCI_DEVICE_ID_RADEON_PM:
+		case PCI_DEVICE_ID_RADEON_L9:
+			strcpy(rinfo->name, "Radeon M9000");
+			rinfo->hasCRTC2 = 1;
+			break;
+	     case PCI_DEVICE_ID_RADEON_PM:
 			strcpy(rinfo->name, "Radeon P/M ");
 			rinfo->hasCRTC2 = 1;
 		default:

--Boundary-00=_TaUN+7bUnGous9Q--

