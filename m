Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTJBVsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTJBVsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:48:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263508AbTJBVsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:48:04 -0400
Message-ID: <3F7C9CFF.8090002@pobox.com>
Date: Thu, 02 Oct 2003 17:47:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin List-Petersen <martin@list-petersen.se>
CC: Andrew Marold <andrew.marold@wlm.edial.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: Serial ATA on Dell Dimension 8300 (Was: Re: Serial ATA support
 in	2.4.22)
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>	 <3F7AEF15.1070301@pobox.com>  <3F7B0209.7070509@pobox.com> <1065130970.5842.193.camel@loke>
In-Reply-To: <1065130970.5842.193.camel@loke>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin List-Petersen wrote:
> I simply can't figure out, whats wrong here.

The last line gives it away...


> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH5: IDE controller at PCI slot 00:1f.1
> ICH5: chipset revision 2
> ICH5: not 100% native mode: will probe irqs later
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> ICH5-SATA: IDE controller at PCI slot 00:1f.2
> ICH5-SATA: chipset revision 2
> ICH5-SATA: 100% native mode on irq 18
>     ide0: BM-DMA at 0xfea0-0xfea7, BIOS settings: hda:DMA, hdb:pio
> hda: ST3120026AS, ATA DISK drive
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
> blk: queue c041d460, I/O limit 4095Mb (mask 0xffffffff)
> hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
> hdd: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
> ide0 at 0xfe00-0xfe07,0xfe12 on irq 18
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=14589/255/63, UDMA(33)
> hdc: attached ide-cdrom driver.
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> hdd: attached ide-cdrom driver.
> hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Partition check:
>  /dev/ide/host0/bus0/target0/lun0: p1 p2

> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 08:02

You gave it an incorrect root= statement.  The IDE driver picks up 
ICH5-SATA, as you see above, so you would use root=/dev/hda1 or whatever.

	Jeff



