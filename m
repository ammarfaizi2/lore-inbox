Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBOEq0>; Wed, 14 Feb 2001 23:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129084AbRBOEqR>; Wed, 14 Feb 2001 23:46:17 -0500
Received: from imcs.rutgers.edu ([165.230.57.130]:959 "EHLO imcs.Rutgers.EDU")
	by vger.kernel.org with ESMTP id <S129080AbRBOEqH>;
	Wed, 14 Feb 2001 23:46:07 -0500
Date: Wed, 14 Feb 2001 23:35:28 -0500 (EST)
From: Rob Cermak <cermak@IMCS.rutgers.edu>
To: linux-kernel@vger.kernel.org
cc: jonathan_brugge@hotmail.com
Subject: success NICs (disabled CONFIG_ISAPNP with 2.4.1-ac11)/other
 oddments/Problem: NIC doesn't work
In-Reply-To: <Pine.SOL.4.21.0102141940470.3550-100000@imcs.rutgers.edu>
Message-ID: <Pine.SOL.4.21.0102142321300.4842-100000@imcs.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.19pre11 works.

Got 2.4.1-ac11 to work with these settings:

# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

eth0: Digital DC21041 Tulip rev 17 at 0xfc00, 21041 mode,
00:00:C0:5C:45:01, IRQ 10.
eth1: 3c509 at 0x340, 10baseT port, address 00 10 5a 1c e5 fe, IRQ 7.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
eth2: 3c509 at 0x320, AUI port, address 00 20 af 0a 62 0d, IRQ 5.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.

Oddments:  [Can't show you since the machine locked up both times
  prior to logging information -- I need to break out the serial cable
  and capture boot messages]

With CONFIG-ISAPNP off:

2.4.1-ac12 -- SCSI driver takes over and does not allow the IDE
     disk to boot.

2.4.1-ac11 -- The first time, root didn't remount properly from read-only
     to read-write and hung at trying to bring the system logger up.  Was
     able to reboot using ALT-CTRL-DEL.

     Booting as single worked and then allowed it to follow through the
     remaining boot sequence.  All seems well.

Vitals on 2.4.1-ac11:

Linux version 2.4.1-ac11 (root@anole.sjrcd.org) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #3 Wed Feb 14 22:55:19 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.1-ac11 ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.1-ac11 hdc=ide-scsi hdd=ide-scsi single
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 266.618 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 532.48 BogoMIPS
Memory: 62464k/65536k available (893k kernel code, 2684k reserved, 307k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0080f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0080f9ff 00000000 00000000 00000000
CPU: Common caps: 0080f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd9cc, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41437kB/13812kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
hda: QUANTUM FIREBALL SE4.3A, ATA DISK drive
hdc: SAF CD-RW4224A, ATAPI CD/DVD-ROM drive
hdd: FX320S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8418816 sectors (4310 MB) w/80KiB Cache, CHS=524/255/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding Swap: 136512k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 23:17:30 Feb 14 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:07.2 (0004 -> 0005)
PCI: Found IRQ 11 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0xfcc0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
es1370: version v0.34 time 23:16:59 Feb 14 2001
PCI: Enabling device 00:0e.0 (0004 -> 0005)
PCI: Found IRQ 9 for device 00:0e.0
es1370: found adapter at io 0xf8c0 irq 9
es1370: features: joystick off, line in, mic impedance 0

lspci -v

00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge
(rev 03)
        Flags: bus master, medium devsel, latency 32
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: fd800000-fecfffff

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE 
(rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB 
(rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at fcc0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
        Flags: medium devsel, IRQ 9

00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 11)
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at fc00 [size=128]
        Memory at fedffc00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:0e.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 96, IRQ 9
        I/O ports at f8c0 [size=64]

01:00.0 Display controller: Texas Instruments TVP4020 [Permedia 2] (rev 01)
        Subsystem: Accelgraphics Inc.: Unknown device 0011
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 9
        Memory at fecc0000 (32-bit, non-prefetchable) [size=128K]
        Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
        Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] AGP version 1.0


