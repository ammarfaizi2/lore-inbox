Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWALQpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWALQpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWALQpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:45:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:47329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030472AbWALQpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:45:18 -0500
Date: Thu, 12 Jan 2006 08:43:48 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [-mm patch] fix arch/ia64/sn/kernel/tiocx.c compilation
Message-ID: <20060112164348.GA4238@kroah.com>
References: <20060111042135.24faf878.akpm@osdl.org> <20060112010240.GN29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112010240.GN29663@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:02:40AM +0100, Adrian Bunk wrote:
> On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-mm2:
> >...
> > +gregkh-driver-add-tiocx-bus_type-probe-remove-methods.patch
> >...
> >  driver tree updates
> >...
> 
> This patch caused the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/ia64/sn/kernel/tiocx.o
> arch/ia64/sn/kernel/tiocx.c:151: error: 'cx_device_remove' undeclared here (not in a function)
> make[2]: *** [arch/ia64/sn/kernel/tiocx.o] Error 1
> 
> <--  snip  -->
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-mm3/arch/ia64/sn/kernel/tiocx.c.old	2006-01-12 01:58:20.000000000 +0100
> +++ linux-2.6.15-mm3/arch/ia64/sn/kernel/tiocx.c	2006-01-12 01:58:35.000000000 +0100
> @@ -148,7 +148,7 @@
>  	.match = tiocx_match,
>  	.uevent = tiocx_uevent,
>  	.probe = cx_device_probe,
> -	.remove = cx_device_remove,
> +	.remove = cx_driver_remove,
>  };

Thanks, I've merged it into the original patch now.

greg k-h
