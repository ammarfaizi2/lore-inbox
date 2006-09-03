Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWICIi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWICIi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 04:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWICIi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 04:38:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:40306 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750906AbWICIi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 04:38:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XFHu2E0+lD85aL72Rrd7hQT+uroxLkz3V6aX2YHG7FIHd+uj7DTX1G0h1lA/vTjmRL3AHCwHMDRPzlLG3yW3NN1xrkzCu/EltdD4ZLmj0pCd9FJwMiJLUNS6tFy64saLx6eGkTsMDKz6ytO1zrC3cP3l8URyvu0jLDjONYs1mPw=
Message-ID: <44FA9493.1090207@gmail.com>
Date: Sun, 03 Sep 2006 10:38:43 +0200
From: Bas Bloemsaat <bas.bloemsaat@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: mchehab@infradead.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Vicam driver, device
References: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>	 <1157220743.15841.118.camel@praia> <7c4668e50609030111i5f3cb079j76e9c8651cf8d6b4@mail.gmail.com>
In-Reply-To: <7c4668e50609030111i5f3cb079j76e9c8651cf8d6b4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Although this is really a trivial patch, it would be nice if you can
> sign your patch (on our wiki you can have more info about patch
> 
> Also, it would be nice if you add a comment above the new entry at vicam
> PCI table a short comment describing the new device, like, for example:
Done. I put a line under the current one describing the cam it was developed for.

And mailed the text without wrapping (thanks to Pavel for bringing that to my attention).

Regards,
Bas

Description:
Trivial patch to make Compro PS39U WebCam work with linux by using the vicam driver.
The camera is just a vicam with another USB ID, so I added that ID to the driver, and it works now.

Signed-off-by: Bas Bloemsaat <bas.bloemsaat@gmail.com>


--- drivers/media/video/usbvideo/vicam.c.org	2006-09-03 10:19:06.000000000 +0200
+++ drivers/media/video/usbvideo/vicam.c	2006-09-03 10:22:52.000000000 +0200
@@ -7,6 +7,7 @@
   *                    Monroe Williams (monroe@pobox.com)
   *
   * Supports 3COM HomeConnect PC Digital WebCam
+ * Supports Compro PS39U WebCam
   *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License as published by
@@ -60,6 +61,8 @@
  /* Define these values to match your device */
  #define USB_VICAM_VENDOR_ID	0x04c1
  #define USB_VICAM_PRODUCT_ID	0x009d
+#define USB_COMPRO_VENDOR_ID	0x0602
+#define USB_COMPRO_PRODUCT_ID	0x1001

  #define VICAM_BYTES_PER_PIXEL   3
  #define VICAM_MAX_READ_SIZE     (512*242+128)
@@ -1254,6 +1257,7 @@ static struct video_device vicam_templat
  /* table of devices that work with this driver */
  static struct usb_device_id vicam_table[] = {
  	{USB_DEVICE(USB_VICAM_VENDOR_ID, USB_VICAM_PRODUCT_ID)},
+	{USB_DEVICE(USB_COMPRO_VENDOR_ID, USB_COMPRO_PRODUCT_ID)},
  	{}			/* Terminating entry */
  };


-- 
VGER BF report: U 0.954643
