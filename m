Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbTDDXwV (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbTDDXwV (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:52:21 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:36680 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261469AbTDDXwT (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 18:52:19 -0500
Message-ID: <027a01c2fb06$d62798d0$2e77c23e@pentium4>
From: "Jonathan Vardy" <jonathanv@explainerdc.com>
To: <linux-kernel@vger.kernel.org>
References: <73300040777B0F44B8CE29C87A0782E101FA9875@exchange.explainerdc.com>
Subject: Re: Promise TX4 100: neither IDE port enabled
Date: Sat, 5 Apr 2003 02:03:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After many different kernels, here are my experiences so far:

The original red hat 9.0 2.4.20 kernel correctly identifies the drives on
the promise as UDMA(100).

The 2.4.21-pre7, 2.4.21-pre6, 2.4.21-pre5-ac3 do not detect the promise
correctly giving the following error:

ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20270: IDE controller at PCI slot 02:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
PDC20270: neither IDE port enabled (BIOS)
PDC20270: neither IDE port enabled (BIOS)

We compiled a version of 2.4.20 without modules but then it would detect all
the drives on the promise as UDMA(33)

Does anybody have know if the problem is in the kernel version or settings?

Yours sincerely, Jonathan Vardy

>I've rebooted using the orignal Red Hat kernel (2.4.20) and it
>recongnizes the Promise card. Here are the details:
>
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>PIIX4: IDE controller at PCI slot 00:04.1
>PIIX4: chipset revision 1
>PIIX4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
>PDC20270: IDE controller at PCI slot 02:01.0
>PDC20270: chipset revision 2
>PDC20270: not 100% native mode: will probe irqs later
>    ide2: BM-DMA at 0x9040-0x9047, BIOS settings: hde:pio, hdf:pio
>    ide3: BM-DMA at 0x9048-0x904f, BIOS settings: hdg:pio, hdh:pio
>   ide4: BM-DMA at 0x90c0-0x90c7, BIOS settings: hdi:pio, hdj:pio
>    ide5: BM-DMA at 0x90c8-0x90cf, BIOS settings: hdk:pio, hdl:pio
>hda: Maxtor 2B020H1, ATA DISK drive
>blk: queue c0453420, I/O limit 4095Mb (mask 0xffffffff)
>hdc: WDC WD1200BB-00CAA1, ATA DISK drive
>blk: queue c04538a0, I/O limit 4095Mb (mask 0xffffffff)
>hde: WDC WD1200BB-60CJA1, ATA DISK drive
>blk: queue c0453d20, I/O limit 4095Mb (mask 0xffffffff)
>hdg: WDC WD1200BB-60CJA1, ATA DISK drive
>blk: queue c04541a0, I/O limit 4095Mb (mask 0xffffffff)
>hdi: WDC WD1200BB-60CJA1, ATA DISK drive
>blk: queue c0454620, I/O limit 4095Mb (mask 0xffffffff)
>hdk: WDC WD1200BB-60CJA1, ATA DISK drive
>blk: queue c0454aa0, I/O limit 4095Mb (mask 0xffffffff)
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
>ide2 at 0x9000-0x9007,0x9012 on irq 19
>ide3 at 0x9020-0x9027,0x9032 on irq 19
>ide4 at 0x9080-0x9087,0x9092 on irq 19
i>de5 at 0x90a0-0x90a7,0x90b2 on irq 19
>hda: host protected area => 1
>hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63,
>UDMA(33)
>hdc: host protected area => 1
>hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
>UDMA(33)
>hde: host protected area => 1
>hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
>UDMA(100)
>hdg: host protected area => 1
>hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
>UDMA(100)
>hdi: host protected area => 1
>hdi: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
>UDMA(100)
>hdk: host protected area => 1
>hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
>UDMA(100)



