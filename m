Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315583AbSECHSV>; Fri, 3 May 2002 03:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315585AbSECHSU>; Fri, 3 May 2002 03:18:20 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:11272
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S315583AbSECHSS> convert rfc822-to-8bit; Fri, 3 May 2002 03:18:18 -0400
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
	reading damadged files
From: Xavier Bestel <xavier.bestel@free.fr>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Stephen Samuel <samuel@bcgreen.com>, Bill Davidsen <davidsen@tmr.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020502154816.GV574@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.4.99 
Date: 03 May 2002 09:14:07 +0200
Message-Id: <1020410055.19932.26.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 02/05/2002 à 17:48, Mike Fedyk a écrit :
> > The "system grinding to a halt" happens to me too, when *ripping*
> > scratched cds. Note that it's when using *userspace* access to the block
> > device, with e.g. cdparanoia or grip (or dvd ripping tools).
> > 
> > My DVD drive is on a VT82C693A/694x (ABit VP6).
> 
> Ahh, that's a good distinction to make.  I'll be testing CD ripping on this
> machine eventually too.
> 
> Are you burning CDs at the same time as ripping?  If so, try doing that in a
> two step process and see where the problem occours.

Well, I tried once and lost the CDR ...

> Can you post the full output of lspci?  Be sure to mention what drives are
> on which controller (if you have two or more).
> 
> Can you post the kernel output from dmesg when it detects your drives?
> 
> Do you have any ISA devices in this system?

A sound card and the legacy motherboard devices.

> Can you post the commands it takes to reproduce the condition?

Well, I use Grip (a gtk+ ripping proggy) in cdparanoia mode. Basically
it's like cdparanoia + gui.

> Also, `vmstat 1` output while the system is unresponsive would be good too.

I'll post that when I'll do it again with a scratched CD. For now I need
my machine to be responsive.

Cheers,
	Xav
 


00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: ABIT Computer Corp.: Unknown device a204
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: dd000000-deffffff
	Prefetchable memory behind bridge: d4000000-d7ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a400 [size=32]
	Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a800 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Flags: medium devsel, IRQ 11
	Capabilities: [68] Power Management version 2

00:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Subsystem: Ads Technologies Inc: Unknown device 0000
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at df004000 (32-bit, non-prefetchable) [size=2K]
	Memory at df000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at ac00 [size=256]
	Memory at df005000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Flags: medium devsel, IRQ 10
	Memory at d8000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Flags: bus master, slow devsel, latency 32, IRQ 11
	I/O ports at b000 [size=64]
	Capabilities: [dc] Power Management version 2

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 11
	I/O ports at b400 [size=8]
	I/O ports at b800 [size=4]
	I/O ports at bc00 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at c400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0028
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 9
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	I/O ports at 9000 [size=256]
	Memory at de000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2




Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hdb: C/H/S=0/0/0 from BIOS ignored
hda: WDC WD400BB-32BSA0, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
hde: ST340824A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb400-0xb407,0xb802 on irq 11
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=38166/64/32, UDMA(100)
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
Partition check:
 hda: [PTBL] [5169/240/63] hda1 < hda5 hda6 hda7 >
 hdb:<3>ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 2
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 4
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 6
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 2
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 4
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table
 hde: hde1 hde2

[ That's Ok, it's the Zip drive ]

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 23.D
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: HITACHI   Model: DVD-ROM GD-7500   Rev: 0005
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: LG        Model: CD-RW CED-8080B   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 28 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 14x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray


