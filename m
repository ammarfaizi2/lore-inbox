Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUAQBMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 20:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUAQBMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 20:12:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:6632 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265950AbUAQBMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 20:12:19 -0500
Date: Fri, 16 Jan 2004 16:57:59 -0800
From: Greg KH <greg@kroah.com>
To: zydas@tiscali.co.uk, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0 making modules problems
Message-ID: <20040117005759.GN3897@kroah.com>
References: <3FB8EA9C000A0983@mk-cpfrontend-2.mail.uk.tiscali.com> <20040102172847.GA3032@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102172847.GA3032@penguin.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 06:28:47PM +0100, Marcel Sebek wrote:
> >   CC [M]  drivers/usb/serial/whiteheat.o
> > drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
> > drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared (first use in this
> > function)
> > drivers/usb/serial/whiteheat.c:1209: (Each undeclared identifier is reported
> > only once
> > drivers/usb/serial/whiteheat.c:1209: for each function it appears in.)
> 
> diff -urN linux-2.6/drivers/usb/serial/whiteheat.c linux-2.6-new/drivers/usb/serial/whiteheat.c
> --- linux-2.6/drivers/usb/serial/whiteheat.c	2003-09-10 16:09:42.000000000 +0200
> +++ linux-2.6-new/drivers/usb/serial/whiteheat.c	2004-01-01 18:29:38.000000000 +0100
> @@ -76,6 +76,7 @@
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
>  #include <asm/uaccess.h>
> +#include <asm/termbits.h>
>  #include <linux/usb.h>
>  #include <linux/serial_reg.h>
>  #include <linux/serial.h>

I've applied this patch, thanks.

greg k-h
