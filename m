Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVISDCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVISDCw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 23:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVISDCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 23:02:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:21137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932302AbVISDCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 23:02:52 -0400
Date: Sun, 18 Sep 2005 20:02:06 -0700
From: Greg KH <greg@kroah.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Karsten Keil <kkeil@suse.de>
Subject: Re: [linux-usb-devel] URB_ASYNC_UNLINK b0rkage
Message-ID: <20050919030206.GA16966@kroah.com>
References: <20050918190526.GB787@mipter.zuzino.mipt.ru> <Pine.LNX.4.44L0.0509181718360.2126-100000@netrider.rowland.org> <20050918223811.GA24046@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918223811.GA24046@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 02:38:12AM +0400, Alexey Dobriyan wrote:
> > In my kernel tree, the st5481 source files don't include the lines you 
> > show.  What source version are you using?
> 
> 23 hours ago:
> 
> commit 61ffcafafb3d985e1ab8463be0187b421614775c
> Author: Karsten Keil <kkeil@suse.de>
> Date:   Sat Sep 17 23:52:42 2005 +0200
> 
>     [PATCH] Fix ST 5481 USB driver
> 
>     The old driver was not fully adapted to new USB ABI and does not
>     work.
> 
> +	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
>  	usb_unlink_urb(in->urb[0]);
> +	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
>  	usb_unlink_urb(in->urb[1]);

And I already pointed out that this patch was wrong, and would cause
build errors...

thanks,

greg k-h
