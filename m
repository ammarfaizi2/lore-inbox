Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTDEK4H (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 05:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTDEK4H (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 05:56:07 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3088 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262005AbTDEK4G (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 05:56:06 -0500
Date: Sat, 5 Apr 2003 03:02:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: kernel@ddx.a2000.nu
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       linux-kernel@vger.kernel.org, jonathan@explainerdc.com,
       adam.johansson@madsci.se, ataraid-list@redhat.com, dakota@dakotabcn.net,
       mast@lysator.liu.se, alanmiles@hfx.eastlink.ca
Subject: Re: Promise 202XX: neither IDE port enabled
In-Reply-To: <Pine.LNX.4.53.0304051138110.31947@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.10.10304050258120.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is designed to allow you to overide a FastTrack BIOS that disables a
few items in pci-config space.  Regardless if you have a FastTrack or
Ultra, if enabled the device can be registered.  If you have a FastTrack
and want to use ata-raid by Arjan V. and not the OEM scsi binary driver,
you must enable the override.  If you want to use the OEM scsi binary
driver with FastTrack, do not set the override.  Ultra's do not care.
If they do it is a BUG!

Cheers,

On Sat, 5 Apr 2003 kernel@ddx.a2000.nu wrote:

> On Sat, 5 Apr 2003, Carl-Daniel Hailfinger wrote:
> 
> > CONFIG_PDC202XX_FORCE=y
> >
> > "Special FastTrak Feature"
> >
> > and set it to Y.
> 
> this does work :
> 
> PDC20270: IDE controller at PCI slot 03:01.0
> PDC20270: chipset revision 2
> PDC20270: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0x9040-0x9047, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x9048-0x904f, BIOS settings: hdg:pio, hdh:pio
>     ide4: BM-DMA at 0x90c0-0x90c7, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0x90c8-0x90cf, BIOS settings: hdk:pio, hdl:pio
> PDC20267: IDE controller at PCI slot 05:06.0
> PCI: Found IRQ 11 for device 05:06.0
> PDC20267: chipset revision 2
> PDC20267: not 100% native mode: will probe irqs later
> PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> Mode.
>     ide6: BM-DMA at 0xb800-0xb807, BIOS settings: hdm:pio, hdn:pio
>     ide7: BM-DMA at 0xb808-0xb80f, BIOS settings: hdo:pio, hdp:pio
> 
> wasn't the 'CONFIG_PDC202XX_FORCE' to enable fasttrak support istead of
> using it like an Ultra controller ?
> 
>  *  Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
>  *  IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
>  *  That's you can use FastTrak ATA-RAID controllers as IDE controllers.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

