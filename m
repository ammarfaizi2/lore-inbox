Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbRAJHwj>; Wed, 10 Jan 2001 02:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131512AbRAJHw3>; Wed, 10 Jan 2001 02:52:29 -0500
Received: from rasmus.uib.no ([129.177.12.30]:28323 "EHLO rasmus.uib.no")
	by vger.kernel.org with ESMTP id <S131227AbRAJHwS>;
	Wed, 10 Jan 2001 02:52:18 -0500
To: Paul Flinders <P.Flinders@ftel.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4 on MSI 694D Pro-AIR (MS-6321)
In-Reply-To: <200101081936.f08JaJj24581@old-callisto.ftel.co.uk>
From: hklygre@online.no (Håvard Lygre)
Date: 10 Jan 2001 08:52:04 +0100
In-Reply-To: Paul Flinders's message of "Mon, 8 Jan 2001 19:36:20 GMT"
Message-ID: <871yubj13v.fsf@frode.valhall.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Flinders <P.Flinders@ftel.co.uk> writes:

> Has anyone got either 2.2.x or 2.4.0 booted on the above motherboard?

I've got an MSI 694D Pro AI mainboard (ie non-raid), and both 2.2.x
and 2.4.0 work flawlessly here.  I did manage to build a 2.4.0 kernel
which didn't boot, but it got much further before it hung.  I didn't
try to find out why, just changed some settings (removing APM/ACPI,
iirc), so I'm not sure why.


> This board has an integrated Promise Fasttrack ATA/100 controller - I
> know that to support the hardware RAID I need the binary only drivers
> from Promise but I'd rather not use these if software RAID works as
> there's no source, however I'm not getting that far.

My board doesn't have RAID, but it has a Promise PDC20627
ATA/100-controller, which is properly detected (although I haven't
tried to run it at UDMA 100-speeds, I can't see why it shouldn't as
long as the controller is supported) Currently there are no disks on
the promise controller, but I've tried that, and I know it works.


> PDC20265: IDE controller on PCI bus 00 dev 60
> PDC20265: Chipset Revision 2
> PDC20265: not 100% native mode: will probe irqs later
> PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
>     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
> 
> Then it hangs requiring power cycling.
> 
> I'm not sure whether the I/O address reported by the promise driver is
> correct - the promise BIOS shows the I/O address for the first channel
> as 0xCC00.

Here is my output from 2.4.0, SMP, same section:


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
PDC20267: IDE controller on PCI bus 00 dev 60
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xac08-0xac0f, BIOS settings: hdg:pio, hdh:DMA
hda: IBM-DTLA-307030, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: IBM-DTTA-371010, ATA DISK drive
hdd: ST38641A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
hdc: 19746720 sectors (10110 MB) w/465KiB Cache, CHS=19590/16/63, UDMA(33)
hdd: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=16676/16/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 >
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [1229/255/63] p1 p2 < p5 p6 p7 p8 >
 /dev/ide/host0/bus1/target1/lun0: p1


> Is this a configuration with known problems?

Unless it's either the RAID that's causing you problems, or the maxtor
drives, I don't know what could cause this.  I'm not sure which
BIOS-version is on my card, but I haven't touched it.


-- 
Håvard Lygre, hklygre@online.no
Bergen IT-Teknikk ANS, Conrad Mohrsvei 11, 5068 Bergen
Tlf: 55 360773  Fax: 55 360774
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
