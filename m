Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWCZSDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWCZSDN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWCZSDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:03:12 -0500
Received: from keetweej.vanheusden.com ([213.84.46.114]:6638 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1750756AbWCZSDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:03:12 -0500
Date: Sun, 26 Mar 2006 20:03:10 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH 2/2]: add support for Papouch TMU (USB thermometer)
Message-ID: <20060326180309.GD3569@vanheusden.com>
References: <4426BD1A.7070204@thinrope.net> <4426C1BF.90802@thinrope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4426C1BF.90802@thinrope.net>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Mar 27 14:33:39 CEST 2006
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Folkert van Heusden <folkert@vanheusden.com>

On Mon, Mar 27, 2006 at 01:30:55AM +0900, Kalin KOZHUHAROV wrote:
> 
> This patch adds support for new vendor (papouch) and one of their
> devices - TMU (a USB thermometer).
> 
> More information:
> vendor homepage:
> 	http://www.papouch.com/en/
> product homepage (Polish):
> 	http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0188
> 
> This patch is based on the submission from Folkert van Heusden [1].
> Folkert, please test it and add your ACK here.
> 
> Unfortunately I don't own such device, so this is not tested.
> 
> [1]	http://article.gmane.org/gmane.linux.kernel/392970
> 
> 
> Signed-off-by: Kalin KOZHUHAROV <kalin@thinrope.net>
> 
> 
> diff -pruN linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.c linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.c
> --- linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.c	2006-03-20 14:53:29.000000000 +0900
> +++ linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.c	2006-03-27 00:52:20.000000000 +0900
> @@ -492,6 +492,7 @@ static struct usb_device_id id_table_com
>  	{ USB_DEVICE(FTDI_VID, FTDI_WESTREX_MODEL_777_PID) },
>  	{ USB_DEVICE(FTDI_VID, FTDI_WESTREX_MODEL_8900F_PID) },
>  	{ USB_DEVICE(FTDI_VID, FTDI_PCDJ_DAC2_PID) },
> +	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_TMU_PID) },
>  	{ },					/* Optional parameter entry */
>  	{ }					/* Terminating entry */
>  };
> diff -pruN linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.h linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.h
> --- linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.h	2006-03-27 00:49:43.000000000 +0900
> +++ linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.h	2006-03-27 00:46:55.000000000 +0900
> @@ -392,6 +392,15 @@
>  #define FTDI_WESTREX_MODEL_777_PID	0xDC00	/* Model 777 */
>  #define FTDI_WESTREX_MODEL_8900F_PID	0xDC01	/* Model 8900F */
>  
> +/*
> + * Papouch products (http://www.papouch.com/)
> + * Submitted by Folkert van Heusden
> + */
> +
> +#define PAPOUCH_VID			0x5050	/* Vendor ID */
> +#define PAPOUCH_TMU_PID			0x0400	/* TMU USB Thermometer */
> +
> +
>  /* Commands */
>  #define FTDI_SIO_RESET			0	/* Reset the port */
>  #define FTDI_SIO_MODEM_CTRL		1	/* Set the modem control register */
> 
> 
> -- 
> |[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
> +-> http://ThinRope.net/ <-+
> |[ ______________________ ]|
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Folkert van Heusden

-- 
iPod winnen? --> http://keetweej.vanheusden.com/redir.php?id=62
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
