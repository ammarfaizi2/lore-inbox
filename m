Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261236AbVCEXoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVCEXoo (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCEXm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:42:28 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:1157 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261243AbVCEXhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:51 -0500
Date: Sat, 05 Mar 2005 17:37:50 -0600 (CST)
Date-warning: Date header was inserted by vms040.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 7/13] hidcore: Clean up printk()'s in
 drivers/usb/input/hid-core.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233750.7648.43791.72691@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a KERN_ERR constant and a driver prefix to printk()s needing them in
drivers/usb/input/hid-core.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/input/hid-core.c linux-2.6.11-mm1/drivers/usb/input/hid-core.c
--- linux-2.6.11-mm1-original/drivers/usb/input/hid-core.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/input/hid-core.c	2005-03-05 15:45:44.000000000 -0500
@@ -1758,12 +1758,12 @@ static int hid_probe(struct usb_interfac
 	usb_set_intfdata(intf, hid);
 
 	if (!hid->claimed) {
-		printk ("HID device not claimed by input or hiddev\n");
+		printk (KERN_ERR "HID device not claimed by input or hiddev\n");
 		hid_disconnect(intf);
 		return -EIO;
 	}
 
-	printk(KERN_INFO);
+	printk(KERN_INFO "usbhid: ");
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		printk("input");
