Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965861AbWKHOlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965861AbWKHOlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965834AbWKHOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:44 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3079 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965838AbWKHOhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:20 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 24/33] usb: ftdi_sio kill urb cleanup
Date: Wed, 8 Nov 2006 15:36:25 +0100
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
Message-Id: <200611081536.26972.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/serial/ftdi_sio.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/serial/ftdi_sio.c	2006-11-07 17:39:20.000000000 +0100
@@ -1386,8 +1386,7 @@ static void ftdi_close (struct usb_seria
 	flush_scheduled_work();
 
 	/* shutdown our bulk read */
-	if (port->read_urb)
-		usb_kill_urb(port->read_urb);
+	usb_kill_urb(port->read_urb);
 } /* ftdi_close */
 
 
