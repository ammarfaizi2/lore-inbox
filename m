Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286206AbRLJIiG>; Mon, 10 Dec 2001 03:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286200AbRLJIhw>; Mon, 10 Dec 2001 03:37:52 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:2947 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S286199AbRLJIhl>; Mon, 10 Dec 2001 03:37:41 -0500
Message-ID: <016b01c18155$fdacad40$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Adam C Powell IV" <hazelsct@mit.edu>,
        "Kernel Developers" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C13B0BC.4060002@mit.edu>
Subject: Re: 2.4.14-16: Can't see hdb or hdc on ABIT BP6
Date: Mon, 10 Dec 2001 09:38:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Adam C Powell IV" <hazelsct@mit.edu>
To: "Kernel Developers" <linux-kernel@vger.kernel.org>
Sent: Sunday, December 09, 2001 7:43 PM
Subject: 2.4.14-16: Can't see hdb or hdc on ABIT BP6


> Greetings,
>
> First, please CC me in replies, as I'm not subscribed...
>
> I have an ABIT BP6 dual-Celeron system, with six IDE drives, four on the
> PIIX4 controller and two on the HPT366.  For some reason, Debian
> kernel-image-2.4.14-686-smp and 2.4.16 can never see anything on hdb or
> hdc, but have no trouble at all with hda, hdd, hdf or hdg.  It's as if I
> removed those two drives.  The corresponding Debian 2.4.9 kernel package
> always works perfectly, as does 2.2.19 and various other 2.2 and 2.4
> kernels leading up to those.
>
> I originally thought it was an ext2 problem because fsck couldn't mount
> hdb1 or hdc1, and that's where the boot process would stop.  The Debian
> slink install made hda1 (root) without sparse superblocks, and hdb1
> (/usr) and hdc1 (/var) with sparse superblocks, making that the
> suspect.  But then tune2fs wasn't finding the partitions either, and
> raidstart was finding hda3 and hdd1 but not hdb3 or hdc3 (which are 10
> GB each making up a 30 GB RAID5 array), and also could find hda2 but not
> hdb2 or hdc2 (for a RAID0 array).  It was finding hdf1 and hdg1 just
> fine for another RAID0 array.
>
> So it's as if hdb and hdc are not there!
>
> For more info on those drives, I've attached the relevant boot log
> portion from /var/log/messages under 2.4.9.  Since the missing drives
> are identical to hda, which works just fine, I'm mystified...
>
> I would much appreciate any insights/solutions, and am happy to provide
> additional information toward that end.

Would be interesting with a "hdparm -I /dev/hdX" for every drive attached.

Anyway, I recommend you to patch your kernel with the ATA/ATAPI patches,
(not?) available at www.linuxdiskcert.org

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


>


----------------------------------------------------------------------------
----


> Dec  7 12:39:24 lyre kernel: VFS: Mounted root (cramfs filesystem).
> Dec  7 12:39:24 lyre kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
> Dec  7 12:39:24 lyre kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
> Dec  7 12:39:24 lyre kernel: PIIX4: IDE controller on PCI bus 00 dev 39
> Dec  7 12:39:24 lyre kernel: PIIX4: chipset revision 1
> Dec  7 12:39:24 lyre kernel: PIIX4: not 100%% native mode: will probe irqs
later
> Dec  7 12:39:24 lyre kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:DMA
> Dec  7 12:39:24 lyre kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:DMA
> Dec  7 12:39:24 lyre kernel: HPT366: onboard version of chipset, pin1=1
pin2=2
> Dec  7 12:39:24 lyre kernel: HPT366: IDE controller on PCI bus 00 dev 98
> Dec  7 12:39:24 lyre kernel: PCI: Enabling device 00:13.0 (0005 -> 0007)
> Dec  7 12:39:24 lyre kernel: HPT366: chipset revision 1
> Dec  7 12:39:24 lyre kernel: HPT366: not 100%% native mode: will probe
irqs later
> Dec  7 12:39:24 lyre kernel:     ide2: BM-DMA at 0xbc00-0xbc07, BIOS
settings: hde:pio, hdf:DMA
> Dec  7 12:39:24 lyre kernel: HPT366: IDE controller on PCI bus 00 dev 99
> Dec  7 12:39:24 lyre kernel: HPT366: chipset revision 1
> Dec  7 12:39:24 lyre kernel: HPT366: not 100%% native mode: will probe
irqs later
> Dec  7 12:39:24 lyre kernel:     ide3: BM-DMA at 0xc800-0xc807, BIOS
settings: hdg:DMA, hdh:pio
> Dec  7 12:39:24 lyre kernel: hda: Maxtor 91728D8, ATA DISK drive
> Dec  7 12:39:24 lyre kernel: hdb: Maxtor 91728D8, ATA DISK drive
> Dec  7 12:39:24 lyre kernel: hdc: Maxtor 91728D8, ATA DISK drive
> Dec  7 12:39:24 lyre kernel: hdd: WDC WD102AA, ATA DISK drive
> Dec  7 12:39:24 lyre kernel: hdf: QUANTUM FIREBALLP AS40, ATA DISK drive
> Dec  7 12:39:24 lyre kernel: hdg: QUANTUM FIREBALLP AS40, ATA DISK drive
> Dec  7 12:39:24 lyre kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Dec  7 12:39:24 lyre kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Dec  7 12:39:24 lyre kernel: ide2 at 0xb400-0xb407,0xb802 on irq 11
> Dec  7 12:39:24 lyre kernel: ide3 at 0xc000-0xc007,0xc402 on irq 11
> Dec  7 12:39:24 lyre kernel: hda: 33750864 sectors (17280 MB) w/512KiB
Cache, CHS=33483/16/63
> Dec  7 12:39:24 lyre kernel: hdb: 33750864 sectors (17280 MB) w/512KiB
Cache, CHS=33483/16/63
> Dec  7 12:39:24 lyre kernel: hdc: 33750864 sectors (17280 MB) w/512KiB
Cache, CHS=33483/16/63
> Dec  7 12:39:24 lyre kernel: hdd: 20044080 sectors (10263 MB) w/2048KiB
Cache, CHS=19885/16/63
> Dec  7 12:39:24 lyre kernel: hdf: 78198750 sectors (40038 MB) w/1902KiB
Cache, CHS=77578/16/63, UDMA(33)
> Dec  7 12:39:24 lyre kernel: hdg: 78198750 sectors (40038 MB) w/1902KiB
Cache, CHS=77578/16/63, UDMA(33)
> Dec  7 12:39:24 lyre kernel: Partition check:
> Dec  7 12:39:24 lyre kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> Dec  7 12:39:24 lyre kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 p3
> Dec  7 12:39:24 lyre kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3
> Dec  7 12:39:24 lyre kernel:  /dev/ide/host0/bus1/target1/lun0: p1
> Dec  7 12:39:24 lyre kernel:  /dev/ide/host2/bus0/target1/lun0: p1
> Dec  7 12:39:24 lyre kernel:  /dev/ide/host3/bus0/target0/lun0: p1
> Dec  7 12:39:24 lyre kernel: VFS: Mounted root (ext2 filesystem) readonly.
>

