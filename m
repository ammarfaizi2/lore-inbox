Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWHGW4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWHGW4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWHGW4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:56:48 -0400
Received: from xenotime.net ([66.160.160.81]:27569 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750879AbWHGW4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:56:21 -0400
Date: Mon, 7 Aug 2006 15:56:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, gregkh <greg@kroah.com>
Subject: [PATCH -mm 5/5] usbnet: printk format warning
Message-Id: <20060807155640.63e59e6b.rdunlap@xenotime.net>
In-Reply-To: <20060807155432.a7462087.rdunlap@xenotime.net>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
	<20060807155044.a8eee456.rdunlap@xenotime.net>
	<20060807155208.666d7ea3.rdunlap@xenotime.net>
	<20060807155432.a7462087.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):
drivers/usb/net/usbnet.c:654: warning: int format, different type arg (arg 3)

Can't say that I understand this one...

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/net/usbnet.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc3mm2.orig/drivers/usb/net/usbnet.c
+++ linux-2618-rc3mm2/drivers/usb/net/usbnet.c
@@ -652,7 +652,7 @@ static int usbnet_open (struct net_devic
 			framing = "simple";
 
 		devinfo (dev, "open: enable queueing "
-				"(rx %d, tx %d) mtu %d %s framing",
+				"(rx %ld, tx %d) mtu %u %s framing",
 			RX_QLEN (dev), TX_QLEN (dev), dev->net->mtu,
 			framing);
 	}


---
