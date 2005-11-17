Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVKQSHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKQSHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVKQSHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:07:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:31394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932479AbVKQSEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:16 -0500
Date: Thu, 17 Nov 2005 09:47:57 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       rpurdie@rpsys.net
Subject: [patch 19/22] USB: OHCI lh7a404 platform device conversion fixup
Message-ID: <20051117174757.GS11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ohci-lh7a404-platform-device-conversion-fixup.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Purdie <rpurdie@rpsys.net>

Fix an error in the OHCI lh7a404 driver after the platform device
conversion.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/ohci-lh7a404.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/usb/host/ohci-lh7a404.c
+++ usb-2.6/drivers/usb/host/ohci-lh7a404.c
@@ -219,7 +219,7 @@ static int ohci_hcd_lh7a404_drv_probe(st
 
 static int ohci_hcd_lh7a404_drv_remove(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_hcd_lh7a404_remove(hcd, pdev);
 	return 0;

--
