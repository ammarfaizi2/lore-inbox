Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281463AbRLQRqg>; Mon, 17 Dec 2001 12:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRLQRq0>; Mon, 17 Dec 2001 12:46:26 -0500
Received: from [24.217.2.182] ([24.217.2.182]:2003 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S281463AbRLQRqM>;
	Mon, 17 Dec 2001 12:46:12 -0500
Message-Id: <200112171838.fBHIccf01240@linux.local>
Content-Type: text/plain; charset=US-ASCII
X-KMail-Redirect-From: Its Squash <squash2@dropnet.net>
Subject: [PATCH] eepro100.c support for  82801CAM (ie in Compaq Evo N600c)
From: Its Squash <squash2@dropnet.net> (by way of Its Squash
	<squash2@dropnet.net>)
Date: Mon, 17 Dec 2001 12:38:38 -0600
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This chipset uses the normal eepro100 driver, but needs to be updated to
recognise the PCI ID. The following patch adds this.  This is already fixed
in 2.4.17-rc1.

- Josh

--- drivers/net/eepro100.c.orig Mon Nov 12 11:47:18 2001
+++ drivers/net/eepro100.c      Mon Dec 17 09:51:13 2001
@@ -168,6 +169,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ID1030
 #define PCI_DEVICE_ID_INTEL_ID1030 0x1030
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ID1038
+#define PCI_DEVICE_ID_INTEL_ID1038 0x1038
+#endif


 static int speedo_debug = 1;
@@ -2270,6 +2274,8 @@
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1029,
                PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
+               PCI_ANY_ID, PCI_ANY_ID, },
+       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1038,
                PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
                PCI_ANY_ID, PCI_ANY_ID, },
