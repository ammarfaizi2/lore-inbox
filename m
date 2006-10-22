Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWJVHcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWJVHcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWJVHcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 03:32:25 -0400
Received: from userg502.nifty.com ([202.248.238.82]:10844 "EHLO
	userg502.nifty.com") by vger.kernel.org with ESMTP id S1751769AbWJVHcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 03:32:24 -0400
DomainKey-Signature: a=rsa-sha1; s=userg502; d=nifty.com; c=simple; q=dns;
	b=LCFGMiraH0ENTNyrdBziI6a6nw2RcMaV6K3V46yYdTHCqRwxOgR8AL3gy7Pg98pvD
	U7He+o9jv5GrBJwaSg8HA==
Date: Sun, 22 Oct 2006 16:29:48 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.19-rc1   APIC BUG?] kernel 2.6.19-rc1 or later can not
 generate ISA irq properly on DUAL-CPU system.
Message-Id: <20061022162948.1cf26ad6.komurojun-mbn@nifty.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kernel 2.6.19-rc1 or later can not generate ISA irq properly on DUAL-CPU system.
kernel 2.6.18 work properly.

I think this problem is caused by IRQ-subsystem change on 2.6.19-rc1.

Please advise.

> system
mother board: ASUS P2B-D(440BX), PentiumIII
ISA card: i82365 pcmcia controller. Asix 16bit PCMCIA Network card.

> dmesg 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffd000 (usable)
 BIOS-e820: 0000000017ffd000 - 0000000017fff000 (ACPI data)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
383MB LOWMEM available.
found SMP MP-table at 000f6ec0
Entering add_active_range(0, 0, 98301) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    98301
  HighMem     98301 ->    98301
early_node_map[1] active PFN ranges
    0:        0 ->    98301
On node 0 totalpages: 98301
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 735 pages used for memmap
  Normal zone: 93470 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.0 present.
Using APIC driver default
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 6:7 APIC version 17
Processor #0 6:7 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 18000000:e6c00000)
Detected 501.156 MHz processor.
Built 1 zonelists.  Total pages: 97534
Kernel command line: ro root=/dev/hda1 acpi=off rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 384920k/393204k available (1867k kernel code, 7696k reserved, 706k data, 220k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe1b000 - 0xfffff000   (1936 kB)
    pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xd8800000 - 0xffbfe000   ( 627 MB)
    lowmem  : 0xc0000000 - 0xd7ffd000   ( 383 MB)
      .init : 0xc0389000 - 0xc03c0000   ( 220 kB)
      .data : 0xc02d2c5b - 0xc0383690   ( 706 kB)
      .text : 0xc0100000 - 0xc02d2c5b   (1867 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1003.32 BogoMIPS (lpj=2006640)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1002.40 BogoMIPS (lpj=2004806)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2005.72 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=2557
checking if image is initramfs... it is
Freeing initrd memory: 1102k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e2000000-e2efffff
  PREFETCH window: e2f00000-e3ffffff
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xe4000000
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD200BB-00AUA1, ATA DISK drive
hdb: CD-W58E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdb: ATAPI 32X CD-ROM CD-R/RW drive, 1280kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
Freeing unused kernel memory: 220k freed
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
warning: process `kmodule' used the removed sysctl system call
warning: process `ls' used the removed sysctl system call
Intel ISA PCIC probe: 
  Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,5,7,9,11,15 status change on irq 15
pccard: PCMCIA card inserted into slot 0
warning: process `date' used the removed sysctl system call
EXT3 FS on hda1, internal journal
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1 across:257032k
warning: process `ls' used the removed sysctl system call
warning: process `sleep' used the removed sysctl system call
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x290-0x297 0x370-0x37f
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x290-0x297 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0x0d0000-0x0dffff: clean.
pcmcia: registering new device pcmcia0.0
eth0: Asix AX88190: io 0x300, irq 3, hw_addr xx:xx:xx:xx:xx:xx 
eth0: found link beat
eth0: autonegotiation complete: 100baseT-FD selected
eth0: interrupt(s) dropped!
eth0: interrupt(s) dropped!
eth0: interrupt(s) dropped!
eth0: interrupt(s) dropped!
eth0: interrupt(s) dropped!
eth0: interrupt(s) dropped!

Best Regards
Komuro
