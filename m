Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269157AbRGaCLg>; Mon, 30 Jul 2001 22:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRGaCL1>; Mon, 30 Jul 2001 22:11:27 -0400
Received: from rj.SGI.COM ([204.94.215.100]:54401 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269157AbRGaCLU>;
	Mon, 30 Jul 2001 22:11:20 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.8-pre3 drivers/usb/storage/scsiglue.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 12:11:21 +1000
Message-ID: <32655.996545481@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Trivial patch to remove warning message.

Index: 8-pre3.1/drivers/usb/storage/scsiglue.c
--- 8-pre3.1/drivers/usb/storage/scsiglue.c Tue, 31 Jul 2001 11:09:45 +1000 kaos (linux-2.4/y/b/2_scsiglue.c 1.4.2.1 644)
+++ 8-pre3.1(w)/drivers/usb/storage/scsiglue.c Tue, 31 Jul 2001 12:07:28 +1000 kaos (linux-2.4/y/b/2_scsiglue.c 1.4.2.1 644)
@@ -249,7 +249,7 @@ static int bus_reset( Scsi_Cmnd *srb )
         for (i = 0; i < us->pusb_dev->actconfig->bNumInterfaces; i++) {
  		struct usb_interface *intf =
 			&us->pusb_dev->actconfig->interface[i];
-		struct usb_device_id *id;
+		const struct usb_device_id *id;
 
 		/* if this is an unclaimed interface, skip it */
 		if (!intf->driver) {

