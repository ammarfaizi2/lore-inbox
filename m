Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTDGVkr (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTDGVkr (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:40:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42984 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263681AbTDGVkq (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:40:46 -0400
Date: Mon, 7 Apr 2003 14:54:43 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in sysfs
Message-ID: <20030407215443.GA4386@kroah.com>
References: <1049750163.4174.35.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049750163.4174.35.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 11:16:03PM +0200, Martin Schlemmer wrote:
> --- drivers/i2c/chips/w83781d.c.orig	2003-04-07 22:53:37.000000000 +0200
> +++ drivers/i2c/chips/w83781d.c	2003-04-07 22:53:34.000000000 +0200
> @@ -364,7 +364,7 @@
>  	 \
>  	w83781d_update_client(client); \
>  	 \
> -	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
> +	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \

Hm, this patch looks backwards, is it?

Also, just as a side note, can you make your patches so that they can be
applied with "patch -p1" instead of "patch -p0" which your current ones
are?  My tools treat -p1 patches much better :)

thanks,

greg k-h
