Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTILKtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 06:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTILKtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 06:49:21 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:54166 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261408AbTILKtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 06:49:19 -0400
Subject: Re: [OOPS] 2.4.22 / HPT372N
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ronny Buchmann <ronny-lkml@vlugnet.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marko Kreen <marko@l-t.ee>
In-Reply-To: <200309121141.45776.ronny-lkml@vlugnet.org>
References: <200309091406.56334.ronny-lkml@vlugnet.org>
	 <20030911123418.GA6798@l-t.ee>  <200309121141.45776.ronny-lkml@vlugnet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 11:48:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 10:41, Ronny Buchmann wrote:
> I will test with cdrom attached later today.
> Currently I have one disk on each channel.
> 
> I had another look at hpt.c(from highpoint) and hpt366.c and found this:
> --- linux-2.4.22-ac1/drivers/ide/pci/hpt366.c.orig	2003-09-11 
> 21:29:06.000000000 +0200
> +++ linux-2.4.22-ac1/drivers/ide/pci/hpt366.c	2003-09-12 01:05:44.000000000 
> +0200
> @@ -713,7 +713,7 @@
>  	
>  	/* Reconnect channels to bus */
>  	outb(0x00, hwif->dma_base+0x73);
> -	outb(0x00, hwif->dma_base+0x79);
> +	outb(0x00, hwif->dma_base+0x77);
>  }

Which piece of documentation makes you think that ? So I can double
check it.

>  
> -	d->channels = 1;
> +	d->channels = 2;

Need to work out which 372N and others are dual channel but yes

