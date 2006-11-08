Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965833AbWKHOoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965833AbWKHOoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965839AbWKHOgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:36:12 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:57094 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965833AbWKHOgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:06 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 12/33] usb: zc0301_core free urb cleanup
Date: Wed, 8 Nov 2006 15:35:12 +0100
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
Message-Id: <200611081535.13232.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/video/zc0301/zc0301_core.c	2006-11-06 17:07:46.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/zc0301/zc0301_core.c	2006-11-06 19:58:40.000000000 +0100
@@ -489,7 +489,7 @@ static int zc0301_start_transfer(struct 
 	return 0;
 
 free_urbs:
-	for (i = 0; (i < ZC0301_URBS) &&  cam->urb[i]; i++)
+	for (i = 0; i < ZC0301_URBS; i++)
 		usb_free_urb(cam->urb[i]);
 
 free_buffers:
