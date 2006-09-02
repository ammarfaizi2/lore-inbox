Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWIBSNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWIBSNB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWIBSNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:13:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27527 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750818AbWIBSM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:12:59 -0400
Subject: Re: [PATCH] Vicam driver, device
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Bas Bloemsaat <bas.bloemsaat@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>
References: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 02 Sep 2006 15:12:22 -0300
Message-Id: <1157220743.15841.118.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Blas,

Em Sáb, 2006-09-02 às 20:01 +0200, Bas Bloemsaat escreveu:
> Hi,
> 
> I have an old webcam, a Compro PS39U. By windows it's recognized as
> vicam and works with the vicam driver. With Linux it didn't work.
> lsusb showed that it identifies different than camera's recognized by
> the vicam driver. So I added the usb id to vicam.c, and it now
> produces images through the driver under Linux too. It's still a
> shitty camera though.
> 
> I'm submitting the change, maybe someone else has this camera and
> want's to use it.

Although this is really a trivial patch, it would be nice if you can
sign your patch (on our wiki you can have more info about patch
submission procedure:
http://linuxtv.org/v4lwiki/index.php/How_to_submit_patches). Basically,
you should send at the email a line with:
	Signed-off-by: Your name <name@yoursite.com>

Also, it would be nice if you add a comment above the new entry at vicam
PCI table a short comment describing the new device, like, for example:

/* Compro PS39U */

> 
> Regards,
> Bas
> 
> --- drivers/media/video/usbvideo/vicam.c	2006-08-23 23:16:33.000000000 +0200
> +++ drivers/media/video/usbvideo/vicam.c.compro	2006-09-02
> 19:45:20.000000000 +0200
> @@ -60,6 +60,8 @@
>  /* Define these values to match your device */
>  #define USB_VICAM_VENDOR_ID	0x04c1
>  #define USB_VICAM_PRODUCT_ID	0x009d
> +#define USB_COMPRO_VENDOR_ID	0x0602
> +#define USB_COMPRO_PRODUCT_ID	0x1001
> 
>  #define VICAM_BYTES_PER_PIXEL   3
>  #define VICAM_MAX_READ_SIZE     (512*242+128)
> @@ -1254,6 +1256,7 @@
>  /* table of devices that work with this driver */
>  static struct usb_device_id vicam_table[] = {
>  	{USB_DEVICE(USB_VICAM_VENDOR_ID, USB_VICAM_PRODUCT_ID)},
> +	{USB_DEVICE(USB_COMPRO_VENDOR_ID, USB_COMPRO_PRODUCT_ID)},
>  	{}			/* Terminating entry */
>  };
Cheers, 
Mauro.


-- 
VGER BF report: U 0.5
