Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290588AbSBFOpF>; Wed, 6 Feb 2002 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290587AbSBFOo4>; Wed, 6 Feb 2002 09:44:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:9798 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S290588AbSBFOoj>;
	Wed, 6 Feb 2002 09:44:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hanno =?iso-8859-1?q?B=F6ck?= <hanno@gmx.de>
To: David Weinehall <tao@acc.umu.se>
Subject: Re: Patch for eepro100 to support more cards
Date: Wed, 6 Feb 2002 15:45:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201080545Z291604-13996+15441@vger.kernel.org> <20020206132727.H1735@khan.acc.umu.se>
In-Reply-To: <20020206132727.H1735@khan.acc.umu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020206144449Z290588-13996+17952@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of some complains and as pre8 is out now, I made it again for the 2.4.18pre8-kernel.
I hope it is okay now.

I put up a site for the patch: http://www.int21.de/eepro100/

The Patch adds definitions for the Intel Pro/100 VE-card to the eepro100-driver.

--- linux-2.4.18-pre8/drivers/net/eepro100.c	Wed Feb  6 15:15:16 2002
+++ linux/drivers/net/eepro100.c	Wed Feb  6 15:19:14 2002
@@ -168,6 +168,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ID1030
 #define PCI_DEVICE_ID_INTEL_ID1030 0x1030
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ID1031          /* support for Intel Pro/100 VE */
+#define PCI_DEVICE_ID_INTEL_ID1031 0x1031
+#endif


 static int speedo_debug = 1;
@@ -2270,6 +2273,8 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1029,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1031,     /* support for Intel Pro/100 VE */
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
 		PCI_ANY_ID, PCI_ANY_ID, },
