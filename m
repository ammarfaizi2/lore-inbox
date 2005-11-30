Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVK3IJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVK3IJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVK3IJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:09:09 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:3984 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751117AbVK3IJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:09:07 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-usb-devel@lists.sourceforge.net, Greg K-H <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH] Additional device ID for Conexant AccessRunner USB driver
Date: Wed, 30 Nov 2005 09:09:06 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
References: <1133330317951@kroah.com>
In-Reply-To: <1133330317951@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511300909.06843.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
> index 79861ee..9d59dc6 100644
> --- a/drivers/usb/atm/cxacru.c
> +++ b/drivers/usb/atm/cxacru.c
> @@ -787,6 +787,9 @@ static const struct usb_device_id cxacru
>  	{ /* V = Conexant			P = ADSL modem (Hasbani project)	*/
>  		USB_DEVICE(0x0572, 0xcb00),	.driver_info = (unsigned long) &cxacru_cb00
>  	},
> +	{ /* V = Conexant             P = ADSL modem (Well PTI-800 */
> +		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
> +	},
>  	{ /* V = Conexant			P = ADSL modem				*/
>  		USB_DEVICE(0x0572, 0xcb01),	.driver_info = (unsigned long) &cxacru_cb00
>  	},

The whitespace is mucked up, and a closing bracket is missing after Well PTI-800...

Try this:

Signed-off-by: Duncan Sands <baldrick@free.fr>

Index: cxacru.c
===================================================================
RCS file: /home/cvs/speedtch/cxacru.c,v
retrieving revision 1.39
retrieving revision 1.40
diff -u -3 -p -r1.39 -r1.40
--- cxacru.c	20 Nov 2005 13:34:07 -0000	1.39
+++ cxacru.c	29 Nov 2005 12:54:09 -0000	1.40
@@ -786,6 +786,9 @@ static const struct usb_device_id cxacru
 	{ /* V = Conexant			P = ADSL modem				*/
 		USB_DEVICE(0x0572, 0xcb01),	.driver_info = (unsigned long) &cxacru_cb00
 	},
+	{ /* V = Conexant			P = ADSL modem (Well PTI-800) */
+		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
+	},
 	{ /* V = Conexant			P = ADSL modem				*/
 		USB_DEVICE(0x0572, 0xcb06),	.driver_info = (unsigned long) &cxacru_cb00
 	},
