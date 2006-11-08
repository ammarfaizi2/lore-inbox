Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965829AbWKHOgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965829AbWKHOgM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbWKHOfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:35:51 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:53254 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965822AbWKHOfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:35:44 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/33] usb: pvrusb2-io free urb cleanup
Date: Wed, 8 Nov 2006 15:34:50 +0100
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
Message-Id: <200611081534.51559.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/media/video/pvrusb2/pvrusb2-io.c	2006-11-06 17:07:44.000000000 +0100
+++ linux-2.6.19-rc4/drivers/media/video/pvrusb2/pvrusb2-io.c	2006-11-06 19:56:35.000000000 +0100
@@ -289,7 +289,7 @@ static void pvr2_buffer_done(struct pvr2
 	pvr2_buffer_set_none(bp);
 	bp->signature = 0;
 	bp->stream = NULL;
-	if (bp->purb) usb_free_urb(bp->purb);
+	usb_free_urb(bp->purb);
 	pvr2_trace(PVR2_TRACE_BUF_POOL,"/*---TRACE_FLOW---*/"
 		   " bufferDone     %p",bp);
 }
