Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293602AbSCWQSJ>; Sat, 23 Mar 2002 11:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSCWQSB>; Sat, 23 Mar 2002 11:18:01 -0500
Received: from bazooka.saturnus.vein.hu ([193.6.40.86]:35461 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S293602AbSCWQRn>; Sat, 23 Mar 2002 11:17:43 -0500
Date: Sat, 23 Mar 2002 18:17:36 +0100
To: linux-kernel@vger.kernel.org
Subject: io-apic not working on i850mv(p4)
Message-ID: <20020323181736.B9229@bazooka.saturnus.vein.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Banai Zoltan <bazooka@enclavenet.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Intel i850MV motherboard with:

cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.886
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3381.65

using 2.4.19-pre3-ac3 kernel with IO-APIC, but it seems not working to me:

interrupts:
           CPU0       
  0:    5420792          XT-PIC  timer
  1:      24660          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:     173872          XT-PIC  usb-uhci
  5:         19          XT-PIC  usb-uhci
  7:      13840          XT-PIC  EMU10K1
  8:          3          XT-PIC  rtc
  9:         35          XT-PIC  acpi, sym53c8xx
 10:       2194          XT-PIC  Intel ICH2
 11:    4172599          XT-PIC  eth0, nvidia
 12:          8          XT-PIC  PS/2 Mouse
 14:     106281          XT-PIC  ide0
 15:        217          XT-PIC  ide1
NMI:          0 
LOC:    5420713 
ERR:          0
MIS:          0

why gives XT-PIC instead of IO-APIC for all interrupst

dmesg:

Linux version 2.4.19-pre3-ac3 (root@bazooka) (gcc version 2.95.4 (Debian prerelease)) #1 Wed Mar 20 14:14:44 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
On node 0 totalpages: 131008
zone(0): 4096 pages.
zone(1): 126912 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1
Found and enabled local APIC!
Initializing CPU#0
Detected 1694.886 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 513984k/524032k available (1882k kernel code, 9660k reserved, 586k data, 232k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.70GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1694.8991 MHz.
..... host bus clock speed is 99.6998 MHz.
cpu: 0, clocks: 996998, slice: 498499
CPU0<T0:996992,T1:498480,D:13,S:498499,C:996998>
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.10 <tigran@veritas.com>
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
Coda Kernel/Venus communications, v5.3.18, coda@cs.cmu.edu
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
Power Resource: found
Power Resource: found
Power Resource: found
Power Resource: found
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP SERIAL_ACPI enabled
gameport0: Emu10k1 Gameport at 0xdff0 size 8 speed 932 kHz
input0: Analog 3-axis 10-button 1-hat Saitek joystick at gameport0.0 [TSC timer, 1691 MHz clock, 1114 ns res]
Real Time Clock Driver v1.10e
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 4
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 4D040H2, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1102, ATAPI CD/DVD-ROM drive
hdc: MAXTOR 4K040H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=4982/255/63, UDMA(100)
hdc: 78198750 sectors (40038 MB) w/2000KiB Cache, CHS=77578/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 > p3 p4
 p3: <bsd: p9 p10 p11 p12 p13 >
 /dev/ide/host0/bus1/target0/lun0: p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 02:08.0
eth0: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller, 00:03:47:DC:50:3A, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i850 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 02:0a.0
sym.2.10.0: setting PCI_COMMAND_PARITY...
sym0: <875> rev 0x4 on pci bus 2 device 10 function 0 irq 9
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCAN AT BOOT disabled for targets 8 9 10 11 12 13 14 15.
sym0: SCAN FOR LUNS disabled for targets 8 9 10 11 12 13 14 15.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
  Vendor: QUANTUM   Model: FIREBALL ST2.1S   Rev: 0F0C
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0H
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym0:1:0: tagged command queuing enabled, command queue depth 16.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1102  Rev: 1026
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: 4235629 512-byte hdwr sectors (2169 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
sym0:3: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 7)
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Intel 810 + AC97 Audio, version 0.21, 14:16:36 Mar 20 2002
PCI: Found IRQ 10 for device 00:1f.5
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 10
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
i810_audio: setting clocking to 41113
Creative EMU10K1 PCI Audio Driver, version 0.18, 14:16:31 Mar 20 2002
PCI: Found IRQ 7 for device 02:0d.0
emu10k1: EMU10K1 rev 8 model 0x8028 found, IO at 0xdf80-0xdf9f, IRQ 7
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Cirrus Logic CS4297A rev B)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 3 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xef40, IRQ 3
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:1f.4
PCI: Setting latency timer of device 00:1f.4 to 64
uhci.c: USB UHCI at I/O 0xef80, IRQ 5
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usbscanner
scanner.c: 0.4.6:USB Scanner Driver
mice: PS/2 mouse device common for all mice
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 232k freed
hub.c: USB new device connect on bus1/2, assigned device number 2
input1: USB HID v1.00 Mouse [Cypress Sem. Cypress USB Mouse] on usb1:2.0
Adding Swap: 489940k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
hub.c: USB new device connect on bus2/2, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2802  Tue Mar  5 06:26:45 PST 2002
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide1(22,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

lspci -v:

00:00.0 Host bridge: Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH) (rev 04)
	Flags: bus master, fast devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: fc900000-fe9fffff
	Prefetchable memory behind bridge: e4600000-f46fffff

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: f4700000-f47fffff

00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 04)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 04) (prog-if 80 [Master])
	Subsystem: Intel Corp.: Unknown device 4d44
	Flags: bus master, medium devsel, latency 0
	I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev 04) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4d44
	Flags: bus master, medium devsel, latency 0, IRQ 3
	I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 04)
	Subsystem: Intel Corp.: Unknown device 4d44
	Flags: medium devsel, IRQ 10
	I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B) (rev 04) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4d44
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at ef80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller (rev 04)
	Subsystem: Intel Corp.: Unknown device 6d76
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at e800 [size=256]
	I/O ports at ef00 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev a1) (prog-if 00 [VGA])
	Subsystem: Creative Labs: Unknown device 1048
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fe9f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller (rev 03)
	Subsystem: Intel Corp.: Unknown device 3013
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 2

02:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c875J (rev 04)
	Subsystem: Diamond Multimedia Systems FirePort 40 SCSI Controller
	Flags: bus master, medium devsel, latency 144, IRQ 9
	I/O ports at d800 [size=256]
	Memory at feaffc00 (32-bit, non-prefetchable) [size=256]
	Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feae0000 [disabled] [size=64K]

02:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs: Unknown device 8028
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at df80 [size=32]
	Capabilities: [dc] Power Management version 2

02:0d.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at dff0 [size=8]
	Capabilities: [dc] Power Management version 2

Thanks, Banai
