Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbTCIE3Y>; Sat, 8 Mar 2003 23:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbTCIE2M>; Sat, 8 Mar 2003 23:28:12 -0500
Received: from pacman.mweb.co.za ([196.2.45.77]:31723 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S262441AbTCIE0o>;
	Sat, 8 Mar 2003 23:26:44 -0500
Date: Sun, 9 Mar 2003 06:31:53 +0200
From: Martin Schlemmer <azarah@gentoo.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Some oddity with hdparm and linux-2.5.64bk3
Message-Id: <20030309063153.3a81980f.azarah@gentoo.org>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is my basic ide setup from dmesg:

---------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx PDC20268: IDE controller at PCI slot 02:0a.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
hde: ASUS CRW-2410A, ATAPI CD/DVD-ROM drive
ide2 at 0xd800-0xd807,0xd402 on irq 22
hdg: MAXTOR 6L040J2, ATA DISK drive
ide3 at 0xd000-0xd007,0xb802 on irq 22
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:pio
hda: ST320011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdg: host protected area => 1
hdg: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63,
UDMA(100) /dev/ide/host2/bus1/target0/lun0: p1
hda: host protected area => 1
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63,
UDMA(100) /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
----------------------------------------------------------

I have hda on the onboard ICH2 controllers (Asus P4T533-C with i850E
chipset), and hdg on a Promise TX100 controller.

If I run hdparm on the disks, I get:

----------------------------------------------------------
nosferatu root # hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  -1387 MB in  0.00 seconds =  -inf kB/sec
Hmm.. suspicious results: probably not enough free memory for a proper
test. nosferatu root # hdparm -t /dev/hdg

/dev/hdg:
 Timing buffered disk reads:  64 MB in  1.61 seconds = 39.63 MB/sec
nosferatu root # 
----------------------------------------------------------

For the promise, all seems ok, but for the ICH2, it does not.
It still worked with 2.5.59 last time I checked.  Any ideas ?

PS: please CC me as I am only subscribed at work.


Regards,

-- 

Martin Schlemmer

