Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272340AbRIEWrW>; Wed, 5 Sep 2001 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272350AbRIEWrB>; Wed, 5 Sep 2001 18:47:01 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:35594 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272340AbRIEWq4>;
	Wed, 5 Sep 2001 18:46:56 -0400
Date: Wed, 5 Sep 2001 15:46:46 -0700
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: dag@brattli.net, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        bhards@bigpond.net.au, bvermeul@devel.blackstar.nl
Subject: Re: PATCH: linux-2.4.10-pre4/drivers/net/irda/irda-usb.c incorrectly matched to other USB devices
Message-ID: <20010905154646.A15893@kroah.com>
In-Reply-To: <20010904215553.A23814@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010904215553.A23814@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 09:55:53PM -0700, Adam J. Richter wrote:

> --- linux-2.4.10-pre4/drivers/net/irda/irda-usb.c	Sun Aug  5 13:12:40 2001
> +++ linux/drivers/net/irda/irda-usb.c	Tue Sep  4 21:19:43 2001
> @@ -76,7 +76,8 @@
>  	{ USB_DEVICE(0x50f, 0x180), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
>  	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
>  	{ USB_DEVICE(0x8e9, 0x100), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
> -	{ match_flags: USB_DEVICE_ID_MATCH_INT_CLASS,
> +	{ match_flags: USB_DEVICE_ID_MATCH_INT_CLASS |
> +	               USB_DEVICE_ID_MATCH_INT_SUBCLASS,
>  	  bInterfaceClass: USB_CLASS_APP_SPEC,
>  	  bInterfaceSubClass: USB_CLASS_IRDA,
>  	  driver_info: IUC_DEFAULT, },

That should be:
	{ USB_INTERFACE_INFO (USB_CLASS_APP_SPEC, USB_CLASS_IRDA, 0), driver_info: IUC_DEFAULT},

according to the IrDA USB spec.

greg k-h
	

