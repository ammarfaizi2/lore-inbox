Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVFMXfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVFMXfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFMWEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:04:24 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:47733 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261493AbVFMV7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:59:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=QElut5KNNz32GWMKuJ7ENmQiNqLJPvz0WInbbKQ1Jekd2KEQr4Jb3XHtgEC4+8lMmoVNPVhk5ZA/Nr4zl4wuw/eJ0GXeaD2/i8h278FLRl7IZgxUSdT5WXKkympEEFiUn3PeR6uv5IIkci/5y5Ot86F9k+2aZCr+wH4lm0qCkX8=
Date: Mon, 13 Jun 2005 23:59:24 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050613215923.GA8629@gmail.com>
References: <20050530190716.GA9239@gmail.com> <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613213307.GA8534@gmail.com> <1118699191.5079.49.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118699191.5079.49.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:46:31PM -0500, James Bottomley wrote:

> No ... unfortunately there's a precedence bug in the u160 code ...
> 
> Try the attached (on top of everything else).

Thank you very much for the quick fix !!!

Here's the log :

iver 2.2LK loaded
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
r8169: NAPI enabled
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xffffc20000002b00, 00:0c:76:bd:22:23, IRQ 16
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC35L120AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI Floppy, ATAPI FLOPPY drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04 { AbortedCommand }
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 16X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

 target0:0:0: SC IS ffff81003fcaeac0
 target0:0:0: ULTRA2, flags 0xc3bb
 target0:0:0: scsirate IS 0x3, min_period is 10, flags 0xc3bb
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target0:0:0: asynchronous.
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
 target0:0:0: Ending Domain Validation
 target0:0:1: SC IS ffff81003fcaeac0
 target0:0:1: ULTRA2, flags 0xc1bb
 target0:0:1: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:2: SC IS ffff81003fcaeac0
 target0:0:2: ULTRA2, flags 0xc1bb
 target0:0:2: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:3: SC IS ffff81003fcaeac0
 target0:0:3: ULTRA2, flags 0xc1bb
 target0:0:3: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:4: SC IS ffff81003fcaeac0
 target0:0:4: ULTRA2, flags 0xc1bb
 target0:0:4: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:5: SC IS ffff81003fcaeac0
 target0:0:5: ULTRA2, flags 0xc1bb
 target0:0:5: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:6: SC IS ffff81003fcaeac0
 target0:0:6: ULTRA2, flags 0xc1bb
 target0:0:6: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:8: SC IS ffff81003fcaeac0
 target0:0:8: ULTRA2, flags 0xc1bb
 target0:0:8: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:9: SC IS ffff81003fcaeac0
 target0:0:9: ULTRA2, flags 0xc1bb
 target0:0:9: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:10: SC IS ffff81003fcaeac0
 target0:0:10: ULTRA2, flags 0xc1bb
 target0:0:10: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:11: SC IS ffff81003fcaeac0
 target0:0:11: ULTRA2, flags 0xc1bb
 target0:0:11: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:12: SC IS ffff81003fcaeac0
 target0:0:12: ULTRA2, flags 0xc1bb
 target0:0:12: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:13: SC IS ffff81003fcaeac0
 target0:0:13: ULTRA2, flags 0xc1bb
 target0:0:13: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:14: SC IS ffff81003fcaeac0
 target0:0:14: ULTRA2, flags 0xc1bb
 target0:0:14: scsirate IS 0x3, min_period is 10, flags 0xc1bb
 target0:0:15: SC IS ffff81003fcaeac0
 target0:0:15: ULTRA2, flags 0xc1bb
 target0:0:15: scsirate IS 0x3, min_period is 10, flags 0xc1bb
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:15: asynchronous.
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
 target0:0:15: Beginning Domain Validation
 target0:0:15: wide asynchronous.
 target0:0:15: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 63)
 target0:0:15: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

 target1:0:0: SC IS ffff81003fcae980
 target1:0:0: scsirate IS 0x0, min_period is 25, flags 0xc318
 target1:0:1: SC IS ffff81003fcae980
 target1:0:1: scsirate IS 0x0, min_period is 25, flags 0xc318
 target1:0:1: asynchronous.
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:1: Beginning Domain Validation
 target1:0:1: Domain Validation skipping write tests
 target1:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target1:0:1: Ending Domain Validation
 target1:0:2: SC IS ffff81003fcae980
 target1:0:2: scsirate IS 0x0, min_period is 25, flags 0xc318
 target1:0:2: asynchronous.
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:2: Beginning Domain Validation
 target1:0:2: Domain Validation skipping write tests
 target1:0:2: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
 target1:0:2: Ending Domain Validation
 target1:0:3: SC IS ffff81003fcae980
 target1:0:3: scsirate IS 0x0, min_period is 25, flags 0xc318
 target1:0:3: asynchronous.
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:3: Beginning Domain Validation
 target1:0:3: Domain Validation skipping write tests
 target1:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
 target1:0:3: Ending Domain Validation
 target1:0:4: SC IS ffff81003fcae980
 target1:0:4: scsirate IS 0x0, min_period is 25, flags 0xc318
 target1:0:5: SC IS ffff81003fcae980
 target1:0:5: scsirate IS 0x0, min_period is 25, flags 0xc318
 target1:0:6: SC IS ffff81003fcae980
 target1:0:6: scsirate IS 0x0, min_period is 25, flags 0xc318
libata version 1.11 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD000 irq 20
ata2: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xD008 irq 20
ata1: no device found (phy stat 00000000)
scsi2 : sata_via
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi3 : sata_via
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 15, lun 0
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 2, lun 0
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 15, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg4 at scsi1, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg5 at scsi3, channel 0, id 0, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xcfffe900
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000bc00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
usb 1-8: new high speed USB device using ehci_hcd and address 2
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
hub 1-8:1.0: USB hub found
hub 1-8:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
logips2pp: Detected unknown logitech mouse model 99
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
ALSA device list:
  #0: VIA 8237 with ALC655 at 0xb800, irq 22
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI wakeup devices: 
PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 ILAN SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
ReiserFS: sdc2: found reiserfs format "3.6" with standard journal
usb 1-8.1: new high speed USB device using ehci_hcd and address 3
hub 1-8.1:1.0: USB hub found
hub 1-8.1:1.0: 4 ports detected
usb 1-8.2: new high speed USB device using ehci_hcd and address 4
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
  Vendor: SMSC      Model: 223 U HS-CF       Rev: 3.60
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdd at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg6 at scsi4, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
ReiserFS: sdc2: using ordered data mode
ReiserFS: sdc2: journal params: device sdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdc2: checking transaction log (sdc2)
ReiserFS: sdc2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 506036k swap on /dev/hda2.  Priority:2 extents:1
Adding 530136k swap on /dev/sda2.  Priority:2 extents:1
Adding 530104k swap on /dev/sdb1.  Priority:1 extents:1
Adding 1004020k swap on /dev/sdc1.  Priority:3 extents:1
Linux agpgart interface v0.101 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7664  Wed May 25 22:14:12 PDT 2005
XFS mounting filesystem sdb2
Ending clean XFS mount for filesystem: sdb2
XFS mounting filesystem hda4
Ending clean XFS mount for filesystem: hda4
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
saa7146: register extension 'dvb'.
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 17
saa7146: found saa7146 @ mem ffffc20000506e00 (revision 1, irq 17) (0x13c2,0x0000).
DVB: registering new adapter (Technotrend/Hauppauge WinTV DVB-S rev1.X).
adapter has MAC addr = 00:d0:5c:00:41:90
dvb-ttpci: gpioirq unknown type=0 len=0
dvb-ttpci: info @ card 0: firm f0240009, rtsl b0250018, vid 71010068, app 8000261d
dvb-ttpci: firmware @ card 0 supports CI link layer interface
dvb-ttpci: adac type set to 0 @ card 0
saa7146_vv: saa7146 (0): registered device video0 [v4l2]
ves1x93: Detected ves1893a rev2
DVB: registering frontend 0 (VLSI VES1x93 DVB-S)...
dvb-ttpci: found av7110-0.
saa7146: register extension 'budget dvb'.
saa7146: register extension 'budget_ci dvb'.
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
saa7146: found saa7146 @ mem ffffc200005ecc00 (revision 1, irq 18) (0x13c2,0x100f).
DVB: registering new adapter (TT-Budget/WinTV-NOVA-CI PCI).
adapter has MAC addr = 00:d0:5c:23:a3:9b
DVB: registering frontend 1 (ST STV0299 DVB-S)...
r8169: eth0: link up
-- 
	Gr\'egoire Favre
