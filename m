Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUDWRQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUDWRQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDWRQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:16:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:1770 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262142AbUDWRQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:16:40 -0400
Date: Fri, 23 Apr 2004 10:16:14 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423171614.GA13835@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net> <200404230802.42293.dtor_core@ameritech.net> <1082730412.23959.118.camel@pegasus> <200404231156.03106.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404231156.03106.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 11:55:59AM -0500, Dmitry Torokhov wrote:
> --- 1.11/drivers/net/wireless/atmel_cs.c	Thu Feb  5 05:04:40 2004
> +++ edited/drivers/net/wireless/atmel_cs.c	Fri Apr 23 11:43:42 2004
> @@ -348,17 +348,13 @@
>  	{ 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" } 
>  };
>  
> -/* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
> -static struct device atmel_device = {
> -        .bus_id    = "pcmcia",
> -};
> -

<snip>

Much nicer (well, in a wierd way at least.)  It seems that the pcmcia
system is intregrated into the driver model.  Why not push it down into
the individual pcmcia drivers so you don't have to do this GetSysDevice
kind of hack still?

thanks,

greg k-h
