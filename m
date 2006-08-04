Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161333AbWHDRXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbWHDRXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWHDRXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:23:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:3744 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161333AbWHDRXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:23:49 -0400
Date: Fri, 4 Aug 2006 10:23:40 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Davies <jjd27@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftdi_sio driver - new PIDs
Message-ID: <20060804172340.GA10696@kroah.com>
References: <44D35AF1.2040200@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D35AF1.2040200@cam.ac.uk>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 03:34:25PM +0100, Jonathan Davies wrote:
> Hello,
> 
> I have come across some USB Serial FTDI-based devices which are not 
> automatically detected by ftdi_sio, as of Linux 2.6.17, because their 
> Product IDs are not recognised by the driver.
> 
> The devices are:
> 
> 1. AlphaMicro Components AMC-232USB01 (serial to USB converter cable)
>   - http://www.alphamicro.net/components/product~line~4~id~224.asp
>   - vendor ID 0x0403
>   - product ID 0xff00
> 
> 2. Lawicel CANUSB (CAN bus to USB converter dongle)
>   - http://www.canusb.com/
>   - vendor ID 0x0403
>   - product ID 0xffa8
> 
> Below is the patch for drivers/usb/serial/ftdi_sio.{c,h} against Linux 
> 2.6.17 which includes these Product IDs.
> 
> Signed-off-by: Jonathan Davies <jjd27@cam.ac.uk>
> 
> 
> diff -uprN -X dontdiff linux-vanilla/drivers/usb/serial/ftdi_sio.c 
> linux-2.6.17/drivers/usb/serial/ftdi_sio.c
> --- linux-vanilla/drivers/usb/serial/ftdi_sio.c 2006-08-04 
> 15:12:02.000000000 +0100
> +++ linux-2.6.17/drivers/usb/serial/ftdi_sio.c  2006-08-04 
> 15:07:43.000000000 +0100

Your patch is line-wrapped and the tabs are eaten, making it hard to
apply the patch :(

Also, can you make this against the 2.6.18-rc3 kernel, as there are a
lot of new ids already added for this device and this patch conflicts
with it a bit.

> @@ -17,6 +17,9 @@
>   * See http://ftdi-usb-sio.sourceforge.net for upto date testing info
>   * and extra documentation
>   *
> + * (04/Aug/2006) Jonathan Davies
> + *      Added PIDs for AMC232 and Lawicel CANUSB.
> + *

This section isn't needed anymore, the git changelog is all that is
used now.

thanks,

greg k-h
