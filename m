Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSEYLXg>; Sat, 25 May 2002 07:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSEYLXf>; Sat, 25 May 2002 07:23:35 -0400
Received: from [212.176.239.134] ([212.176.239.134]:48041 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S314459AbSEYLXe>; Sat, 25 May 2002 07:23:34 -0400
Message-ID: <001a01c203de$961ad880$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
In-Reply-To: <E17BH6f-0006da-00@the-village.bc.nu>
Subject: Re: 2.4.19-pre8 ide bugs
Date: Sat, 25 May 2002 15:23:24 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17BZdt-00070Y-00*3.I46k1P7mA* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <nick@octet.spb.ru>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, May 24, 2002 7:35 PM
Subject: Re: 2.4.19-pre8 ide bugs


> > I've got the following problem with 2.4.19-pre8 &
> > ide-2.4.19-p7.all.convert.10.patch (w/o patch & I've more fatal problems
> > with sb & filesystem corruptions) kernel reports "kernel: bug: kernel
timer
> > added twice at c01a7356." & panics.
> >
> > Is it a known issue? What is the solution??? I remember that with 2.4.7
I
>
> Does this happen with the up to date IDE code (2.4.19-pre8-ac5 ?). Also
> what drives do you have ?

2.4.19-pre8-ac5 works for last 13 hours, but I still have ide related errors
in logs:
>---------------------
May 25 04:06:56 vzhik kernel: hdg: drive_cmd: status=0xd0 { Busy }
May 25 04:06:56 vzhik kernel:
May 25 04:06:56 vzhik kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
May 25 04:06:56 vzhik kernel:
May 25 04:06:56 vzhik kernel: hdg: drive not ready for command
May 25 04:06:57 vzhik kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
May 25 04:06:57 vzhik kernel:
May 25 04:06:57 vzhik kernel: hdg: drive not ready for command
>--------------------

My config is --
dual piii box (ide config follows). Also I should notice that problems that
I have occured only with  udma 100 drives attached to promise IDE controller
(I have raid0 with lvm1.1rc1 on it). And I DON'T HAVE IDE_TASKFILE option
enabled.

May 25 01:36:48 vzhik kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
May 25 01:36:48 vzhik kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
May 25 01:36:48 vzhik kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
May 25 01:36:48 vzhik kernel: VP_IDE: chipset revision 16
May 25 01:36:48 vzhik kernel: VP_IDE: not 100%% native mode: will probe irqs
later
May 25 01:36:48 vzhik kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
May 25 01:36:48 vzhik kernel: VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66
controller on pci00:07.1
May 25 01:36:48 vzhik kernel:     ide0: BM-DMA at 0x9000-0x9007, BIOS
settings: hda:pio, hdb:DMA
May 25 01:36:48 vzhik kernel:     ide1: BM-DMA at 0x9008-0x900f, BIOS
settings: hdc:pio, hdd:pio
May 25 01:36:48 vzhik kernel: PDC20265: IDE controller on PCI bus 00 dev 60
May 25 01:36:48 vzhik kernel: PDC20265: chipset revision 2
May 25 01:36:48 vzhik kernel: PDC20265: not 100%% native mode: will probe
irqs later
May 25 01:36:48 vzhik kernel: PDC20265: (U)DMA Burst Bit ENABLED Primary PCI
Mode Secondary PCI Mode.
May 25 01:36:48 vzhik kernel:     ide2: BM-DMA at 0xbc00-0xbc07, BIOS
settings: hde:DMA, hdf:pio
May 25 01:36:48 vzhik kernel:     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS
settings: hdg:DMA, hdh:pio
May 25 01:36:48 vzhik kernel: hdb: FUJITSU MPG3409AH EF, ATA DISK drive
May 25 01:36:48 vzhik kernel: hde: FUJITSU MPG3204AH, ATA DISK drive
May 25 01:36:48 vzhik kernel: hdg: FUJITSU MPG3204AH, ATA DISK drive
May 25 01:36:48 vzhik kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 25 01:36:48 vzhik kernel: ide2 at 0xac00-0xac07,0xb002 on irq 18
May 25 01:36:48 vzhik kernel: ide3 at 0xb400-0xb407,0xb802 on irq 18
May 25 01:36:48 vzhik kernel: hdb: host protected area => 1
May 25 01:36:48 vzhik kernel: hdb: 80063424 sectors (40992 MB) w/2048KiB
Cache, CHS=4983/255/63, UDMA(33)
May 25 01:36:48 vzhik kernel: hde: host protected area => 1
May 25 01:36:48 vzhik kernel: hde: 40031712 sectors (20496 MB) w/2048KiB
Cache, CHS=39714/16/63, UDMA(100)
May 25 01:36:48 vzhik kernel: hdg: host protected area => 1
May 25 01:36:48 vzhik kernel: hdg: 40031712 sectors (20496 MB) w/2048KiB
Cache, CHS=39714/16/63, UDMA(100)
May 25 01:36:48 vzhik kernel: Partition check:
May 25 01:36:48 vzhik kernel:  hdb: hdb1
May 25 01:36:48 vzhik kernel:  hde: hde1 < hde5 hde6 hde7 >
May 25 01:36:48 vzhik kernel:  hdg: hdg1 < hdg5 hdg6 >


