Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965786AbWKHOfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965786AbWKHOfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965804AbWKHOfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:35:07 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:34821 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965786AbWKHOfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:03 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/33] usb: iforce-usb free urb cleanup
Date: Wed, 8 Nov 2006 15:34:09 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <200611071030.57152.m.kozlowski@tuxland.pl> <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <20061107013702.46b5710f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611081534.10404.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/input/joystick/iforce/iforce-usb.c	2006-11-06 17:07:30.000000000 +0100
+++ linux-2.6.19-rc4/drivers/input/joystick/iforce/iforce-usb.c	2006-11-06 19:52:04.000000000 +0100
@@ -178,9 +178,9 @@ static int iforce_usb_probe(struct usb_i
 
 fail:
 	if (iforce) {
-		if (iforce->irq) usb_free_urb(iforce->irq);
-		if (iforce->out) usb_free_urb(iforce->out);
-		if (iforce->ctrl) usb_free_urb(iforce->ctrl);
+		usb_free_urb(iforce->irq);
+		usb_free_urb(iforce->out);
+		usb_free_urb(iforce->ctrl);
 		kfree(iforce);
 	}
 
