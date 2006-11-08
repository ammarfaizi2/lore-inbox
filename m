Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965869AbWKHOiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965869AbWKHOiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965864AbWKHOh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:57 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:8199 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965879AbWKHOhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:41 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 29/33] usb: navman kill urb cleanup
Date: Wed, 8 Nov 2006 15:36:46 +0100
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
Message-Id: <200611081536.48311.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/navman.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/navman.c	2006-11-07 17:06:28.000000000 +0100
@@ -95,8 +95,7 @@ static void navman_close(struct usb_seri
 {
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	if (port->interrupt_in_urb)
-		usb_kill_urb(port->interrupt_in_urb);
+	usb_kill_urb(port->interrupt_in_urb);
 }
 
 static int navman_write(struct usb_serial_port *port,
