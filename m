Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLaRb5>; Sun, 31 Dec 2000 12:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbQLaRbr>; Sun, 31 Dec 2000 12:31:47 -0500
Received: from smtp6.libero.it ([193.70.192.127]:1238 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id <S129911AbQLaRbk>;
	Sun, 31 Dec 2000 12:31:40 -0500
From: pisuke <pisuke@libero.it>
Reply-To: pisuke@libero.it
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12 hangs during partition mapping
Date: Sun, 31 Dec 2000 18:00:17 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00123118012800.00843@bozzograo.burp>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I tried to compile kernel 2.4.0-test12 but experienced no success in booting it: 
in fact it just hangs when trying to recognize the partitions of my hde.
Here are the messages that are printed when I boot the standard Mandrake 7.1 kernel, that works
fine and recognizes well my Promise Ultra66 controller and the PTBL nature of my hde:

Linux version 2.2.15-4mdk (chmou@kenobi.mandrakesoft.com) 
(gcc version 2.95.3 19991030 (prerelease)) #1 Wed May 10 15:31:30 CEST 2000
Detected 233867424 Hz processor.
ide_setup: hdc=ide-scsi
ide_setup: ide2=0xb000,0xa800

ide_setup: ide3=0xa400,0xa000

[...]

PCI: PCI BIOS revision 2.10 entry at 0xf06d0
PCI: Using configuration type 1
PCI: Probing PCI hardware

[...]

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
PDC20262: IDE controller on PCI bus 00 dev 50
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:DMA, hdh:pio
hda: WDC AC22100H, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 8100, ATAPI CDROM drive
hde: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hde: FUJITSU MPB3064ATU, ATA DISK drive
hdf: probing with STATUS(0x00) instead of ALTSTATUS(0xff)
hdf: probing with STATUS(0x00) instead of ALTSTATUS(0xff)
hdg: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hdg: QUANTUM FIREBALLP LM15, ATA DISK drive
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0xff)
hdh: probing with STATUS(0x00) instead of ALTSTATUS(0xff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb000-0xb007,0xa800 on irq 9
ide3 at 0xa400-0xa407,0xa000 on irq 9
hda: WDC AC22100H, 2014MB w/128kB Cache, CHS=1023/64/63
hde: FUJITSU MPB3064ATU, 6187MB w/0kB Cache, CHS=13410/15/63
hdg: QUANTUM FIREBALLP LM15, 14324MB w/1900kB Cache, CHS=29104/16/63
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :   515.112 MB/sec
   p5_mmx    :   538.734 MB/sec
   8regs     :   417.957 MB/sec
   32regs    :   220.218 MB/sec
using fastest function: p5_mmx (538.734 MB/sec)
scsi : 0 hosts.
scsi : detected total.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hda: hda1 hda2 hda3
 hde: [PTBL] [788/255/63] hde1
 hdg: [PTBL] [1027/255/63] hdg1 hdg2 hdg3 < hdg5 hdg6 hdg7 > hdg4
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 72k freed

etc ...

When I select the 2.4.0-test12 kernel I just compiled (I feed it with the same
parameters about ide2 and ide3) it boots, recognizes the Promise controller 
but hangs just after:

Partition check:
 hda: hda1 hda2 hda3
 hde:

Is there any parameter I can give to the kernel or any patch I can use to boot
the new kernel?

Thank you in advance!

PS. Since I'm not subscribed to this mailing list, I would like to be personally 
CC'ed the answers/comments posted to the list in response to my posting. Thank
you! 

-- 
Francesco Anselmo
pisuke@libero.it
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
