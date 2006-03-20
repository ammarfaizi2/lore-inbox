Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWCTElq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWCTElq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWCTElp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:41:45 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:62223 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751497AbWCTElW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:41:22 -0500
Date: Mon, 20 Mar 2006 04:41:06 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, greg@kroah.com
Subject: [PATCH 11/12] [USB] Cosmetic changes to bring ohci-au1xxx.c in sync with linux-mips
Message-ID: <20060320044106.GK20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are two cosmetic changes which bring ohci-au1xxx.c in sync with
the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/usb/host/ohci-au1xxx.c	2006-03-05 19:35:05.000000000 +0000
+++ mips.git/drivers/usb/host/ohci-au1xxx.c	2006-03-13 18:43:52.000000000 +0000
@@ -92,12 +92,12 @@
 	int retval;
 	struct usb_hcd *hcd;
 
-	if(dev->resource[1].flags != IORESOURCE_IRQ) {
+	if (dev->resource[1].flags != IORESOURCE_IRQ) {
 		pr_debug ("resource[1] is not IORESOURCE_IRQ");
 		return -ENOMEM;
 	}
 
-	hcd = usb_create_hcd(driver, &dev->dev, "au1xxx");
+	hcd = usb_create_hcd(driver, &dev->dev, "Au1xxx");
 	if (!hcd)
 		return -ENOMEM;
 	hcd->rsrc_start = dev->resource[0].start;

-- 
Martin Michlmayr
http://www.cyrius.com/
