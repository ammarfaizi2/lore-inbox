Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVJNXmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVJNXmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVJNXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 19:42:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:36805 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750811AbVJNXmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 19:42:54 -0400
Date: Fri, 14 Oct 2005 16:42:25 -0700
From: Greg KH <greg@kroah.com>
To: Christian Krause <chkr@plauener.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Chris Wright <chrisw@osdl.org>,
       Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Message-ID: <20051014234225.GA11301@kroah.com>
References: <m34q7mwlvv.fsf@gondor.middle-earth.priv> <20051013224839.GA3583@kroah.com> <m3oe5riwib.fsf@gondor.middle-earth.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3oe5riwib.fsf@gondor.middle-earth.priv>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 07:57:45PM +0200, Christian Krause wrote:
> --- linux-2.6.13.4/drivers/usb/input/hid-core.c.old	2005-10-12 21:29:29.000000000 +0200
> +++ linux-2.6.13.4/drivers/usb/input/hid-core.c	2005-10-12 21:31:02.000000000 +0200
> @@ -1667,11 +1667,6 @@ static struct hid_device *usb_hid_config
>  		if ((endpoint->bmAttributes & 3) != 3)		/* Not an interrupt endpoint */
>  			continue;
>  
> -		/* handle potential highspeed HID correctly */
> -		interval = endpoint->bInterval;
> -		if (dev->speed == USB_SPEED_HIGH)
> -			interval = 1 << (interval - 1);
> -

Did you try this patch out?  It is wrong.  Please look at the compiler
warning that this change generates and redo the patch.

thanks,

greg k-h
