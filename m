Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRJJTlt>; Wed, 10 Oct 2001 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277379AbRJJTlk>; Wed, 10 Oct 2001 15:41:40 -0400
Received: from mail.myrio.com ([63.109.146.2]:54773 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S277375AbRJJTl2>;
	Wed, 10 Oct 2001 15:41:28 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CA6F@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Wilson'" <defiler@null.net>, linux-kernel@vger.kernel.org
Subject: RE: ATA/100 Promise Board
Date: Wed, 10 Oct 2001 12:41:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I have two Ultra TX/2 100's in my dual P3 800, and that's
worked fine since I set it up.  Interestingly, it seems that the
first board's BIOS detects the second board and does autodetection
for all drives on both boards, and then the second board's BIOS
doesn't get run at all.  

Whatever, it works...  I did have to add the /dev/hdi and /dev/hdk 
device nodes to my (mostly) Mandrake 8.0 system though.

There are four Maxtor drives on the two Promise adaptors, working 
nicely as a raid 5 array, formatted as a single huge reiserfs.

Only one weird thing:  When I mount the reiserfs partition on
the raid, I get the following messages:

raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096

hmmm.

[thoffman@rivendell thoffman]$ uname -a
Linux rivendell.arnor.net 2.4.10-ac10 #6 SMP Wed Oct 10 06:53:07 PDT 2001
i686 unknown

[thoffman@rivendell thoffman]$ dmesg | more

...

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
PDC20268: IDE controller on PCI bus 00 dev 90
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xac08-0xac0f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 98
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide4: BM-DMA at 0xc000-0xc007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xc008-0xc00f, BIOS settings: hdk:pio, hdl:pio
hda: IBM-DTLA-307045, ATA DISK drive
hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
hde: Maxtor 4W060H4, ATA DISK drive
hdg: Maxtor 4W060H4, ATA DISK drive
hdi: Maxtor 4W060H4, ATA DISK drive
hdk: Maxtor 4W060H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9c00-0x9c07,0xa002 on irq 18
ide3 at 0xa400-0xa407,0xa802 on irq 18
ide4 at 0xb000-0xb007,0xb402 on irq 19
ide5 at 0xb800-0xb807,0xbc02 on irq 19
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63
hde: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
UDMA(100)
hdg: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
UDMA(100)
hdi: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
UDMA(100)
hdk: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
UDMA(100)

...

Torrey
