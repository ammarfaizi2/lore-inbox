Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVLVRto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVLVRto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVLVRto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:49:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:15516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030202AbVLVRtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:49:43 -0500
Date: Thu, 22 Dec 2005 09:48:50 -0800
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: gcoady@gmail.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.15-rc5-mm3
Message-ID: <20051222174850.GK23837@kroah.com>
References: <20051214234016.0112a86e.akpm@osdl.org> <276aq1pc2us3np77rd8p6gvifbdj4nf2vd@4ax.com> <200512181231.55981.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512181231.55981.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 12:31:55PM +0100, Rafael J. Wysocki wrote:
> 
> Could you please use the appended patch and see if that makes things better
> (or worse)?
> 
> Greetings,
> Rafael
> 
> 
>  drivers/usb/host/ehci-hcd.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.15-rc5-mm2/drivers/usb/host/ehci-hcd.c
> ===================================================================
> --- linux-2.6.15-rc5-mm2.orig/drivers/usb/host/ehci-hcd.c	2005-12-11 13:57:27.000000000 +0100
> +++ linux-2.6.15-rc5-mm2/drivers/usb/host/ehci-hcd.c	2005-12-13 22:10:53.000000000 +0100
> @@ -617,7 +617,7 @@
>  	}
>  
>  	/* remote wakeup [4.3.1] */
> -	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
> +	if (status & STS_PCD) {
>  		unsigned	i = HCS_N_PORTS (ehci->hcs_params);
>  
>  		/* resume root hub? */

David, care to put a proper header on this and send it to me so I can
add it to my tree?

thanks,

greg k-h
