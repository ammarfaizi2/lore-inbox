Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSFBUEx>; Sun, 2 Jun 2002 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFBUEw>; Sun, 2 Jun 2002 16:04:52 -0400
Received: from daimi.au.dk ([130.225.16.1]:4359 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S313419AbSFBUEw>;
	Sun, 2 Jun 2002 16:04:52 -0400
Message-ID: <3CFA7A61.8A8EE382@daimi.au.dk>
Date: Sun, 02 Jun 2002 22:04:49 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: IDE DMA problem in -ac kernels
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with enabling DMA on my HD in the latest
-ac kernels. I just spotted the problem in 2.4.19-pre9-ac3,
but the problem is also there in 2.4.19-pre8-ac5. However it
there are no problems in 2.4.19-pre8-ac1.

When booting -pre8-ac1 DMA is automatically enabled on hda,
and it works at the expected speed. When booting the later
kernels DMA is not enabled. When typing hdparm -d1 /dev/hda
the HD LED stays on and all access to the HD hangs.

I used the same .config for both -pre8-ac1 and -pre8-ac5.

There are no unusual messages about IDE DMA in my log.
Here are the messages printed during boot:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Assigned IRQ 11 for device 00:0f.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hdb: CREATIVEDVD-ROM DVD2240E 03/18/98, ATAPI CD/DVD-ROM drive
hdc: CR-4802TE, ATAPI CD/DVD-ROM drive
hdd: IBM-DTTA-351680, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 66055248 sectors (33820 MB) w/1916KiB Cache, CHS=4111/255/63, (U)DMA
hdd: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=32760/16/63, (U)DMA
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdd: [PTBL] [2055/255/63] hdd1 hdd2 hdd4 < hdd5 hdd6 hdd7 hdd8 >

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
