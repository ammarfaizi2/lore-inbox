Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279621AbRJXWSt>; Wed, 24 Oct 2001 18:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279620AbRJXWSj>; Wed, 24 Oct 2001 18:18:39 -0400
Received: from mail1.home.nl ([213.51.129.225]:15266 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S279619AbRJXWSX>;
	Wed, 24 Oct 2001 18:18:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gert-Jan Rodenburg <hertog@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Issue wit ACPI and Promise?
Date: Thu, 25 Oct 2001 00:19:13 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024221857.DGOL20704.mail1.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trembling all over, this is my first post on this list.
Up 'till no I have refrained from posting for I alway thought that any fault 
was more likely to be originated by errors on my side, then on software 
written by you guys. Therefore, please be gentle *grin*.

Now for the problem:

I have an ASUS a7v-133 mobo and get the following messages when I boot up:

<--Stuff from DMESG-->

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 9 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:pio, hdh:DMA
hda: SS07 SAMSUNG DVD-ROM SD-612S, ATAPI CD/DVD-ROM drive
hdc: MATSHITA CD-R CW-7582, ATAPI CD/DVD-ROM drive
<-- Machine locks here when using ACPI, often with a "spurious 8259A 
interrupt: IRQ7." -->

hde: IBM-DPTA-372050, ATA DISK drive
hdf: FUJITSU MPC3043AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9400-0x9407,0x9002 on irq 9
hde: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
hdf: 8448300 sectors (4326 MB), CHS=8940/15/63, UDMA(33)
Partition check:
 hde: hde1 hde2 hde3
 hdf: hdf1 hdf2 hdf3

<--End Stuff from DMESG-->

This all seems correct to me, everything works too.

But whenever I enable ACPI in the kernel things stop at the <-- Machine..... 
line. Nothing else to do but a reset.

Because it stops right when the things with the drives on the 
promise-connectors are to happen, I suspect that is the cullprit.

Any Ideas, or need for a more elaborate description of my system? I gladly 
will supply them to you all :)

Oh, also quite important:
Linux bedroom 2.4.12-ac6 #1 Wed Oct 24 06:45:12 CEST 2001 i686 unknown

Gr.

Gert-Jan Rodenburg
