Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTEEU4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTEEU4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:56:45 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:10881 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S261359AbTEEU4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:56:43 -0400
Subject: Re: [PATCH] 2.5.69 : drivers/bluetooth/hci_usb.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Frank Davis <fdavis@si.rr.com>, Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305052257.19652.fsdeveloper@yahoo.de>
References: <Pine.LNX.4.44.0305051642060.18736-100000@master> 
	<200305052257.19652.fsdeveloper@yahoo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 May 2003 23:07:01 +0200
Message-Id: <1052168827.16216.22.camel@pegasus.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> And I suspect, this patch is wrong. :)

here is the correct patch.

Regards

Marcel

diff -Nru a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
--- a/drivers/bluetooth/hci_usb.c       Mon May  5 23:04:11 2003
+++ b/drivers/bluetooth/hci_usb.c       Mon May  5 23:04:11 2003
@@ -64,8 +64,8 @@
 #endif
 
 #ifndef CONFIG_BT_USB_ZERO_PACKET
-#undef  USB_ZERO_PACKET
-#define USB_ZERO_PACKET 0
+#undef  URB_ZERO_PACKET
+#define URB_ZERO_PACKET 0
 #endif
 
 static struct usb_driver hci_usb_driver; 
@@ -458,7 +458,7 @@
        pipe = usb_sndbulkpipe(husb->udev, husb->bulk_out_ep->desc.bEndpointAddress);
        usb_fill_bulk_urb(urb, husb->udev, pipe, skb->data, skb->len, 
                        hci_usb_tx_complete, husb);
-       urb->transfer_flags = USB_ZERO_PACKET;
+       urb->transfer_flags = URB_ZERO_PACKET;
 
        BT_DBG("%s skb %p len %d", husb->hdev.name, skb, skb->len);
 



