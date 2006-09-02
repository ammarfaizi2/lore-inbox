Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWIBSBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWIBSBt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWIBSBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:01:49 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:8358 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751263AbWIBSBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:01:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D12089lMhG1uHInRd4O4Eq/Kh/PhAbHuAJBvxkhN3I1yuwdEcKPudFppaszMQY/rE2OO7aU/iAmb98rNitJY8N0eiUG3XDPIXOVN4JMthGIJ0Qx1qMAHSidDpX2FOmty9zPjLJzy1GgZhI5uRir14ecz6+4FiA4O7P3lOABI0KU=
Message-ID: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>
Date: Sat, 2 Sep 2006 20:01:47 +0200
From: "Bas Bloemsaat" <bas.bloemsaat@gmail.com>
To: mchehab@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Vicam driver, device
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old webcam, a Compro PS39U. By windows it's recognized as
vicam and works with the vicam driver. With Linux it didn't work.
lsusb showed that it identifies different than camera's recognized by
the vicam driver. So I added the usb id to vicam.c, and it now
produces images through the driver under Linux too. It's still a
shitty camera though.

I'm submitting the change, maybe someone else has this camera and
want's to use it.

Regards,
Bas

--- drivers/media/video/usbvideo/vicam.c	2006-08-23 23:16:33.000000000 +0200
+++ drivers/media/video/usbvideo/vicam.c.compro	2006-09-02
19:45:20.000000000 +0200
@@ -60,6 +60,8 @@
 /* Define these values to match your device */
 #define USB_VICAM_VENDOR_ID	0x04c1
 #define USB_VICAM_PRODUCT_ID	0x009d
+#define USB_COMPRO_VENDOR_ID	0x0602
+#define USB_COMPRO_PRODUCT_ID	0x1001

 #define VICAM_BYTES_PER_PIXEL   3
 #define VICAM_MAX_READ_SIZE     (512*242+128)
@@ -1254,6 +1256,7 @@
 /* table of devices that work with this driver */
 static struct usb_device_id vicam_table[] = {
 	{USB_DEVICE(USB_VICAM_VENDOR_ID, USB_VICAM_PRODUCT_ID)},
+	{USB_DEVICE(USB_COMPRO_VENDOR_ID, USB_COMPRO_PRODUCT_ID)},
 	{}			/* Terminating entry */
 };

-- 
VGER BF report: H 0.404625
