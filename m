Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSLGVSf>; Sat, 7 Dec 2002 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSLGVSf>; Sat, 7 Dec 2002 16:18:35 -0500
Received: from ida.xs4all.nl ([213.84.39.78]:6193 "EHLO ida.dejong.info")
	by vger.kernel.org with ESMTP id <S264766AbSLGVSd>;
	Sat, 7 Dec 2002 16:18:33 -0500
Message-ID: <3DF26772.8040502@dejong.info>
Date: Sat, 07 Dec 2002 22:26:10 +0100
From: jorg de jong <jorg@dejong.info>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: status of HPT374 support in 2.4.20 and 2.5.50 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just bought a Highpoint Rocketraid 404 controler. To my suppirce I 
found that
the kernel I was using does not like it one bit. The kernel entered a 
kernel panic/BUG
in file hpt666.c:1031. The kernel was a Redhat stock kernel 
2.4.18-18.8.0smp.

Not afraid to build my own kernel I tried:
- 2.4.20; which also stoped with a kernel panic.
- 2.4.20-ac1; this kernel boots just fine. It even sees the controller 
but does not detect
the drive.
- 2.5.46; sees the controler but no drive
- 2.5.50; sees the controler but no drive

Google told me that there are successes with the HPT374 contoller(kernel 
2.5.46),
but thus far not for me.

Some info about by system:
motherboard: msi k7d; dual amd athlon mp 2000+
onboard ide controller: AMD7441
other pci ide controller: PDC20267

Please help,

regards,

Jorg de Jong


part of dmesg (2.4.20-ac1):

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:DMA
HPT374: IDE controller at PCI slot 00:09.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
PDC20267: IDE controller at PCI slot 02:05.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:DMA, hdh:DMA
hda: ST340823A, ATA DISK drive
blk: queue c0399fa0, I/O limit 4095Mb (mask 0xffffffff)
hdc: LITE-ON LTR-48125S, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hde: ST360021A, ATA DISK drive
blk: queue c039a878, I/O limit 4095Mb (mask 0xffffffff)
hdg: ST360021A, ATA DISK drive
hdh: ST360021A, ATA DISK drive
blk: queue c039ace4, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c039ae30, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x8000-0x8007,0x8402 on irq 17
ide3 at 0x8800-0x8807,0x8c02 on irq 17
hda: 78165360 sectors (40021 MB) w/1024KiB Cache, CHS=4865/255/63, UDMA(100)
hde: host protected area => 1
hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, 
UDMA(100)
hdg: host protected area => 1
hdg: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, 
UDMA(100)
hdh: host protected area => 1
hdh: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, 
UDMA(100)







 


