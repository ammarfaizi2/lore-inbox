Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWEaUaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWEaUaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWEaUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:30:17 -0400
Received: from gw.goop.org ([64.81.55.164]:60302 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751625AbWEaUaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:30:16 -0400
Message-ID: <447DDEC0.70105@goop.org>
Date: Wed, 31 May 2006 11:21:52 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: gregkh@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Add Sierra Wireless MC5720 ID to airprime.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Sierra Wireless MC5720 is an embedded EV-DO module which is shipping 
with a number of laptops.  This change adds its ID to the airprime.c usb 
serial driver, so that it appears as a serial device.

As an aside, people have reported that it is necessary to increase the 
max packet size in usb-serial.c in order to get good throughput with 
these devices; there's a patch floating around to do this.  Is this a 
reasonable thing to do?  (I guess I'll post my variation of the patch 
and see what discussion comes up...)

    J

--
Recognize the Sierra Wireless MC5720.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff -r 3f1becfa22f9 drivers/usb/serial/airprime.c
--- a/drivers/usb/serial/airprime.c	Tue May 30 23:23:15 2006 -0700
+++ b/drivers/usb/serial/airprime.c	Wed May 31 11:07:35 2006 -0700
@@ -19,6 +19,7 @@ static struct usb_device_id id_table [] 
 	{ USB_DEVICE(0xf3d, 0x0112) },  /* AirPrime CDMA Wireless PC Card */
 	{ USB_DEVICE(0x1410, 0x1110) }, /* Novatel Wireless Merlin CDMA */
 	{ USB_DEVICE(0x1199, 0x0112) }, /* Sierra Wireless Aircard 580 */
+	{ USB_DEVICE(0x1199, 0x0218) }, /* Sierra Wireless MC5720 */
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);



