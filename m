Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVKOSyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVKOSyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVKOSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:54:39 -0500
Received: from [195.144.244.147] ([195.144.244.147]:30946 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S964985AbVKOSye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:54:34 -0500
Message-ID: <437A2EE8.4050404@varma-el.com>
Date: Tue, 15 Nov 2005 21:54:32 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
       ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert platform
 drivers to use_ (again)
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: multipart/mixed;
 boundary="------------030104070109080504070906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030104070109080504070906
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hello Russell,

I fear it is not a last patch of such kind :(.
Please recheck places where you are changed
pdev<->dev.

-- 
Regards
Andrey Volkov


--------------030104070109080504070906
Content-Type: text/plain;
 name="ohci-ohci-ppc-soc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ohci-ohci-ppc-soc.diff"

Fix copy-paste bug in ohci-ppc-soc.c(ohci_hcd_ppc_soc_drv_remove)

Sign-off-by: Andrey Volkov <avolkov@varma-el.com>
---

diff --git a/drivers/usb/host/ohci-ppc-soc.c b/drivers/usb/host/ohci-ppc-soc.c
index 1875576..2ec6a78 100644
--- a/drivers/usb/host/ohci-ppc-soc.c
+++ b/drivers/usb/host/ohci-ppc-soc.c
@@ -185,7 +185,7 @@ static int ohci_hcd_ppc_soc_drv_probe(st
 
 static int ohci_hcd_ppc_soc_drv_remove(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_hcd_ppc_soc_remove(hcd, pdev);
 	return 0;

--------------030104070109080504070906--
