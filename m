Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbTGJFKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268957AbTGJFKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:10:32 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:43194 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S268954AbTGJFKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:10:24 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Greg KH'" <greg@kroah.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: CRIS architecture update
Date: Thu, 10 Jul 2003 07:24:58 +0200
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB03277A7D@mailse01.axis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB034C5655@mailse01.axis.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, do you have any other suggestion on how to make the driver 
compilable for both >= 2.4.20 and < 2.4.20?

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Greg KH
Sent: Wednesday, July 09, 2003 10:15 PM
To: Linux Kernel Mailing List
Subject: Re: CRIS architecture update


> diff -Nru a/arch/cris/drivers/usb-host.c b/arch/cris/drivers/usb-host.c
> --- a/arch/cris/drivers/usb-host.c	Wed Jul  9 12:06:00 2003
> +++ b/arch/cris/drivers/usb-host.c	Wed Jul  9 12:06:00 2003
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION (2, 4, 20)
> +typedef struct urb urb_t, *purb_t;
> +typedef struct iso_packet_descriptor iso_packet_descriptor_t; typedef 
> +struct usb_ctrlrequest devrequest; #endif

ICK ICK ICK!  Please do not do this.  These typedefs were removed for a
reason!

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

