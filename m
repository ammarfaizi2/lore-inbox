Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWCaUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWCaUAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWCaUAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:00:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47283
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932263AbWCaUAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:00:08 -0500
Date: Fri, 31 Mar 2006 11:59:35 -0800
From: Greg KH <greg@kroah.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: info@papouch.com, linux-kernel@vger.kernel.org, bryder@sgi.com
Subject: Re: Papouch USB thermometer support
Message-ID: <20060331195935.GA15859@kroah.com>
References: <20060324194655.GY4124@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324194655.GY4124@vanheusden.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 08:46:55PM +0100, Folkert van Heusden wrote:
> Hi,
> 
> The following patch against 2.6.15 adds support for the www.Papouch.com
> USB thermometer by adding the appropriate vendor and product id.
> 
> 
> Signed off: Folkert van Heusden <folkert@vanheusden.com

It should be "Signed-off-by:".

> diff -uNrbBd old/ftdi_sio.c new/ftdi_sio.c
> --- old/ftdi_sio.c      2006-03-24 20:36:19.000000000 +0100
> +++ new/ftdi_sio.c      2006-03-24 20:33:20.000000000 +0100

Can you make it so I can apply the patch from the root of the kernel
tree?  Documentation/SubmittingPatches describes how to create a patch
in this way.

> @@ -307,6 +307,7 @@
> 
> 
>  static struct usb_device_id id_table_combined [] = {
> +       { USB_DEVICE(PAPOUCHE_VENDOR, PAPOUCHE_THEM_PROD) },
>         { USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },

Your email client ate the tabs :(

>         { USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
>         { USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
> diff -uNrbBd old/ftdi_sio.h new/ftdi_sio.h
> --- old/ftdi_sio.h      2006-03-24 20:36:19.000000000 +0100
> +++ new/ftdi_sio.h      2006-03-24 20:37:35.000000000 +0100
> @@ -20,8 +20,13 @@
>   * Philipp G?hring - pg@futureware.at - added the Device ID of the USB relais
>   * from Rudolf Gugler
>   *
> + * Folkert van Heusden - folkert@vanheusden.com - added the device id of the
> + * temperature sensor from www.papouch.com

This information doesn't belong in the file, only in the changelog.
It's not needed.

Care to redo this?

thanks,

greg k-h
