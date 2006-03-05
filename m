Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWCEStT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWCEStT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWCEStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:49:19 -0500
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:45246 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1750740AbWCEStS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:49:18 -0500
Message-ID: <440B32A2.1020404@free.fr>
Date: Sun, 05 Mar 2006 19:49:06 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: libata PATA patch for 2.6.16-rc5
References: <1141054370.3089.0.camel@localhost.localdomain>	 <pan.2006.02.27.20.46.14.26813@free.fr> <1141086963.3089.26.camel@localhost.localdomain>
In-Reply-To: <1141086963.3089.26.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000800080901070502030902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000800080901070502030902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alan,

Alan Cox wrote:
> On Llu, 2006-02-27 at 21:46 +0100, Matthieu CASTET wrote:
> 
>>Is there some hardware that need more testing than others ?
>>
>>I have machines with 
>> VIA + SIL680
>> PIIX + CMD648
>> PIXX
> 
> 
> Pretty sure the VIA is solid and the PIIX. SIL680 likewise now.
> 
I tried the PIIX and it seems there some problem with ATAPI.
My configuration is :
  - PM = ATA disk
  - PS = ATAPI drive
  - SM = nothing
  - SS = ATAPI drive

The problem is that pata core seems to detect and configure PS but PS 
doesn't seem present in the scsi layer.

I attach the dmesg log.
I also attach a hdparm -I of the failling drive.

Matthieu

--------------000800080901070502030902
Content-Type: text/plain;
 name="pata_cd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pata_cd"


/dev/hdb:

ATAPI CD-ROM, with removable media
	Model Number:       CD-RW  CRX100E                          
	Firmware Revision:  1.0n    
Standards:
	Likely used CD-ROM ATAPI-1
Configuration:
	DRQ response: 50us.
	Packet size: 12 bytes
Capabilities:
	LBA, IORDY(can be disabled)
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=180ns  IORDY flow control=120ns

--------------000800080901070502030902
Content-Type: text/plain;
 name="pata_log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pata_log"

Linux version 2.6.16-rc5 (root@mat-pc) (gcc version 4.1.0 20060219 (prerelease) (Debian 4.1-0exp9)) #10 PREEMPT Sun Mar 5 18:58:38 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262140
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32764 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f58a0
ACPI: RSDT (v001 ASUS   P3B_F    0x30303031 MSFT 0x31313031) @ 0x3fffc000
ACPI: FADT (v001 ASUS   P3B_F    0x30303031 MSFT 0x31313031) @ 0x3fffc080
ACPI: BOOT (v001 ASUS   P3B_F    0x30303031 MSFT 0x31313031) @ 0x3fffc040
ACPI: DSDT (v001   ASUS P3B_F    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 50000000 (gap: 40000000:bfff0000)
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro init=/bin/sh lang=fr
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01803000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 601.447 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1036496k/1048560k available (1559k kernel code, 11484k reserved, 532k data, 136k init, 131056k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1204.57 BogoMIPS (lpj=2409158)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf08b0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:04.1
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:03: ioport range 0xe400-0xe43f could not be reserved
pnp: 00:03: ioport range 0xe800-0xe80f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c6000000-c7dfffff
  PREFETCH window: c7f00000-cfffffff
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
libata version 1.20 loaded.
ata_piix 0000:00:04.1: version 1.05-ac7
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:043f
ata1: dev 0 ATA-7, max UDMA/100, 156368016 sectors: LBA48
ata1: dev 1 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata1: dev 1 ATAPI, max MWDMA2
ata1: dev 0 configured for UDMA/33
ata1: dev 1 configured for MWDMA2
scsi0 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP0802N   Rev: TK10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xD808 irq 15
ata2: dev 1 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata2: dev 1 ATAPI, max MWDMA2
ata2: dev 1 configured for MWDMA2
scsi1 : ata_piix
  Vendor: SAMSUNG   Model: DVD-ROM SD-606F   Rev: 1.2 
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 4x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:1:0: Attached scsi generic sg1 type 5
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 UAR1 UAR2 PS2K PS2M USB0 
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
kjournald starting.  Commit interval 5 seconds
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
EXT3 FS on sda1, internal journal

--------------000800080901070502030902--
