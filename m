Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbUKYFQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUKYFQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 00:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUKYFQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 00:16:54 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:43420 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262976AbUKYFQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 00:16:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch
Subject: Re: [PATCH 2.6] touchkitusb: module_param to swap axes
Date: Thu, 25 Nov 2004 00:10:08 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
References: <200411242228.53446.daniel.ritz@gmx.ch>
In-Reply-To: <200411242228.53446.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411250010.09049.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 November 2004 04:28 pm, Daniel Ritz wrote:
> add a module parameter to swap the axes. many displays need this...
> 
> --- 1.2/drivers/usb/input/touchkitusb.c	2004-09-18 10:07:25 +02:00
> +++ edited/drivers/usb/input/touchkitusb.c	2004-11-24 18:57:59 +01:00
> @@ -59,6 +59,10 @@
>  #define DRIVER_AUTHOR			"Daniel Ritz <daniel.ritz@gmx.ch>"
>  #define DRIVER_DESC			"eGalax TouchKit USB HID Touchscreen Driver"
>  
> +static int swap_xy;
> +module_param(swap_xy, bool, 0);

It looks it can easily be exported to userspace to allow switching "on-fly"
since it is checked for every packet. I think 0600 will do.
 
-- 
Dmitry
