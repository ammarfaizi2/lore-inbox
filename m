Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWIFPua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWIFPua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIFPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:50:30 -0400
Received: from buick.jordet.net ([193.91.240.190]:64144 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1751088AbWIFPu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:50:27 -0400
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
From: Stian Jordet <liste@jordet.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, sergio@sergiomb.no-ip.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
In-Reply-To: <44FCE36D.4000708@gentoo.org>
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>
	 <44FE8EBA.4060104@jordet.net>  <44FCE36D.4000708@gentoo.org>
Content-Type: multipart/mixed; boundary="=-vac8rhmcM1ES6tVpa46h"
Date: Wed, 06 Sep 2006 17:49:25 +0200
Message-Id: <1157557765.5091.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vac8rhmcM1ES6tVpa46h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On man, 2006-09-04 at 22:39 -0400, Daniel Drake wrote:
> Stian Jordet wrote:
> > Daniel Drake wrote:
> >> Stian Jordet: You're on CC due to a discussion linked to from above where
> >> it appeared that you needed Bjorn's patch. Please test this patch against
> >> unmodified 2.6.17 or 2.6.18-rc and let us know if there are any problems.
> >>
> > No more usb for me with this patch :P
> 
> Please send dmesg from both a working kernel and a patched kernel, and 
> /proc/interrupts from both too.

Here dmesg and /proc/interrupts with and without the patch. Both are
2.6.18-rc6...

Thanks :)

-Stian

--=-vac8rhmcM1ES6tVpa46h
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=utf-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-rc6 (root@chevrolet) (gcc version 4.1.2 20060903 (prerelease) (Ubuntu 4.1.1-13ubuntu1)) #1 SMP Wed Sep 6 17:27:24 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5500
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126972 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6930
ACPI: RSDT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CV266DLS 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 999.736 MHz processor.
Built 1 zonelists.  Total pages: 131068
Kernel command line: root=/dev/sda2 ro quiet splash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514368k/524272k available (3127k kernel code, 9368k reserved, 1180k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2001.80 BogoMIPS (lpj=4003604)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1999.59 BogoMIPS (lpj=3999183)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (4001.39 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=608
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Firmware left 0000:00:05.0 e100 interrupts enabled, disabling
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
irda_init()
NET: Registered protocol family 23
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: de800000-dfdfffff
  PREFETCH window: e0000000-f7ffffff
PCI: Bus 2, cardbus bridge: 0000:00:0f.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0f.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:0f.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Enabling device 0000:00:0f.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0f.1[B] -> GSI 19 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x3a set to 0x1
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
NTFS driver 2.1.27 [Flags: R/O].
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Pro 266 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 19 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0xde000000, irq 17, MAC addr 00:E0:18:2E:FF:C0
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
netconsole: not configured, aborting
Linux video capture interface: v2.00
saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 17
saa7134[0]: found at 0000:00:0c.0, rev: 1, irq: 17, latency: 32, mmio: 0xdc000000
saa7134[0]: subsystem: 153b:1143, board: Terratec Cinergy 600 TV [card=11,autodetected]
saa7134[0]: board init: gpio is 50000
input: saa7134 IR (Terratec Cinergy 60 as /class/input/input0
saa7134[0]: i2c eeprom 00: 3b 15 43 11 ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
tuner 0-0060: All bytes are equal. It is not a TEA5767
tuner 0-0060: chip found @ 0xc0 (saa7134[0])
tuner 0-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: ST3200822A, ATA DISK drive
hdb: ST3200822A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1
hdb: max request size: 512KiB
hdb: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
hdb: cache flushes supported
 hdb: hdb1
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 17 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:0: Ending Domain Validation
ACPI: PCI Interrupt 0000:00:07.1[B] -> GSI 18 (level, low) -> IRQ 16
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:4: Beginning Domain Validation
 target1:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target1:0:4: Domain Validation skipping write tests
 target1:0:4: Ending Domain Validation
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:5: Beginning Domain Validation
 target1:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target1:0:5: Domain Validation skipping write tests
 target1:0:5: Ending Domain Validation
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target1:0:6: Beginning Domain Validation
 target1:0:6: FAST-10 SCSI 7.8 MB/s ST (128 ns, offset 15)
 target1:0:6: Domain Validation skipping write tests
 target1:0:6: Ending Domain Validation
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 1:0:6:0: Attached scsi tape st0
st0: try direct i/o: yes (alignment 512 B)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
sda: Write Protect is off
sda: Mode Sense: a3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
sda: Write Protect is off
sda: Mode Sense: a3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:4:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
sr 1:0:5:0: Attached scsi CD-ROM sr1
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:4:0: Attached scsi generic sg1 type 5
sr 1:0:5:0: Attached scsi generic sg2 type 5
st 1:0:6:0: Attached scsi generic sg3 type 1
Yenta: CardBus bridge found at 0000:00:0f.0 [14ef:0220]
Yenta: ISA IRQ mask 0x0000, PCI irq 16
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0f.1 [14ef:0220]
Yenta: ISA IRQ mask 0x0000, PCI irq 17
Socket status: 30000006
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.2, from 9 to 11
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:11.2: irq 11, io base 0x00009800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.3, from 9 to 11
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:11.3: irq 11, io base 0x00009400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.4[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.4, from 9 to 11
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:11.4: irq 11, io base 0x00009000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x03F0 pid 0x3304
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
gameport: EMU10K1 is pci0000:00:0e.1/gameport0, io 0xa400, speed 1193kHz
input: AT Translated Set 2 keyboard as /class/input/input2
logips2pp: Detected unknown logitech mouse model 57
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/none/1.1.2.2
PPP BSD Compression module registered
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.46.2.5
HiSax: Layer2 Revision 2.30.2.4
HiSax: TeiMgr Revision 2.20.2.3
HiSax: Layer3 Revision 2.22.2.3
HiSax: LinkLayer Revision 2.59.2.4
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: Teles/PCI driver Rev. 2.23.2.3
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 19
Found: Zoran, base-address: 0xdb800000, irq: 0x13
HiSax: Teles PCI config irq:19 mem:e084e000
TelesPCI: ISAC version (0): 2086/2186 V1.1
TelesPCI: HSCX version A: V2.1  B: V2.1
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 1
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 2
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 3
HiSax: Card Teles PCI not installed !
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input3
specify port
snd_mpu401: probe of snd_mpu401.0 failed with error -22
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 18
ALSA device list:
  #0: SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xa800, irq 18
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 192 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Using IPI Shortcut mode
saa7134 ALSA driver for DMA sound loaded
saa7134[0]/alsa: saa7134[0] at 0xdc000000 irq 17 registered as card -1
Time: tsc clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
hdd: No disk in drive
hdd: No disk in drive
Adding 1052248k swap on /dev/disk/by-uuid/ff8135cc-d5e6-40b8-b9dd-fd8ab1245cac.  Priority:-1 extents:1 across:1052248k
EXT3 (no)user_xattr options not supported
EXT3 FS on sda2, internal journal
sr0: CDROM not ready.  Make sure there is a disc in the drive.
XFS mounting filesystem sda3
Starting XFS recovery on filesystem: sda3 (logdev: internal)
Ending XFS recovery on filesystem: sda3 (logdev: internal)
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
NTFS volume version 3.1.

--=-vac8rhmcM1ES6tVpa46h
Content-Disposition: attachment; filename=dmesg-patch
Content-Type: text/plain; name=dmesg-patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-rc6 (root@chevrolet) (gcc version 4.1.2 20060903 (prerelease) (Ubuntu 4.1.1-13ubuntu1)) #1 SMP Wed Sep 6 10:42:09 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5500
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126972 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6930
ACPI: RSDT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CV266DLS 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 999.736 MHz processor.
Built 1 zonelists.  Total pages: 131068
Kernel command line: root=/dev/sda2 ro quiet splash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514368k/524272k available (3127k kernel code, 9368k reserved, 1180k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2001.79 BogoMIPS (lpj=4003582)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1999.59 BogoMIPS (lpj=3999192)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (4001.38 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=607
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Firmware left 0000:00:05.0 e100 interrupts enabled, disabling
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
irda_init()
NET: Registered protocol family 23
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: de800000-dfdfffff
  PREFETCH window: e0000000-f7ffffff
PCI: Bus 2, cardbus bridge: 0000:00:0f.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0f.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:0f.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Enabling device 0000:00:0f.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0f.1[B] -> GSI 19 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x3a set to 0x1
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
NTFS driver 2.1.27 [Flags: R/O].
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Pro 266 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 19 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0xde000000, irq 17, MAC addr 00:E0:18:2E:FF:C0
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
netconsole: not configured, aborting
Linux video capture interface: v2.00
saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 17
saa7134[0]: found at 0000:00:0c.0, rev: 1, irq: 17, latency: 32, mmio: 0xdc000000
saa7134[0]: subsystem: 153b:1143, board: Terratec Cinergy 600 TV [card=11,autodetected]
saa7134[0]: board init: gpio is 50000
input: saa7134 IR (Terratec Cinergy 60 as /class/input/input0
saa7134[0]: i2c eeprom 00: 3b 15 43 11 ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
tuner 0-0060: All bytes are equal. It is not a TEA5767
tuner 0-0060: chip found @ 0xc0 (saa7134[0])
tuner 0-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
hda: ST3200822A, ATA DISK drive
hdb: ST3200822A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1
hdb: max request size: 512KiB
hdb: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(33)
hdb: cache flushes supported
 hdb: hdb1
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 17 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:0: Ending Domain Validation
ACPI: PCI Interrupt 0000:00:07.1[B] -> GSI 18 (level, low) -> IRQ 16
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:4: Beginning Domain Validation
 target1:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target1:0:4: Domain Validation skipping write tests
 target1:0:4: Ending Domain Validation
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:5: Beginning Domain Validation
 target1:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target1:0:5: Domain Validation skipping write tests
 target1:0:5: Ending Domain Validation
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target1:0:6: Beginning Domain Validation
 target1:0:6: FAST-10 SCSI 7.8 MB/s ST (128 ns, offset 15)
 target1:0:6: Domain Validation skipping write tests
 target1:0:6: Ending Domain Validation
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 1:0:6:0: Attached scsi tape st0
st0: try direct i/o: yes (alignment 512 B)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
sda: Write Protect is off
sda: Mode Sense: a3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
sda: Write Protect is off
sda: Mode Sense: a3 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:4:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
sr 1:0:5:0: Attached scsi CD-ROM sr1
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:4:0: Attached scsi generic sg1 type 5
sr 1:0:5:0: Attached scsi generic sg2 type 5
st 1:0:6:0: Attached scsi generic sg3 type 1
Yenta: CardBus bridge found at 0000:00:0f.0 [14ef:0220]
Yenta: ISA IRQ mask 0x0000, PCI irq 16
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0f.1 [14ef:0220]
Yenta: ISA IRQ mask 0x0000, PCI irq 17
Socket status: 30000006
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:11.2: irq 11, io base 0x00009800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:11.3: irq 11, io base 0x00009400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:11.4[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:11.4: irq 11, io base 0x00009000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using uhci_hcd and address 2
irq 9: nobody cared (try booting with the "irqpoll" option)
 [<c01302d3>] __report_bad_irq+0x2b/0x69
 [<c01304bd>] note_interrupt+0x1ac/0x1e3
 [<c0246175>] acpi_irq+0xb/0x14
 [<c012fadb>] handle_IRQ_event+0x23/0x49
 [<c012fbb3>] __do_IRQ+0xb2/0xe6
 [<c0104b3d>] do_IRQ+0x43/0x52
 [<c01031ea>] common_interrupt+0x1a/0x20
 [<c0101620>] default_idle+0x0/0x59
 [<c0101651>] default_idle+0x31/0x59
 [<c01016d7>] cpu_idle+0x5e/0x74
 [<c053d6d7>] start_kernel+0x353/0x35a
handlers:
[<c024616a>] (acpi_irq+0x0/0x14)
Disabling IRQ #9
usb 1-1: configuration #1 chosen from 1 choice
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x03F0 pid 0x3304
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
gameport: EMU10K1 is pci0000:00:0e.1/gameport0, io 0xa400, speed 1193kHz
input: AT Translated Set 2 keyboard as /class/input/input2
logips2pp: Detected unknown logitech mouse model 57
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/none/1.1.2.2
PPP BSD Compression module registered
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.46.2.5
HiSax: Layer2 Revision 2.30.2.4
HiSax: TeiMgr Revision 2.20.2.3
HiSax: Layer3 Revision 2.22.2.3
HiSax: LinkLayer Revision 2.59.2.4
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: Teles/PCI driver Rev. 2.23.2.3
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 19
Found: Zoran, base-address: 0xdb800000, irq: 0x13
HiSax: Teles PCI config irq:19 mem:e084e000
TelesPCI: ISAC version (0): 2086/2186 V1.1
TelesPCI: HSCX version A: V2.1  B: V2.1
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 1
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 2
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 3
HiSax: Card Teles PCI not installed !
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input3
specify port
snd_mpu401: probe of snd_mpu401.0 failed with error -22
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 18
ALSA device list:
  #0: SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xa800, irq 18
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 192 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Using IPI Shortcut mode
saa7134 ALSA driver for DMA sound loaded
saa7134[0]/alsa: saa7134[0] at 0xdc000000 irq 17 registered as card -1
Time: tsc clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
hdd: No disk in drive
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
hdd: No disk in drive
Adding 1052248k swap on /dev/disk/by-uuid/ff8135cc-d5e6-40b8-b9dd-fd8ab1245cac.  Priority:-1 extents:1 across:1052248k
EXT3 (no)user_xattr options not supported
EXT3 FS on sda2, internal journal
sr0: CDROM not ready.  Make sure there is a disc in the drive.
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
NTFS volume version 3.1.

--=-vac8rhmcM1ES6tVpa46h
Content-Disposition: attachment; filename=interrupts
Content-Type: text/plain; name=interrupts; charset=utf-8
Content-Transfer-Encoding: 7bit

           CPU0       CPU1       
  0:     131086     130647    IO-APIC-edge  timer
  1:         85        126    IO-APIC-edge  i8042
  6:          2          3    IO-APIC-edge  floppy
  8:          2          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:       5333       5326   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 12:        436        546    IO-APIC-edge  i8042
 14:         98        122    IO-APIC-edge  ide0
 15:         68         53    IO-APIC-edge  ide1
 16:      99014      99089   IO-APIC-level  aic7xxx, yenta
 17:       2999       2909   IO-APIC-level  saa7134[0], yenta, saa7134[0], eth0
 18:       8410       8398   IO-APIC-level  aic7xxx, EMU10K1
 19:      30034      30052   IO-APIC-level  radeon@pci:0000:01:00.0
NMI:          0          0 
LOC:     261668     261667 
ERR:          0
MIS:          0

--=-vac8rhmcM1ES6tVpa46h
Content-Disposition: attachment; filename=interrupts-patch
Content-Type: text/plain; name=interrupts-patch; charset=utf-8
Content-Transfer-Encoding: 7bit

           CPU0       CPU1       
  0:    2846086    2846817    IO-APIC-edge  timer
  1:         79        161    IO-APIC-edge  i8042
  6:          4          1    IO-APIC-edge  floppy
  8:          3          0    IO-APIC-edge  rtc
  9:      50001      50000   IO-APIC-level  acpi
 11:      30696      27559   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 12:        205        225    IO-APIC-edge  i8042
 14:        115        100    IO-APIC-edge  ide0
 15:         76         45    IO-APIC-edge  ide1
 16:    2202492    2202338   IO-APIC-level  aic7xxx, yenta
 17:      16948      17356   IO-APIC-level  saa7134[0], yenta, saa7134[0], eth0
 18:       8993       8888   IO-APIC-level  aic7xxx, EMU10K1
 19:     680776     681620   IO-APIC-level  radeon@pci:0000:01:00.0
NMI:          0          0 
LOC:    5692963    5692962 
ERR:          0
MIS:          0

--=-vac8rhmcM1ES6tVpa46h--

