Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263295AbRFABPp>; Thu, 31 May 2001 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263296AbRFABPf>; Thu, 31 May 2001 21:15:35 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:65175 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S263295AbRFABP3>;
	Thu, 31 May 2001 21:15:29 -0400
Message-ID: <3B16ED12.F4BDDFF8@sun.com>
Date: Thu, 31 May 2001 18:17:06 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pci-ids@ucw.cz
CC: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] new PCI ids
Content-Type: multipart/mixed;
 boundary="------------6DB693550DA64716D66D56DA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6DB693550DA64716D66D56DA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a patch for cleaning up some PCI ids and adding a few that were
missing.  Please let me know of any problems with this.

(diff against 2.4.5)

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------6DB693550DA64716D66D56DA
Content-Type: text/plain; charset=us-ascii;
 name="pci-ids.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-ids.diff"

diff -ruN dist-2.4.5/drivers/pci/pci.ids cobalt-2.4.5/drivers/pci/pci.ids
--- dist-2.4.5/drivers/pci/pci.ids	Sat May 19 17:49:14 2001
+++ cobalt-2.4.5/drivers/pci/pci.ids	Thu May 31 14:32:33 2001
@@ -4,7 +4,7 @@
 #	Maintained by Martin Mares <pci-ids@ucw.cz>
 #	If you have any new entries, send them to the maintainer.
 #
-#	$Id: pci.ids,v 1.62 2000/06/28 10:56:36 mj Exp $
+#	$Id: pci.ids,v 1.3 2001/04/04 20:40:25 thockin Exp $
 #
 
 # Vendors, devices and subsystems. Please keep sorted.
@@ -244,6 +244,7 @@
 	000f  OHCI Compliant FireWire Controller
 	0011  National PCI System I/O
 	0012  USB Controller
+	0020  DP83815 (MacPhyter) Ethernet Controller
 	d001  87410 IDE
 100c  Tseng Labs Inc
 	3202  ET4000/W32p rev A
@@ -1925,9 +1926,9 @@
 		1102 8051  CT4850 SBLive! Value
 	7002  SB Live!
 		1102 0020  Gameport Joystick
-1103  Triones Technologies, Inc.
-	0003  HPT343
-	0004  HPT366
+1103  HighPoint Technologies, Inc.
+	0003  HPT343 UltraDMA 33 IDE Controller
+	0004  HPT366/370 UltraDMA 66/100 IDE Controller
 1104  RasterOps Corp.
 1105  Sigma Designs, Inc.
 	8300  REALmagic Hollywood Plus DVD Decoder
@@ -2335,13 +2336,16 @@
 1165  Imagraph Corporation
 	0001  Motion TPEG Recorder/Player with audio
 1166  ServerWorks
-	0007  CNB20-LE CPU to PCI Bridge
-	0008  CNB20HE
-	0009  CNB20LE
+	0007  CNB20-LE Host Bridge
+	0008  CNB20HE Host Bridge
+	0009  CNB20LE Host Bridge
 	0010  CIOB30
 	0011  CMIC-HE
-	0200  OSB4
-	0201  CSB5
+	0200  OSB4 South Bridge
+	0201  CSB5 South Bridge
+	0211  OSB4 IDE Controller
+	0212  CSB5 IDE Controller
+	0220  OSB4/CSB5 OHCI USB Controller
 1167  Mutoh Industries Inc
 1168  Thine Electronics Inc
 1169  Centre for Development of Advanced Computing
diff -ruN dist-2.4.5/include/linux/pci_ids.h cobalt-2.4.5/include/linux/pci_ids.h
--- dist-2.4.5/include/linux/pci_ids.h	Wed May 16 10:25:39 2001
+++ cobalt-2.4.5/include/linux/pci_ids.h	Thu May 31 14:33:17 2001
@@ -991,10 +991,12 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_CIOB30   0x0010
 #define PCI_DEVICE_ID_SERVERWORKS_CMIC_HE  0x0011
-#define PCI_DEVICE_ID_SERVERWORKS_CSB5	   0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	0x0200
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
 
 #define PCI_VENDOR_ID_SBE		0x1176
 #define PCI_DEVICE_ID_SBE_WANXL100	0x0301

--------------6DB693550DA64716D66D56DA--

