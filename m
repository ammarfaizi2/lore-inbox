Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129384AbRBSMD4>; Mon, 19 Feb 2001 07:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRBSMDq>; Mon, 19 Feb 2001 07:03:46 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:16015 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129384AbRBSMDf>; Mon, 19 Feb 2001 07:03:35 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 19 Feb 2001 04:03:32 -0800
Message-Id: <200102191203.EAA29927@baldur.yggdrasil.com>
To: cpia@risc.uni-linz.ac.at, jerdfelt@valinux.com,
        Jochen.Scharrlach@schwaben.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: PATCH: linux-2.4.2-pre4/drivers/media/video/cpia_usb.c device ID update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following one line patch updates the cpia_usb driver
in linux-2.4.2-pre4 to include the additional device ID that
already appears in http://download.sourceforge.net/webcam/cpia-1.2.tgz.
This patch is necessary to make cpia_usb work with the Intel QX3 microscope
and possibly other devices as well.  I tested this patch by looking
through my QX3 microscope under XawTV, which did not work without this
change.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-----------------------------CUT HERE---------------------------------------

--- linux-2.4.2-pre4/drivers/media/video/cpia_usb.c	Thu Jan  4 13:15:32 2001
+++ linux/drivers/media/video/cpia_usb.c	Mon Feb 19 01:27:56 2001
@@ -558,6 +558,7 @@
 
 static struct usb_device_id cpia_id_table [] = {
 	{ USB_DEVICE(0x0553, 0x0002) },
+	{ USB_DEVICE(0x0813, 0x0001) },
 	{ }					/* Terminating entry */
 };
 
