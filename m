Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310251AbSCBBoP>; Fri, 1 Mar 2002 20:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCBBoH>; Fri, 1 Mar 2002 20:44:07 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:14465 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S310251AbSCBBoC>; Fri, 1 Mar 2002 20:44:02 -0500
Date: Fri, 1 Mar 2002 17:43:38 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: vojtech@suse.cz
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Input funnies on 2.5.5-dj2
Message-ID: <Pine.LNX.4.44.0203011733220.5861-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have been running 2.5.5-dj2 for a week or so.  About once per boot, I
get the following printk:

atkbd.c: Unknown key (set 4, scancode 0xb6, on isa0060/serio0) pressed.

Also, occasionally a key release event gets missed, usually a Shift key
but sometimes something else.  I believe that this coincides with the
atkbd.c messages, but I am not definite.

I include below my boot messages for the purpose of describing my setup,
plus I include the output of /proc/interrupts in case it might be
relevant.  Please let me know if any more information would be of use.

Cheers,
Wayne


Linux version 2.5.5-dj2 (root@pizza) (gcc version 3.1 20020205 (Red Hat Linux Rawhide 3.1-0.21)) #4 Thu Feb 28 19:01:19 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda5 nmi_watchdog=1 parport=0x378,7,3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1526.843 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3047.42 BogoMIPS
Memory: 517128k/524224k available (1271k kernel code, 6708k reserved, 281k data, 260k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1526.8445 MHz.
..... host bus clock speed is 265.5380 MHz.
cpu: 0, clocks: 2655380, slice: 1327690
CPU0<T0:2655376,T1:1327680,D:6,S:1327690,C:2655380>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
Power Resource: found
Power Resource: found
Power Resource: found
Power Resource: found
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2
ACPI: Power Button (FF) found
ACPI: Sleep Button (CM) found
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (interrupt-driven).
lp0: console ready
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.32
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L060L3, ATA DISK drive
hdc: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02f5844, I/O limit 4095Mb (mask 0xffffffff)
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(100)
blk: queue c02f5be4, I/O limit 4095Mb (mask 0xffffffff)
hdc: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdc: unknown partition table
mice: PS/2 mouse device common for all mice
input: AT Set 2 Extended keyboard
 on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
Real Time Clock Driver v1.11
Adding Swap: 1047776k swap-space (priority -1)
usb.c: registered new driver usbfs
usb.c: registered new driver hub
SiS router pirq escape (99)
SiS router pirq escape (99)
usb-ohci.c: USB OHCI at membase 0xe08a5000, IRQ 11
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 3 ports detected
PCI: Found IRQ 5 for device 00:02.2
PCI: Sharing IRQ 5 with 00:0f.0
usb-ohci.c: USB OHCI at membase 0xe08a7000, IRQ 5
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 3 ports detected
hub.c: new USB device on bus 2 path /1, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc401) is not claimed by any active driver.
usb.c: registered new driver hid
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb2:1
hid-core.c: v1.31:USB HID core driver
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
i2c-isa.o version 2.6.2 (20011118)
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
it87.o version 2.6.2 (20011118)
i2c-core.o: driver IT87xx sensor driver registered.
i2c-core.o: client [IT87 chip] registered to adapter [ISA main adapter](pos. 0).
ip_conntrack (4095 buckets, 32760 max)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected SiS 735 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
blk: queue c02f5844, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02f5be4, I/O limit 4095Mb (mask 0xffffffff)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.


[whitney@pizza linux-2.5.5-dj2]$ cat /proc/interrupts 
           CPU0       
  0:    2428585          XT-PIC  timer
  1:      31792          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          1          XT-PIC  serial
  5:        153          XT-PIC  usb-ohci
  7:      12184          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:     345275          XT-PIC  usb-ohci, eth0, SiS SI7012
 12:      58869          XT-PIC  i8042
 14:     934298          XT-PIC  ide0
 15:  131999422          XT-PIC  ide1
NMI:       8150 
LOC:    2428573 
ERR:          0
MIS:          0


