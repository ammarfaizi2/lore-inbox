Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTEaQKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTEaQKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:10:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:4562 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264403AbTEaQKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:10:09 -0400
Message-ID: <3ED8D709.9060807@gmx.net>
Date: Sat, 31 May 2003 18:23:37 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: reid@reidspencer.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Any experience with Promise PDC20376 and SATA RAID?
References: <20030528160001.21400.75235.Mailman@listman.rdu-colo.redhat.com> <1054139205.1257.11.camel@bashful.x10sys.com>
In-Reply-To: <1054139205.1257.11.camel@bashful.x10sys.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reid Spencer wrote:
> I think the kernel doesn't know about the device number (105a:3376 =
> PDC20376) since it isn't in the kernel's drivers/pci/pci.ids file
> (latest device is 7275 PDC20277)and it doesn't recognize the device when
> it processes the IDE devices at boot up. All I get is:
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller at PCI slot 00:11.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
>     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
> hda: WDC WD400AB-32BVA0, ATA DISK drive
> blk: queue c03c58e0, I/O limit 4095Mb (mask 0xffffffff)
> hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
> UDMA(100)
> ide-floppy driver 0.99.newide
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
> ide-floppy driver 0.99.newide
> 
> Note that ide2 isn't found even though I specifically gave the ports for
> it on the "append line" of the boot.  I don't know enough about the
> IDE/PDC support to be able to add support for this new PDC20376 chip.
> 
> Anyone out there done this?
> 
> Reid.
> 

