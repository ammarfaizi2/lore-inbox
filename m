Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263523AbSJGWQN>; Mon, 7 Oct 2002 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263524AbSJGWQM>; Mon, 7 Oct 2002 18:16:12 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38667
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263523AbSJGWQL>; Mon, 7 Oct 2002 18:16:11 -0400
Subject: Re: [2.5.41] sleeping function called from illegal context at
	mm/slab.c:1374
From: Robert Love <rml@tech9.net>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007220649.GF14953@wiggy.net>
References: <20021007220649.GF14953@wiggy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 18:21:49 -0400
Message-Id: <1034029310.29467.47.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 18:06, Wichert Akkerman wrote:

> I seem to have hit a debug trigger while booting in 2.5.41. The
> calltrace suggests it is an IDE problem:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller at PCI slot 00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:pio, hdd:pio
> hda: FUJITSU MHJ2181AT, ATA DISK drive
> Debug: sleeping function called from illegal context at mm/slab.c:1374
> Call Trace:
>  [<c01138f4>] __might_sleep+0x54/0x60
>  [<c012e1d3>] kmem_cache_alloc+0x23/0xd0
>  [<c01f8b50>] blk_init_free_list+0x4c/0xd0
>  [<c0108998>] request_irq+0x8c/0xa8
>  [<c01f8be0>] blk_init_queue+0xc/0xd4
>  [<c01fd7f0>] ide_init_queue+0x28/0x68
>  [<c0203a20>] do_ide_request+0x0/0x18
>  [<c01fdaad>] init_irq+0x27d/0x334
>  [<c01fde06>] hwif_init+0x112/0x258
>  [<c01fd71c>] probe_hwif_init+0x1c/0x6c
>  [<c0209b4d>] ide_setup_pci_device+0x3d/0x68
>  [<c01fc77f>] piix_init_one+0x37/0x40
>  [<c010508b>] init+0x33/0x188
>  [<c0105058>] init+0x0/0x188
>  [<c01054a9>] kernel_thread_helper+0x5/0xc

It is known and should be fixed soon, but thanks..

	Robert Love




