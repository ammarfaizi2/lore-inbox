Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTDEJbr (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 04:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTDEJbr (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 04:31:47 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:16015 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S261967AbTDEJbq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 04:31:46 -0500
Date: Sat, 5 Apr 2003 11:43:07 +0200 (CEST)
From: kernel@ddx.a2000.nu
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: linux-kernel@vger.kernel.org, jonathan@explainerdc.com,
       adam.johansson@madsci.se, ataraid-list@redhat.com, dakota@dakotabcn.net,
       mast@lysator.liu.se, alanmiles@hfx.eastlink.ca
Subject: Re: Promise 202XX: neither IDE port enabled
In-Reply-To: <3E8E48C2.60203@gmx.net>
Message-ID: <Pine.LNX.4.53.0304051138110.31947@ddx.a2000.nu>
References: <3E8E48C2.60203@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Carl-Daniel Hailfinger wrote:

> CONFIG_PDC202XX_FORCE=y
>
> "Special FastTrak Feature"
>
> and set it to Y.

this does work :

PDC20270: IDE controller at PCI slot 03:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9040-0x9047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9048-0x904f, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x90c0-0x90c7, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x90c8-0x90cf, BIOS settings: hdk:pio, hdl:pio
PDC20267: IDE controller at PCI slot 05:06.0
PCI: Found IRQ 11 for device 05:06.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide6: BM-DMA at 0xb800-0xb807, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0xb808-0xb80f, BIOS settings: hdo:pio, hdp:pio

wasn't the 'CONFIG_PDC202XX_FORCE' to enable fasttrak support istead of
using it like an Ultra controller ?

 *  Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
 *  IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
 *  That's you can use FastTrak ATA-RAID controllers as IDE controllers.

