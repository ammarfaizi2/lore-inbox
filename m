Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbVLAJ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbVLAJ3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 04:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbVLAJ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 04:29:35 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:17094 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751671AbVLAJ3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 04:29:34 -0500
Message-ID: <438EC346.4000102@aitel.hist.no>
Date: Thu, 01 Dec 2005 10:32:54 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org> <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com>
In-Reply-To: <438EB150.2090502@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Helge Hafting wrote:
>
>> I tried compiling and booting rc1.  The machine is remote, and did not
>> come up.  So I don't know why it didn't come up, but it is likely
>> that it is the same problem.
>
>
> Any chance at all to get netconsole or serial console output, after 
> turning on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h ?

Tricky - no other machines around for serial.  Maybe I can look into
netconsole, and see if it'll work over an internet connection.

The first try will be turning on that debug stuff and writing down what 
happens.

The machine have the following block devices:
* floppy drive
* IDE dvd writer
* 3 SCSI disks on a scsi controller
* 2 SATA disks on the mainboard sata
* USB card reader with 4  SCSI LUNs.

Dmesg stuff from a normal 2.6.14 startup, in case it may be of help:
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Losing some ticks... checking if CPU frequency changed.
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
sym0: <895> rev 0x1 at pci 0000:00:05.0 irq 16
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
  Vendor: FUJITSU   Model: MAS3184NP         Rev: 0104
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:0: tagged command queuing enabled, command queue depth 4.
 target0:0:0: Beginning Domain Validation
 target0:0:0: asynchronous.
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
 target0:0:0: Ending Domain Validation
 target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:1: tagged command queuing enabled, command queue depth 4.
 target0:0:1: Beginning Domain Validation
 target0:0:1: asynchronous.
 target0:0:1: wide asynchronous.
 target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
 target0:0:1: Ending Domain Validation
  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:6: tagged command queuing enabled, command queue depth 4.
 target0:0:6: Beginning Domain Validation
 target0:0:6: asynchronous.
 target0:0:6: wide asynchronous.
 target0:0:6: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
 target0:0:6: Ending Domain Validation
libata version 1.12 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, 
low) -> IRQACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 
(level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
sata_via(0000:00:0f.0): routed to hard irq line 1
ata1: SATA max UDMA/133 cmd 0x9C00 ctl 0xA002 bmdma 0xAC00 irq 17
ata2: SATA max UDMA/133 cmd 0xA400 ctl 0xA802 bmdma 0xAC08 irq 17
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 
88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi1 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 
88:407f
ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi2 : sata_via
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 35890512 512-byte hdwr sectors (18376 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 35890512 512-byte hdwr sectors (18376 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi0, channel 0, id 6, lun 0
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2
Attached scsi disk sdd at scsi1, channel 0, id 0, lun 0
SCSI device sde: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sde: drive cache: write back
SCSI device sde: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sde: drive cache: write back
 sde: sde1 sde2
Attached scsi disk sde at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg4 at scsi2, channel 0, id 0, lun 0,  type 0
[...]
Initializing USB Mass Storage driver...
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
[...]
  Vendor: USB2.0    Model:       HS-CF       Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdf at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg5 at scsi3, channel 0, id 0, lun 0,  type 0
  Vendor: USB2.0    Model:       HS-MS       Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdg at scsi3, channel 0, id 0, lun 1
Attached scsi generic sg6 at scsi3, channel 0, id 0, lun 1,  type 0
  Vendor: USB2.0    Model:       HS-SM       Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdh at scsi3, channel 0, id 0, lun 2
Attached scsi generic sg7 at scsi3, channel 0, id 0, lun 2,  type 0
  Vendor: USB2.0    Model:       HS-SD/MMC   Rev: 1.64
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdi at scsi3, channel 0, id 0, lun 3
Attached scsi generic sg8 at scsi3, channel 0, id 0, lun 3,  type 0
usb-storage: device scan complete

Helge Hafting
