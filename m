Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWHBOaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWHBOaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWHBOaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:30:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37908 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750885AbWHBOaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:30:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=uC1+bytvtXGhq2vFbr6Pqvn2ecgsk7p+Om/aWb5umsnDWTmViqmW6CdpCg6CDitNdVuUn056Gbbk9/GrM46OI1ZEFa4PQpNxFvPmdcTNIRwiQeZAg9yt5vDP5BCHJY4Z/pFacZxlUiMuLXDmbpfpABxcYrn6yTqF1RYaEfCcoRQ=
Date: Wed, 2 Aug 2006 16:30:04 +0200
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: jayakumar.video@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH]: quickcam_messenger compilation fix
Message-Id: <20060802163004.6ebf2cd7.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In bugzilla #6943, Maxim Britov reported:

"I can enable Logitech quickcam support in .config, but it want be compile.
I have to add into drivers/media/video/Makefile:
obj-$(CONFIG_USB_QUICKCAM_MESSENGER)    += usbvideo/"

He's right, just enable that driver as module while disabling every other
driver that gets into that directory, nothing will get compiled.
This patch fixes the Makefile.

Signed-off-by: Diego Calleja <diegocg@gmail.com>

Index: 2.6/drivers/media/video/Makefile
===================================================================
--- 2.6.orig/drivers/media/video/Makefile	2006-08-02 16:22:40.000000000 +0200
+++ 2.6/drivers/media/video/Makefile	2006-08-02 16:22:51.000000000 +0200
@@ -91,6 +91,7 @@
 obj-$(CONFIG_USB_IBMCAM)        += usbvideo/
 obj-$(CONFIG_USB_KONICAWC)      += usbvideo/
 obj-$(CONFIG_USB_VICAM)         += usbvideo/
+obj-$(CONFIG_USB_QUICKCAM_MESSENGER)	+= usbvideo/
 
 obj-$(CONFIG_VIDEO_VIVI) += vivi.o
 
