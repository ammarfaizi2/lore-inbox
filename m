Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbULTAQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbULTAQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbULTAQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:16:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261356AbULTAQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:16:49 -0500
Date: Mon, 20 Dec 2004 01:16:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mdharm-usb@one-eyed-alien.net, zaitcev@yahoo.com
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220001644.GI21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already seen people crippling their usb-storage driver with 
enabling BLK_DEV_UB - and I doubt the warning in the help text added 
after 2.6.9 will fix all such problems.

Is there except for kernel size any good reason for using BLK_DEV_UB 
instead of USB_STORAGE?

If not, I'd suggest the patch below to let BLK_DEV_UB depend
on EMBEDDED.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/block/Kconfig.old	2004-12-20 00:52:22.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/block/Kconfig	2004-12-20 00:52:39.000000000 +0100
@@ -303,7 +303,7 @@
 
 config BLK_DEV_UB
 	tristate "Low Performance USB Block driver"
-	depends on USB
+	depends on USB && EMBEDDED
 	help
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.

