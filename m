Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268153AbTAKVtc>; Sat, 11 Jan 2003 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268154AbTAKVtc>; Sat, 11 Jan 2003 16:49:32 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13331
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S268153AbTAKVtb>; Sat, 11 Jan 2003 16:49:31 -0500
Date: Sat, 11 Jan 2003 13:42:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] update help for hpt366.c
In-Reply-To: <20030111200426.GD21826@fs.tum.de>
Message-ID: <Pine.LNX.4.10.10301111335480.11839-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Caution!

I and Andrew Morton have hpt374's which do not behave will under U133.
It could be a device - controller combination erratium but not sure

Cheers,

On Sat, 11 Jan 2003, Adrian Bunk wrote:

> Hi Marcelo, hi Alan,
> 
> the trivial patch below updates the information about the chipsets 
> supported by hpt366.c.
> 
> Please apply
> Adrian
> 
> --- linux-2.4.20/drivers/ide/Config.in.old	2003-01-11 20:58:01.000000000 +0100
> +++ linux-2.4.20/drivers/ide/Config.in	2003-01-11 20:59:20.000000000 +0100
> @@ -56,7 +56,7 @@
>  	    dep_tristate '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
>    	    dep_tristate '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    dep_mbool    '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
> -	    dep_tristate '    HPT366/368/370 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
> +	    dep_tristate '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    dep_tristate '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
>  	       dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
> --- linux-2.4.20/Documentation/Configure.help.old	2003-01-11 20:59:56.000000000 +0100
> +++ linux-2.4.20/Documentation/Configure.help	2003-01-11 21:00:54.000000000 +0100
> @@ -1161,11 +1161,13 @@
>  
>    If unsure, say N.
>  
> -HPT366/368/370 chipset support
> +HPT36X/37X chipset support
>  CONFIG_BLK_DEV_HPT366
>    HPT366 is an Ultra DMA chipset for ATA-66.
>    HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.
>    HPT370 is an Ultra DMA chipset for ATA-100.
> +  HPT372 is an Ultra DMA chipset for ATA-133.
> +  HPT374 is an Ultra DMA chipset for ATA-133.
>  
>    This driver adds up to 4 more EIDE devices sharing a single
>    interrupt.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

