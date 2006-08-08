Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWHHAX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWHHAX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWHHAX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:23:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:15566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932454AbWHHAX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:23:27 -0400
Subject: patch usbnet-printk-format-warning.patch added to gregkh-2.6 tree
To: rdunlap@xenotime.net, akpm@osdl.org, greg@kroah.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Mon, 07 Aug 2006 17:23:21 -0700
In-Reply-To: <20060807155640.63e59e6b.rdunlap@xenotime.net>
Message-Id: <20060808002324.66A867B311C@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: usbnet: printk format warning

to my gregkh-2.6 tree.  Its filename is

     usbnet-printk-format-warning.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rdunlap@xenotime.net Mon Aug  7 15:56:22 2006
Date: Mon, 7 Aug 2006 15:56:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, gregkh <greg@kroah.com>
Subject: usbnet: printk format warning
Message-Id: <20060807155640.63e59e6b.rdunlap@xenotime.net>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):
drivers/usb/net/usbnet.c:654: warning: int format, different type arg (arg 3)

Can't say that I understand this one...

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/net/usbnet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/usb/net/usbnet.c
+++ gregkh-2.6/drivers/usb/net/usbnet.c
@@ -652,7 +652,7 @@ static int usbnet_open (struct net_devic
 			framing = "simple";
 
 		devinfo (dev, "open: enable queueing "
-				"(rx %d, tx %d) mtu %d %s framing",
+				"(rx %ld, tx %d) mtu %u %s framing",
 			RX_QLEN (dev), TX_QLEN (dev), dev->net->mtu,
 			framing);
 	}


Patches currently in gregkh-2.6 which might be from rdunlap@xenotime.net are

driver/driver-core-fix-driver-core-kernel-doc.patch
driver/debugfs-kernel-doc-fixes-for-debugfs.patch
usb/usbnet-printk-format-warning.patch
