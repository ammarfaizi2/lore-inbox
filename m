Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVGHNLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVGHNLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVGHNLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:11:43 -0400
Received: from barad-dur.crans.org ([138.231.141.187]:21452 "EHLO
	barad-dur.minas-morgul.org") by vger.kernel.org with ESMTP
	id S262655AbVGHNLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:11:13 -0400
From: "Mathieu" <matt@minas-morgul.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/usb/zd1201.c: Gigabyte GN-WLBZ201 dongle usbid  
X-PGP-KeyID: 0x2E13FCA8
X-PGP-Fingerprint: D41C FC4F 7374 D3FA A121 9182 90AC 62B0 2E13 FCA8
Date: jeu, 07 jui 2005 15:09:03 +0200
Message-ID: <878y0i930w.fsf@barad-dur.minas-morgul.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Gigabyte GN-WLBZ201 wifi usb dongle works very well, using the zd1201
driver. the only missing part is that the corresponding usbid is not
declared. The following patch should fix this.

Mathieu


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=gigabyte-zd1201-usbid.patch

Index: linux-2.6.12/drivers/usb/net/zd1201.c
===================================================================
--- linux-2.6.12.orig/drivers/usb/net/zd1201.c
+++ linux-2.6.12/drivers/usb/net/zd1201.c
@@ -29,6 +29,7 @@ static struct usb_device_id zd1201_table
 	{USB_DEVICE(0x0ace, 0x1201)}, /* ZyDAS ZD1201 Wireless USB Adapter */
 	{USB_DEVICE(0x050d, 0x6051)}, /* Belkin F5D6051 usb  adapter */
 	{USB_DEVICE(0x0db0, 0x6823)}, /* MSI UB11B usb  adapter */
+        {USB_DEVICE(0x1044, Ox8005)}, /* GIGABYTE GN-WLBZ201 usb adapter */
 	{}
 };
 

--=-=-=



-- 
"If we can't keep this sort of thing out of the kernel, we might as well
 pack it up and go run Solaris."

	- Larry McVoy

--=-=-=--
