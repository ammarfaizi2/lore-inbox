Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135754AbRDSXev>; Thu, 19 Apr 2001 19:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135755AbRDSXel>; Thu, 19 Apr 2001 19:34:41 -0400
Received: from jalon.able.es ([212.97.163.2]:10432 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S135754AbRDSXeg>;
	Thu, 19 Apr 2001 19:34:36 -0400
Date: Fri, 20 Apr 2001 01:34:29 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ac10 ide-cd oopses on boot
Message-ID: <20010420013429.A1054@werewolf.able.es>
In-Reply-To: <20010420004914.A1052@werewolf.able.es> <E14qNWF-0008Jc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14qNWF-0008Jc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 20, 2001 at 01:07:19 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.20 Alan Cox wrote:
> > Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
> > the CD and gives the oops.
> 
> Can you back out the ide-cd changes Jens did and see if that fixes it ?
> 
>

Reverted the changes in ide-cd.[hc], and same result.

Bootlog from ac9:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
<<<<<<<<<<<< here, ac10 oopses >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
hda: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ide-floppy: hda: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac9 #1 SMP Wed Apr 18 10:35:48 CEST 2001 i686

