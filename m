Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270978AbTGPSLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271037AbTGPSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:10:57 -0400
Received: from jimbo.globalnet.hr ([213.149.32.23]:14312 "EHLO
	jimbo.globalnet.hr") by vger.kernel.org with ESMTP id S270978AbTGPSIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:08:43 -0400
Date: Wed, 16 Jul 2003 20:21:45 +0200
From: Danijel Schiavuzzi <dschiavu@globalnet.hr>
To: linux-kernel@vger.kernel.org
Cc: isdn4linux@listserv.isdn4linux.de, kai.germaschewski@gmx.de
Subject: Problems with isdn4linux in the 2.6.0-test1 kernel
Message-ID: <20030716182145.GA567@lupus>
Mail-Followup-To: Danijel Schiavuzzi <dschiavu@globalnet.hr>,
	linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
	kai.germaschewski@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Atlantis
X-Operating-System: Linux lupus.atlantis.int 2.4.20-3-k7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUMMARY: Problems with isdn4linux in the 2.6.0-test1 kernel.

Hi,

I'm having problems with the isdn4linux subsystem in the 2.6.0-test1
kernel. Downloaded, configured, compiled, new module tools too, boots
and works perfectly apart from this isdn module linking problem.

Thanks anyone for help. And sorry for my bad English 8)

Danijel


Debug information follow...

----------------------------------------------------------------------

$ cat /proc/version
Linux version 2.6.0-test1 (root@lupus.atlantis.int) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Wed Jul 16 18:43:38 CEST 2003

$ lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at c000 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at c400 [size=32]
	Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at c800 [size=32]
	Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Flags: medium devsel, IRQ 11
	Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 3400
	Flags: medium devsel, IRQ 11
	I/O ports at cc00 [size=256]
	I/O ports at d000 [size=4]
	I/O ports at d400 [size=4]
	Capabilities: <available only to root>

******* This is the ISDN passive card, uses the Cologne Chip HFC-PCI chipset 
00:09.0 Network controller: Abocom Systems Inc: Unknown device 2bd1 (rev 02)
	Subsystem: Abocom Systems Inc: Unknown device 2bd1
	Flags: bus master, medium devsel, latency 16, IRQ 10
	I/O ports at dc00 [disabled] [size=8]
	Memory at e2000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e000 [size=256]
	Memory at e2001000 (32-bit, non-prefetchable) [size=256]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
	Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

Compile time warnings I get relevant to ISDN:

# make bzImage
	...
  CC [M]  drivers/isdn/hisax/config.o
  CC [M]  drivers/isdn/hisax/isdnl1.o
  CC [M]  drivers/isdn/hisax/tei.o
  CC [M]  drivers/isdn/hisax/isdnl2.o
  CC [M]  drivers/isdn/hisax/isdnl3.o
  CC [M]  drivers/isdn/hisax/lmgr.o
  CC [M]  drivers/isdn/hisax/q931.o
  CC [M]  drivers/isdn/hisax/callc.o
  CC [M]  drivers/isdn/hisax/fsm.o
  CC [M]  drivers/isdn/hisax/cert.o
drivers/isdn/hisax/cert.c: In function `certification_check':
drivers/isdn/hisax/cert.c:17: warning: control reaches end of non-void function
  CC [M]  drivers/isdn/hisax/l3dss1.o
  CC [M]  drivers/isdn/hisax/hfc_pci.o
  LD [M]  drivers/isdn/hisax/hisax.o
  CC [M]  drivers/isdn/i4l/isdn_net_lib.o
  CC [M]  drivers/isdn/i4l/isdn_fsm.o
  CC [M]  drivers/isdn/i4l/isdn_tty.o
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_write':
drivers/isdn/i4l/isdn_tty.c:1198: warning: unused variable `m'
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_open':
drivers/isdn/i4l/isdn_tty.c:1733: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:481)
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_close':
drivers/isdn/i4l/isdn_tty.c:1862: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:493)
  CC [M]  drivers/isdn/i4l/isdn_v110.o
  CC [M]  drivers/isdn/i4l/isdn_common.o
drivers/isdn/i4l/isdn_common.c: In function `drv_register':
drivers/isdn/i4l/isdn_common.c:602: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_run':
drivers/isdn/i4l/isdn_common.c:613: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_stop':
drivers/isdn/i4l/isdn_common.c:620: warning: control reaches end of non-void function
drivers/isdn/i4l/isdn_common.c: In function `drv_stat_stavail':
drivers/isdn/i4l/isdn_common.c:650: warning: control reaches end of non-void function
  CC [M]  drivers/isdn/i4l/isdn_ppp.o
  CC [M]  drivers/isdn/i4l/isdn_ppp_ccp.o
  CC [M]  drivers/isdn/i4l/isdn_ppp_vj.o
  LD [M]  drivers/isdn/i4l/isdn.o
  CC [M]  drivers/isdn/i4l/isdn_bsdcomp.o

# make modules_install
	...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test1; fi
WARNING: /lib/modules/2.6.0-test1/kernel/drivers/isdn/hisax/hisax.ko needs unknown symbol kstat__per_cpu

When loading the hisax module, modprobe says ...

# modprobe hisax
FATAL: Error inserting hisax (/lib/modules/2.6.0-test1/kernel/drivers/isdn/hisax/hisax.ko): Unknown symbol in module, or unknown parameter (see dmesg)

Complete kernel messages:

# dmesg
Linux version 2.6.0-test1 (root@lupus.atlantis.int) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Wed Jul 16 18:43:38 CEST 2003
Video mode to be used for restore is 717
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIA694                     ) @ 0x000f76c0
ACPI: RSDT (v001 VIA694 MSI ACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 MSI ACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux-2.6 ro root=306
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 902.364 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1773.56 BogoMIPS
Memory: 256312k/262080k available (1486k kernel code, 5040k reserved, 463k data, 308k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 901.0938 MHz.
..... host bus clock speed is 200.0430 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xd8000000, mapped to 0xd0806000, size 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:c480
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080L0, ATA DISK drive
hda: TCQ not supported
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WAITEC ALADAR/1, ATAPI CD/DVD-ROM drive
hdd: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 308k freed
EXT3 FS on hda6, internal journal
Real Time Clock Driver v1.11
Adding 262136k swap on /swapfile1.  Priority:-1 extents:171
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c02bb780(lo)
IPv6 over IPv4 tunneling driver
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 300 bytes per conntrack
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd4858000, 00:c0:df:24:df:f8, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139A'
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT133/KM133/TwisterK chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 128M @ 0xd0000000
i2c-prosavage version 2.7.0 (20030621)
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem initialized
hisax: Unknown symbol kstat__per_cpu

Relevant .config options:

#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# Old ISDN4Linux
#
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_PPP_BSDCOMP=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_HFC_PCI=y
# CONFIG_HISAX_HFCPCI is not set --> BTW, what's this for, an alternative driver?

Software on the system:

Linux lupus.atlantis.int 2.6.0-test1 #1 Wed Jul 16 18:43:38 CEST 2003 i686 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
PPP                    2.4.1
isdn4k-utils           3.2p3
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         isdn slhc via686a i2c_viapro i2c_sensor i2c_prosavage i2c_algo_bit i2c_core via_agp agpgart 8139too crc32 ipt_LOG ipt_limit ipt_state ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter ip_tables parport_pc lp parport md5 ipv6 rtc
