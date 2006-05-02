Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWEBUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWEBUHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWEBUHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:07:10 -0400
Received: from mail.suse.de ([195.135.220.2]:9178 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750965AbWEBUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:07:08 -0400
Date: Tue, 2 May 2006 13:05:32 -0700
From: Greg KH <greg@kroah.com>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftdi_sio: ACT Solutions HomePro ZWave interface
Message-ID: <20060502200532.GA8172@kroah.com>
References: <44572749.6090103@plutohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44572749.6090103@plutohome.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 12:32:57PM +0300, Razvan Gavril wrote:

Care to diff this against 2.6.17-rc3?  Lots of ftdi new device ids have
been added there.

You also forgot to add a "Signed-off-by:" line :(

> diff -Nur linux-2.6.16.12/drivers/usb/serial/ftdi_sio.c linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.c
> --- linux-2.6.16.12/drivers/usb/serial/ftdi_sio.c	2006-05-01 15:14:26.000000000 -0400
> +++ linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.c	2006-05-02 05:12:10.000000000 -0400
> @@ -307,6 +307,7 @@
>  
>  
>  static struct usb_device_id id_table_combined [] = {
> +	{ USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
>  	{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
>  	{ USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
>  	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
> diff -Nur linux-2.6.16.12/drivers/usb/serial/ftdi_sio.h linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.h
> --- linux-2.6.16.12/drivers/usb/serial/ftdi_sio.h	2006-05-01 15:14:26.000000000 -0400
> +++ linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.h	2006-05-02 05:13:00.000000000 -0400
> @@ -380,6 +380,9 @@
>  /* Pyramid Computer GmbH */
>  #define FTDI_PYRAMID_PID	0xE6C8	/* Pyramid Appliance Display */
>  
> +/* ACT Solutions HomePro ZWave interface (http://www.act-solutions.com/HomePro.htm) */
> +#define FTDI_ACTZWAVE_PID      0xF2D0

Please use a tab here.

thanks,

greg k-h
