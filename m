Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVE3PMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVE3PMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVE3PMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 11:12:09 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:13889 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261629AbVE3PKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 11:10:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=kWDo4TWGnrRSqkCjQ6E3xmuPeYvsZzr7YoCgPteYdbIPBNUxirE9gCkrFI7mjifzep5FLaDAyA+ztCSuO6aWKk3zXANz42ncNlfIuz6r+zxuumnjf3a3D+DY1hVajCB0EdMCUybTl7FhbsECEytl+FoXB4yMhiEvnAebhlGsNBo=
Date: Mon, 30 May 2005 17:09:51 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050530150950.GA14351@gmail.com>
References: <20050517195650.GC9121@gmail.com> <1116363971.4989.51.camel@mulgrave> <20050521232220.GD28654@gmail.com> <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com> <1117113563.4967.17.camel@mulgrave> <20050526143516.GA9593@gmail.com> <1117118766.4967.22.camel@mulgrave> <20050526173518.GA9132@gmail.com> <1117463938.4913.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1117463938.4913.3.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 09:38:58AM -0500, James Bottomley wrote:

> OK, I have two things for you to try.
> 
> The first is the attached, which, I think, enforces the limits this
> device is expecting.  It's really just a sanity check to see if the
> problem is what I think it is (device negotiates a transfer setting it
> can't actually support).

uname -r gives me : 2.6.12-rc5 which mean it's a working fix for me !!!

Note that on the other controller the speed are quiete low ?
Do you think it's more or less safe to use this kernel so ?

Thank you very much !!!

Here's dmesg :

n information
Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/sdc2 parport=auto video=vesafb:mtrr,ywrap,1024x800-16@75 vga=0xF07 console=ttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2000.148 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x60
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1025304k/1048512k available (3138k kernel code, 22512k reserved, 1306k data, 160k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
NTFS driver 2.1.22 [Flags: R/O].
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
r8169 Gigabit Ethernet driver 2.2LK loaded
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

  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
 target0:0:15: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:15): 6.600MB/s transfers (16bit)
 target0:0:15: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:1: Beginning Domain Validation
 target1:0:1: Domain Validation skipping write tests
 target1:0:1: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:2: Beginning Domain Validation
 target1:0:2: Domain Validation skipping write tests
 target1:0:2: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:3: Beginning Domain Validation
 target1:0:3: Domain Validation skipping write tests
 target1:0:3: Ending Domain Validation
libata version 1.10 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 4
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
ehci_hcd 0000:00:10.4: port 8 reset error -110
hub 1-0:1.0: hub_port_status failed (err = -32)
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000bc00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ehci_hcd 0000:00:10.4: port 8 reset error -110
hub 1-0:1.0: hub_port_status failed (err = -32)
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
usb 1-8: new high speed USB device using ehci_hcd and address 2
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ehci_hcd 0000:00:10.4: port 8 reset error -110
hub 1-0:1.0: hub_port_status failed (err = -32)
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
hub 1-8:1.0: USB hub found
hub 1-8:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
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
usb 1-8.1: new high speed USB device using ehci_hcd and address 3
hub 1-8.1:1.0: USB hub found
hub 1-8.1:1.0: 4 ports detected
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
usb 1-8.2: new high speed USB device using ehci_hcd and address 4
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI wakeup devices: 
PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 ILAN SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
ReiserFS: sdc2: found reiserfs format "3.6" with standard journal
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
saa7146: found saa7146 @ mem ffffc200004c4e00 (revision 1, irq 17) (0x13c2,0x0000).
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
saa7146: found saa7146 @ mem ffffc200005aac00 (revision 1, irq 18) (0x13c2,0x100f).
DVB: registering new adapter (TT-Budget/WinTV-NOVA-CI PCI).
adapter has MAC addr = 00:d0:5c:23:a3:9b
DVB: registering frontend 1 (ST STV0299 DVB-S)...
r8169: eth0: link up

-- 
	Grégoire Favre
