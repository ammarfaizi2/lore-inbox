Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291604AbSBAIF7>; Fri, 1 Feb 2002 03:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291605AbSBAIFt>; Fri, 1 Feb 2002 03:05:49 -0500
Received: from pop.gmx.net ([213.165.64.20]:51144 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291604AbSBAIFf>;
	Fri, 1 Feb 2002 03:05:35 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Hanno =?iso-8859-15?q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Patch for eepro100 to support more cards
Date: Fri, 1 Feb 2002 09:06:26 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020201080545Z291604-13996+15441@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the
Intel Pro/100 VE
Network card to the eepro100.c

This card is installed in my notebook (Sony Vaio PCG-GR114MK). Seems to work 
fine.

Patch is for Kernel 2.4.17

--- linux/drivers/net/eepro100.c        Fri Dec 21 18:41:54 2001
+++ linux-2.4.17-patch/drivers/net/eepro100.c   Thu Jan 31 15:51:50 2002
@@ -168,6 +168,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ID1030
 #define PCI_DEVICE_ID_INTEL_ID1030 0x1030
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ID1031              // Support for Intel Pro/100 
VE added by Hanno Boeck <hanno@gmx.de>
+#define PCI_DEVICE_ID_INTEL_ID1031 0x1031
+#endif


 static int speedo_debug = 1;
@@ -2270,6 +2273,8 @@
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1029,
                PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
+               PCI_ANY_ID, PCI_ANY_ID, },
+       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1031,         // Support 
for 
Intel Pro/100 VE added by Hanno Boeck <hanno@gmx.de>
                PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
                PCI_ANY_ID, PCI_ANY_ID, },
