Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTEAQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTEAQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:04:57 -0400
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:63818 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id S261392AbTEAQEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:04:47 -0400
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org
Subject: pcmcia-ide hang with 2.4.21-rc1
Date: Thu, 1 May 2003 17:21:05 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xlUs+XmT9qi6emq"
Message-Id: <200305011821.05140.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xlUs+XmT9qi6emq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I get a hang as soon as I insert a pcmcia-cd-rom drive into my 
vaio picturebook (ALi/Transmeta). 
The box is just dead, after some seconds. 100% reproducible.
No sysrq works, nothing in the logs. 

pcmcia-cs from the kernel, user space tools from David Hinds, 
version 3.2.4 (February 26)

2.4.20 is OK
2.4.21-pre1 and later hang, also -rc1
2.5.68 is OK

I attach "dmesg" from working 2.4.20 and "lspci -vv".

thank you,
Michael

  



--Boundary-00=_xlUs+XmT9qi6emq
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.4.20 (root@karpfen2) (gcc version 2.95.3 20010315 (SuSE)) #2 Sun Mar 9 02:46:37 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
 BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Sony Vaio laptop detected.
Kernel command line: BOOT_IMAGE=linux2420 ro root=303 BOOT_FILE=/boot/vmlinuz-2.4.20 sonypi=251,1,1,1 root=/dev/hda3
Initializing CPU#0
Detected 727.830 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1255.01 BogoMIPS
Memory: 240296k/245760k available (1436k kernel code, 4996k reserved, 585k data, 80k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.0.3, 733 MHz
CPU: Code Morphing Software revision 4.2.7-8-278
CPU: 20011004 02:04 official release 4.2.7#7
CPU serial number disabled.
CPU:     After generic, caps: 0080893f 0081813f 0000000e 00000000
CPU:             Common caps: 0080893f 0081813f 0000000e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfd85e, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 9 for device 00:06.0
PCI: Found IRQ 9 for device 00:08.0
PCI: Found IRQ 9 for device 00:0a.0
PCI: Sharing IRQ 9 with 00:0b.0
PCI: Sharing IRQ 9 with 00:12.0
PCI: Found IRQ 9 for device 00:0f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Starting kswapd
Journalled Block Device driver loaded
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:............................................................................................................................
124 Control Methods found and parsed (503 nodes total)
ACPI Namespace successfully loaded at root c031daa0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-16] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.......evregion-0302 [04] Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
Ps_execute: method failed - \_SB_.PCI0.ISA_.EC0_.BAT1._STA (cee714c8)
  uteval-0337 [-13] Ut_execute_STA        : _STA on BAT1 failed AE_ERROR
..............[ACPI Debug] String: LNK2_STA
.[ACPI Debug] String: LNK3_STA
.[ACPI Debug] String: LNK4_STA
.[ACPI Debug] String: LNK5_STA
.[ACPI Debug] String: LNK6_STA
.[ACPI Debug] String: LNK7_STA
.[ACPI Debug] String: LNK8_STA
.[ACPI Debug] String: LNKU_STA
....................
48 Devices found: 47 _STA, 3 _INI
Completing Region and Field initialization:........
8/13 Regions, 0/0 Fields initialized (503 nodes total)
ACPI: Subsystem enabled
evregion-0302 [03] Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
Ps_execute: method failed - \_SB_.PCI0.ISA_.EC0_.BAT1._STA (cee714c8)
  uteval-0337 [-14] Ut_execute_STA        : _STA on BAT1 failed AE_ERROR
evregion-0302 [05] Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
Ps_execute: method failed - \_SB_.PCI0.ISA_.EC0_.BAT1._STA (cee714c8)
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNKU_STA
[ACPI Debug] String: LNKU_STA
[ACPI Debug] String: LNKU_STA
Power Resource: found
EC: found, GPE 1
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2 C3
ACPI: AC Adapter found
ACPI: Power Button (CM) found
ACPI: Lid Switch (CM) found
evregion-0302 [08] Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
Ps_execute: method failed - \_TZ_.ATF0._TMP (cee69888)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
PCI: Enabling device 00:08.0 (0000 -> 0003)
PCI: Found IRQ 9 for device 00:08.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (10b9,5457,104d,80ec)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
sonypi command failed at sonypi.c : sonypi_call1 (line 190)
sonypi command failed at sonypi.c : sonypi_call2 (line 200)
sonypi command failed at sonypi.c : sonypi_call2 (line 202)
sonypi command failed at sonypi.c : sonypi_call1 (line 190)
sonypi: Sony Programmable I/O Controller Driver v1.13.
sonypi: detected type2 model, verbose = on, fnkeyinit = on, camera = on, compat = off, nojogdial = off
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 80
ALI15X3: detected chipset, but driver not compiled in!
PCI: No IRQ known for interrupt pin A of device 00:10.0. Please try using pci=biosirq.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
hda: IC25N030ATDA04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=3648/255/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 9 for device 00:0b.0
PCI: Sharing IRQ 9 with 00:0a.0
PCI: Sharing IRQ 9 with 00:12.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf807800, 08:00:46:46:db:0c, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux video capture interface: v1.00
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 00:0f.0 (0010 -> 0012)
PCI: Found IRQ 9 for device 00:0f.0
usb-ohci.c: USB OHCI at membase 0xcf809000, IRQ 9
usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cee2e2e0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: cf809000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cee2e2e0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Found IRQ 9 for device 00:14.0
usb-ohci.c: USB OHCI at membase 0xc00e0000, IRQ 9
usb-ohci.c: usb-00:14.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF cee2e420, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: c00e0000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cee2e420
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver acm
acm.c: v0.21:USB Abstract Control Model driver for USB modems and ISDN adapters
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
bluetooth.c: USB Bluetooth support registered
usb.c: registered new driver bluetty
bluetooth.c: USB Bluetooth tty driver v0.13
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 80k freed
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:0f.0-1, assigned address 2
usb.c: kmalloc IF cee2e5a0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Sony
Product: USB Memory Stick Slot
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Sony      Model: MSC-U02           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
usb.c: usb-storage driver claimed interface cee2e5a0
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 299992k swap-space (priority -1)
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 02:52:00 Mar  9 2003
PCI: Found IRQ 9 for device 00:06.0
trident: ALi Audio Accelerator found at IO 0x1800, IRQ 9
ac97_codec: AC97 Audio codec, id: YMH3(Unknown)
ac97_codec: AC97 Audio codec, id: YMH3(Unknown)
Linux PCMCIA Card Services 3.2.4
  kernel build: 2.4.20 #2 Sun Mar 9 02:46:37 CET 2003
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 9 for device 00:12.0
PCI: Sharing IRQ 9 with 00:0a.0
PCI: Sharing IRQ 9 with 00:0b.0
  Ricoh RL5C475 rev 80 PCI-to-CardBus at slot 00:12, mem 0x10000000
    host opts [0]: [serial irq] [io 3/6/1] [mem 3/6/1] [pci irq 9] [lat 168/176] [bus 1/1]
    ISA irqs (default) = 3,4,5,7,10,12,15 PCI status changes
meye: using 2 buffers with 600k (1200k total) for capture
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:14.0-1, assigned address 2
usb.c: kmalloc IF ce8e5b00, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: MITSUMI 
Product: MITSUMI USB FDD 
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: MITSUMI   Model: USB FDD           Rev: 1035
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
usb.c: usb-storage driver claimed interface ce8e5b00
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
SCSI device sdb: 2880 512-byte hdwr sectors (1 MB)
sdb: Write Protect is off
 sdb: sdb1 sdb2 sdb3 sdb4
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x388-0x38f 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0208-0x021f: clean.
cs: IO port probe 0x0230-0x032f: clean.
cs: IO port probe 0x0338-0x0387: clean.
cs: IO port probe 0x0390-0x03bf: clean.
cs: IO port probe 0x03e0-0x0407: clean.
cs: IO port probe 0x0410-0x047f: clean.
cs: IO port probe 0x0490-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
hde: CD-224E, ATAPI CD/DVD-ROM drive
ide2 at 0x180-0x187,0x386 on irq 3
ide-cs: hde: Vcc = 5.0, Vpp = 0.0
hde: bad special flag: 0x03

--Boundary-00=_xlUs+XmT9qi6emq
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci-vv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci-vv"

00:00.0 Host bridge: Transmeta Corporation: Unknown device 0395 (rev 01)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation: Unknown device 0396
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation: Unknown device 0397
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown device 5451 (rev 02)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Modem: Acer Laboratories Inc. [ALi]: Unknown device 5457 (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8101000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1c00 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8102000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Region 1: Memory at e8104000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia controller: Citicorp TTI: Unknown device 2011
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2000 [disabled] [size=256]
	Region 1: Memory at e8200000 (32-bit, non-prefetchable) [disabled] [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at e8102800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2800 [size=256]
	Region 2: Memory at e8110000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8103000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if a0)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: [virtual] I/O ports at 01f0 [size=16]
	Region 1: [virtual] I/O ports at 03f4
	Region 2: [virtual] I/O ports at 0170 [size=16]
	Region 3: [virtual] I/O ports at 0374
	Region 4: I/O ports at 1400 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Non-VGA unclassified device: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 000e0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-00=_xlUs+XmT9qi6emq--


