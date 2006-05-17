Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWERArV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWERArV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWERArU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:47:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:10474 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751125AbWERArU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:47:20 -0400
Date: Wed, 17 May 2006 16:59:02 -0700
From: Greg KH <greg@kroah.com>
To: Eduard Warkentin <eduard.warkentin@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] added support for ASIX 88178 chipset USB Gigabit Ethernet adaptor
Message-ID: <20060517235902.GA8060@kroah.com>
References: <e4gbbs$d37$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4gbbs$d37$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 01:24:45AM +0200, Eduard Warkentin wrote:
> FROM: Eduard Warkentin <eduard.warkentin@gmx.de>
> 
> Added support for detetcion an dworking with a ASIX 88178 based USB-Gigabit
> adaptor. With the patch, it is detected and handled correctly by the asix
> module.
> 
> ---<snip>---
> --- ./drivers/usb/net/asix.c.orig 2006-03-20 06:53:29.000000000 +0100
> +++ ./drivers/usb/net/asix.c  2006-05-18 01:18:52.000000000 +0200
> @@ -913,6 +913,10 @@ static const struct usb_device_id  produc
>          USB_DEVICE (0x0b95, 0x7720),
>          .driver_info = (unsigned long) &ax88772_info,
>  }, {
> +  // ASIX AX88178 10/100/1000
> +  USB_DEVICE (0x0b95, 0x1780),
> +  .driver_info = (unsigned long) &ax88772_info,
> +}, {

Hm, your tabs and spaces are messed up :(

And you didn't CC: the driver maintainer :(

>   // Linksys USB200M Rev 2
>   USB_DEVICE (0x13b1, 0x0018),
>   .driver_info = (unsigned long) &ax88772_info,
> ---<snap>---
> 
> Signed-off-by: Eduard Warkentin <eduard.warkentin@gmx.de>

And you put this at the bottom (it goes up in the changelog description)
:(

Care to try again?

thanks,

greg k-h
