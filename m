Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965888AbWKHOoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965888AbWKHOoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965833AbWKHOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:14 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:56070 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965816AbWKHOf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:57 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 11/33] usb: quickcam_messenger free urb cleanup
Date: Wed, 8 Nov 2006 15:35:02 +0100
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
Message-Id: <200611081535.04282.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/video/usbvideo/quickcam_messenger.c	2006-11-06 17:07:45.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/usbvideo/quickcam_messenger.c	2006-11-06 19:58:08.000000000 +0100
@@ -190,8 +190,7 @@ static int qcm_alloc_int_urb(struct qcm 
 
 static void qcm_free_int(struct qcm *cam)
 {
-	if (cam->button_urb)
-		usb_free_urb(cam->button_urb);
+	usb_free_urb(cam->button_urb);
 }
 #endif /* CONFIG_INPUT */
 
