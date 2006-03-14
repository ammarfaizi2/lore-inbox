Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWCNXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWCNXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWCNXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:37:28 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:22658 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751723AbWCNXb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:31:57 -0500
Message-ID: <4417546B.8030801@gentoo.org>
Date: Tue, 14 Mar 2006 23:40:27 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060207)
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stern@rowland.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: HP CDRW CD4E hasn't worked since 2.6.11
References: <17430.14259.90181.849542@berry.ken.nicta.com.au>	<20060314221958.GD12257@suse.de>	<44174DA0.5020105@gentoo.org> <17431.19680.579155.54647@wombat.chubb.wattle.id.au> <4417540C.8030003@gentoo.org>
In-Reply-To: <4417540C.8030003@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> --- linux/drivers/usb/storage/shuttle_usbat.c.orig	2006-03-14 23:36:57.000000000 +0000
> +++ linux/drivers/usb/storage/shuttle_usbat.c	2006-03-14 23:37:18.000000000 +0000
> @@ -855,6 +855,9 @@ static int usbat_identify_device(struct 
>  		return rc;
>  	msleep(500);
>  
> +	info->devicetype = USBAT_DEV_FLASH;
> +	return USB_STOR_TRANSPORT_GOOD;
> +
>  	/*
>  	 * In attempt to distinguish between HP CDRW's and Flash readers, we now
>  	 * execute the IDENTIFY PACKET DEVICE command. On ATA devices (i.e. flash


Oops. that was supposed to be USBAT_DEV_HP8200

Daniel
