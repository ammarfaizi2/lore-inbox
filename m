Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUGZHOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUGZHOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUGZHOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:14:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264960AbUGZHOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:14:39 -0400
Date: Mon, 26 Jul 2004 00:14:34 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo.tosatti@cyclades.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch for USB in 2.4.27-rc3 to update unusual_devs.h
Message-Id: <20040726001434.447833d7@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A usual update from Alan Stern.

-- Pete

diff -urp -X dontdiff linux-2.4.27-rc3/drivers/usb/storage/unusual_devs.h linux-2.4.27-rc3-usb/drivers/usb/storage/unusual_devs.h
--- linux-2.4.27-rc3/drivers/usb/storage/unusual_devs.h	2004-07-25 23:00:17.000000000 -0700
+++ linux-2.4.27-rc3-usb/drivers/usb/storage/unusual_devs.h	2004-07-25 23:55:00.000000000 -0700
@@ -185,7 +185,7 @@ UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x
 UNUSUAL_DEV(  0x04e6, 0x0006, 0x0100, 0x0205, 
 		"Shuttle",
 		"eUSB MMC Adapter",
-		US_SC_SCSI, US_PR_CB, NULL, 
+		US_SC_SCSI, US_PR_DEVICE, NULL, 
 		US_FL_SINGLE_LUN), 
 
 UNUSUAL_DEV(  0x04e6, 0x0007, 0x0100, 0x0200, 
@@ -318,6 +318,15 @@ UNUSUAL_DEV(  0x057b, 0x0000, 0x0300, 0x
 		US_SC_DEVICE,  US_PR_DEVICE, NULL,
 		US_FL_SINGLE_LUN),
 
+/* Reported by Johann Cardon <johann.cardon@free.fr>
+ * This entry is needed only because the device reports
+ * bInterfaceClass = 0xff (vendor-specific)
+ */
+UNUSUAL_DEV(  0x057b, 0x0022, 0x0000, 0x9999, 
+		"Y-E Data",
+		"Silicon Media R/W",
+		US_SC_DEVICE, US_PR_DEVICE, NULL, 0),
+
 /* Fabrizio Fellini <fello@libero.it> */
 UNUSUAL_DEV(  0x0595, 0x4343, 0x0000, 0x2210,
 		"Fujifilm",
