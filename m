Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSJAA35>; Mon, 30 Sep 2002 20:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSJAA34>; Mon, 30 Sep 2002 20:29:56 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:2054 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261411AbSJAA3y>;
	Mon, 30 Sep 2002 20:29:54 -0400
Date: Mon, 30 Sep 2002 17:33:04 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003304.GC3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003240.GB3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.1 -> 1.660.1.2
#	drivers/usb/serial/visor.h	1.11    -> 1.12   
#	drivers/usb/serial/visor.c	1.41    -> 1.42   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.2
# USB: added Palm Zire id to the visor driver, thanks to Martin Brachtl
# --------------------------------------------
#
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Mon Sep 30 17:26:09 2002
+++ b/drivers/usb/serial/visor.c	Mon Sep 30 17:26:09 2002
@@ -182,9 +182,10 @@
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M515_ID) },
+	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M125_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M130_ID) },
-	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
+	{ USB_DEVICE(PALM_VENDOR_ID, PALM_ZIRE_ID) },
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_4_0_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_S360_ID) },
@@ -202,9 +203,10 @@
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M515_ID) },
+	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M125_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M130_ID) },
-	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
+	{ USB_DEVICE(PALM_VENDOR_ID, PALM_ZIRE_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_3_5_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_4_0_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_S360_ID) },
diff -Nru a/drivers/usb/serial/visor.h b/drivers/usb/serial/visor.h
--- a/drivers/usb/serial/visor.h	Mon Sep 30 17:26:09 2002
+++ b/drivers/usb/serial/visor.h	Mon Sep 30 17:26:09 2002
@@ -27,6 +27,7 @@
 #define PALM_I705_ID			0x0020
 #define PALM_M125_ID			0x0040
 #define PALM_M130_ID			0x0050
+#define PALM_ZIRE_ID			0x0070
 
 #define SONY_VENDOR_ID			0x054C
 #define SONY_CLIE_3_5_ID		0x0038
