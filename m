Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129647AbRBUAAS>; Tue, 20 Feb 2001 19:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129650AbRBUAAI>; Tue, 20 Feb 2001 19:00:08 -0500
Received: from [209.53.18.145] ([209.53.18.145]:30848 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S129647AbRBTX7w>;
	Tue, 20 Feb 2001 18:59:52 -0500
Date: Tue, 20 Feb 2001 15:59:27 -0800
From: Shane Wegner <shane@cm.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Message-ID: <20010220155927.A1543@cm.nu>
In-Reply-To: <20010220134028.A5762@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010220134028.A5762@suse.cz>; from vojtech@suse.cz on Tue, Feb 20, 2001 at 01:40:28PM +0100
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 01:40:28PM +0100, Vojtech Pavlik wrote:
> Hi Andre!
> 
> You wanted my VIA driver for 2.2. Here is a patch that brings the very
> latest 4.2 driver to the 2.2 kernel. The patch is against the
> 2.2.19-pre13 kernel plus yours 1221 ide patch.
Hi,

This drivers breaks with my HP 8110 CD-R drive.  It's
sitting on primary slave of a Via 686B controler.  When I
try to do a hdparm -d1 -u1 -k1 /dev/hdb, the kernel locks
up hard.  Not even an oops.  Reverting to the old driver
works fine.

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on
pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio,
hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio,
hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA,
hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA,
hdh:pio
hdb: Hewlett-Packard CD-Writer Plus 8100, ATAPI CDROM drive
VP_IDE: Calibrating PCI clock ... 34.91 MHz
hde: Maxtor 92720U8, ATA DISK drive
hdg: Maxtor 96147U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdc00-0xdc07,0xe002 on irq 10
ide3 at 0xe400-0xe407,0xe802 on irq 10
hde: Maxtor 92720U8, 25965MB w/2048kB Cache,
CHS=52755/16/63, UDMA(66)
hdg: Maxtor 96147U8, 58623MB w/2048kB Cache,
CHS=119108/16/63, UDMA(66)

The one thing I see here which looks odd is the PCI clock
timing at 34.91 MHZ.  The CPU is not overclocked so the PCI
clock should be 33MHZ but that's probably not related.

Regards,
Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
