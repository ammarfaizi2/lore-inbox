Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270632AbTHJU1d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTHJU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:27:33 -0400
Received: from outbound02.telus.net ([199.185.220.221]:51627 "EHLO
	priv-edtnes04.telusplanet.net") by vger.kernel.org with ESMTP
	id S270632AbTHJU1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:27:10 -0400
Subject: test3 responsible for atomic blast!
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060547281.6445.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Aug 2003 14:28:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The really good news is 2.6.0-test3 is *much* more efficient at
delivering error messages than earlier versions!  
The following is from /var/log/messages:
Aug 10 14:06:12 localhost syslog: klogd shutdown succeeded
Aug 10 14:06:12 localhost exiting on signal 15
Aug 10 14:07:06 localhost syslogd 1.4.1: restart.
Aug 10 14:07:06 localhost syslog: syslogd startup succeeded
Aug 10 14:07:06 localhost kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Aug 10 14:07:06 localhost kernel: Linux version 2.6.0-test3
(root@localhost.localdomain) (gcc version 3.2.2 20030222 (Red Hat Linux
3.2.2-5)) #1 Sat Aug 9 20:44:40 MDT 2003
Aug 10 14:07:06 localhost kernel: Video mode to be used for restore is
f00
Aug 10 14:07:06 localhost kernel: BIOS-provided physical RAM map:
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 0000000000100000 -
000000003fff0000 (usable)
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 000000003fff0000 -
000000003fff3000 (ACPI NVS)
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 000000003fff3000 -
0000000040000000 (ACPI data)
Aug 10 14:07:06 localhost kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Aug 10 14:07:06 localhost kernel: 127MB HIGHMEM available.
Aug 10 14:07:06 localhost syslog: klogd startup succeeded
Aug 10 14:07:06 localhost kernel: 896MB LOWMEM available.
Aug 10 14:07:06 localhost kernel: On node 0 totalpages: 262128
Aug 10 14:07:06 localhost kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 10 14:07:06 localhost kernel:   Normal zone: 225280 pages, LIFO
batch:16
Aug 10 14:07:06 localhost kernel:   HighMem zone: 32752 pages, LIFO
batch:7
Aug 10 14:07:06 localhost kernel: Building zonelist for node : 0
Aug 10 14:07:06 localhost kernel: Kernel command line: ro root=/dev/hda3
hdd=ide-scsi
Aug 10 14:07:06 localhost kernel: ide_setup: hdd=ide-scsi
Aug 10 14:07:06 localhost kernel: Local APIC disabled by BIOS --
reenabling.
Aug 10 14:07:06 localhost kernel: Found and enabled local APIC!
Aug 10 14:07:06 localhost kernel: Initializing CPU#0
Aug 10 14:07:06 localhost kernel: PID hash table entries: 4096 (order
12: 32768 bytes)
Aug 10 14:07:06 localhost kernel: Detected 1890.212 MHz processor.
Aug 10 14:07:06 localhost kernel: Console: colour VGA+ 80x25
Aug 10 14:07:06 localhost kernel: Calibrating delay loop... 3735.55
BogoMIPS
Aug 10 14:07:06 localhost kernel: Memory: 1034060k/1048512k available
(1935k kernel code, 13540k reserved, 700k data, 244k init, 131008k
highmem)
Aug 10 14:07:06 localhost kernel: Dentry cache hash table entries:
131072 (order: 7, 524288 bytes)
Aug 10 14:07:06 localhost kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Aug 10 14:07:06 localhost kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Aug 10 14:07:06 localhost kernel: -> /dev
Aug 10 14:07:06 localhost kernel: -> /dev/console
Aug 10 14:07:06 localhost kernel: -> /root
Aug 10 14:07:06 localhost kernel: CPU: Trace cache: 12K uops, L1 D
cache: 8K
Aug 10 14:07:06 localhost kernel: CPU: L2 cache: 512K
Aug 10 14:07:06 localhost kernel: Intel machine check architecture
supported.
Aug 10 14:07:06 localhost kernel: Intel machine check reporting enabled
on CPU#0.
Aug 10 14:07:06 localhost kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs
(12) available
Aug 10 14:07:06 localhost portmap: portmap startup succeeded
Aug 10 14:07:06 localhost kernel: CPU#0: Thermal monitoring enabled
Aug 10 14:07:06 localhost kernel: CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping 04
Aug 10 14:07:06 localhost kernel: Enabling fast FPU save and restore...
done.
Aug 10 14:07:06 localhost kernel: Enabling unmasked SIMD FPU exception
support... done.
Aug 10 14:07:06 localhost kernel: Checking 'hlt' instruction... OK.
Aug 10 14:07:06 localhost kernel: POSIX conformance testing by UNIFIX
Aug 10 14:07:07 localhost rpc.statd[964]: Version 1.0.1 Starting
Aug 10 14:07:07 localhost nfslock: rpc.statd startup succeeded
Aug 10 14:07:07 localhost kernel: enabled ExtINT on CPU#0
Aug 10 14:07:07 localhost kernel: ESR value before enabling vector:
00000000
Aug 10 14:07:07 localhost keytable: Loading keymap:
Aug 10 14:07:07 localhost kernel: ESR value after enabling vector:
00000000
Aug 10 14:07:07 localhost keytable:
Aug 10 14:07:07 localhost kernel: Using local APIC timer interrupts.
Aug 10 14:07:07 localhost keytable:
Aug 10 14:07:07 localhost kernel: calibrating APIC timer ...
Aug 10 14:07:07 localhost rc: Starting keytable:  succeeded
Aug 10 14:07:07 localhost kernel: ..... CPU clock speed is 1889.0753
MHz.
Aug 10 14:07:07 localhost kernel: ..... host bus clock speed is 104.0986
MHz.
Aug 10 14:07:07 localhost kernel: Initializing RT netlink socket
Aug 10 14:07:07 localhost kernel: EISA bus registered
Aug 10 14:07:07 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb2c0, last bus=1
Aug 10 14:07:07 localhost random: Initializing random number generator: 
succeeded
Aug 10 14:07:07 localhost kernel: PCI: Using configuration type 1
Aug 10 14:07:07 localhost kernel: mtrr: v2.0 (20020519)
Aug 10 14:07:07 localhost kernel: BIO: pool of 256 setup, 14Kb (56
bytes/bio)
Aug 10 14:07:07 localhost kernel: biovec pool[0]:   1 bvecs: 256 entries
(12 bytes)
Aug 10 14:07:07 localhost kernel: biovec pool[1]:   4 bvecs: 256 entries
(48 bytes)
Aug 10 14:07:07 localhost kernel: biovec pool[2]:  16 bvecs: 256 entries
(192 bytes)
Aug 10 14:07:07 localhost rc: Starting pcmcia:  succeeded
Aug 10 14:07:07 localhost kernel: biovec pool[3]:  64 bvecs: 256 entries
(768 bytes)
Aug 10 14:07:07 localhost kernel: biovec pool[4]: 128 bvecs: 256 entries
(1536 bytes)
Aug 10 14:07:07 localhost kernel: biovec pool[5]: 256 bvecs: 256 entries
(3072 bytes)
Aug 10 14:07:07 localhost kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Aug 10 14:07:07 localhost kernel: SCSI subsystem initialized
Aug 10 14:07:07 localhost mount: mount: fs type ext3 not supported by
kernel
Aug 10 14:07:07 localhost kernel: Linux Kernel Card Services 3.1.22
Aug 10 14:07:07 localhost kernel:   options:  [pci] [pm]
Aug 10 14:07:07 localhost kernel: PCI: Probing PCI hardware
Aug 10 14:07:07 localhost mount: mount: fs type reiserfs not supported
by kernel
Aug 10 14:07:07 localhost kernel: PCI: Probing PCI hardware (bus 00)
Aug 10 14:07:07 localhost netfs: Mounting other filesystems:  failed
Aug 10 14:07:07 localhost kernel: Enabling SiS 96x SMBus.
Aug 10 14:07:07 localhost kernel: PCI: Using IRQ router default
[1039/0645] at 0000:00:00.0
Aug 10 14:07:07 localhost kernel: PCI: IRQ 0 for device 0000:00:02.1
doesn't match PIRQ mask - try pci=usepirqmask
Aug 10 14:07:07 localhost kernel: pty: 256 Unix98 ptys configured
Aug 10 14:07:07 localhost kernel: toshiba: not a supported Toshiba
laptop
Aug 10 14:07:07 localhost kernel: highmem bounce pool size: 64 pages
Aug 10 14:07:07 localhost kernel: lp: driver loaded but no devices found
Aug 10 14:07:07 localhost kernel: parport0: PC-style at 0x378
[PCSPP,TRISTATE]
Aug 10 14:07:07 localhost autofs: automount startup succeeded
Aug 10 14:07:07 localhost kernel: parport0 (addr 0): SCSI adapter, IMG
VP1
Aug 10 14:07:07 localhost kernel: parport0: Printer, HEWLETT-PACKARD
DESKJET 930C
Aug 10 14:07:07 localhost kernel: lp0: using parport0 (polling).
Aug 10 14:07:07 localhost kernel: lp0: console ready
Aug 10 14:07:07 localhost kernel: Using anticipatory scheduling elevator
Aug 10 14:07:07 localhost kernel: Floppy drive(s): fd0 is 1.44M
Aug 10 14:07:07 localhost kernel: FDC 0 is a post-1991 82077
Aug 10 14:07:07 localhost kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Aug 10 14:07:07 localhost kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Aug 10 14:07:08 localhost kernel: SIS5513: IDE controller at PCI slot
0000:00:02.5
Aug 10 14:07:08 localhost kernel: SIS5513: chipset revision 208
Aug 10 14:07:08 localhost kernel: SIS5513: not 100%% native mode: will
probe irqs later
Aug 10 14:07:08 localhost kernel: SIS5513: SiS 961 MuTIOL IDE UDMA100
controller
Aug 10 14:07:08 localhost kernel:     ide0: BM-DMA at 0x4000-0x4007,
BIOS settings: hda:DMA, hdb:DMA
Aug 10 14:07:08 localhost kernel:     ide1: BM-DMA at 0x4008-0x400f,
BIOS settings: hdc:DMA, hdd:DMA
Aug 10 14:07:08 localhost kernel: hda: Maxtor 92041U4, ATA DISK drive
Aug 10 14:07:08 localhost kernel: hdb: Maxtor 98196H8, ATA DISK drive
Aug 10 14:07:08 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 10 14:07:08 localhost kernel: hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM
drive
Aug 10 14:07:08 localhost kernel: hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
Aug 10 14:07:08 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 10 14:07:08 localhost kernel: hda: max request size: 128KiB
Aug 10 14:07:08 localhost kernel: hda: 40020624 sectors (20490 MB)
w/512KiB Cache, CHS=39703/16/63, UDMA(66)
Aug 10 14:07:08 localhost kernel:  hda: hda1 hda2 hda3
Aug 10 14:07:08 localhost kernel: hdb: max request size: 128KiB
Aug 10 14:07:08 localhost kernel: hdb: 160086528 sectors (81964 MB)
w/2048KiB Cache, CHS=65535/16/63, UDMA(100)Aug 10 14:07:08 localhost
kernel:  hdb: hdb1
Aug 10 14:07:08 localhost sshd:  succeeded
Aug 10 14:07:08 localhost kernel: hdc: ATAPI 47X DVD-ROM drive, 512kB
Cache, UDMA(33)
Aug 10 14:07:08 localhost kernel: Uniform CD-ROM driver Revision: 3.12
Aug 10 14:07:08 localhost kernel: mice: PS/2 mouse device common for all
mice
Aug 10 14:07:08 localhost kernel: input: ImPS/2 Generic Wheel Mouse on
isa0060/serio1
Aug 10 14:07:08 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq
12
Aug 10 14:07:08 localhost kernel: input: AT Set 2 keyboard on
isa0060/serio0
Aug 10 14:07:08 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq
1
Aug 10 14:07:08 localhost kernel: EISA: Probing bus 0 at Virtual EISA
Bridge
Aug 10 14:07:08 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 10 14:07:08 localhost kernel: IP: routing cache hash table of 2048
buckets, 64Kbytes
Aug 10 14:07:08 localhost kernel: TCP: Hash tables configured
(established 262144 bind 37449)
Aug 10 14:07:08 localhost kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Aug 10 14:07:08 localhost kernel: EXT2-fs warning (device hda3):
ext2_fill_super: mounting ext3 filesystem as ext2
Aug 10 14:07:08 localhost kernel:
Aug 10 14:07:08 localhost kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Aug 10 14:07:08 localhost kernel: Freeing unused kernel memory: 244k
freed
Aug 10 14:07:08 localhost kernel: Adding 1050832k swap on /dev/hda2. 
Priority:-1 extents:1
Aug 10 14:07:08 localhost kernel: kudzu: numerical sysctl 1 23 is
obsolete.
Aug 10 14:07:06 localhost network: Setting network parameters: 
succeeded
Aug 10 14:07:06 localhost network: Bringing up loopback interface: 
succeeded
Aug 10 14:07:06 localhost ifup: modprobe: Can't open dependencies file
/lib/modules/2.6.0-test3/modules.dep (No such file or directory)
Aug 10 14:07:06 localhost network: Bringing up interface eth0: 
succeeded
Aug 10 14:07:09 localhost xinetd[1079]: xinetd Version 2.3.11 started
with libwrap loadavg options compiled in.Aug 10 14:07:09 localhost
xinetd[1079]: Started working: 1 available service
Aug 10 14:07:11 localhost xinetd: xinetd startup succeeded
Aug 10 14:07:12 localhost sendmail: sendmail startup succeeded
Aug 10 14:07:12 localhost sendmail: sm-client startup succeeded
Aug 10 14:07:12 localhost gpm: gpm startup succeeded
Aug 10 14:07:13 localhost crond: crond startup succeeded
Aug 10 14:07:16 localhost cups: cupsd startup succeeded
Aug 10 14:07:17 localhost xfs: xfs startup succeeded
Aug 10 14:07:17 localhost anacron: anacron startup succeeded
Aug 10 14:07:17 localhost atd: atd startup succeeded
Aug 10 14:07:17 localhost rhnsd[1338]: Red Hat Network Services Daemon
starting up.
Aug 10 14:07:17 localhost rhnsd: rhnsd startup succeeded
Aug 10 14:07:17 localhost xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Aug 10 14:07:17 localhost kernel: hdb: set_drive_speed_status:
status=0xd0 { Busy }
Aug 10 14:07:17 localhost kernel: blk: queue c1b59290, I/O limit 4095Mb
(mask 0xffffffff)
Aug 10 14:07:20 localhost kernel: hdb: channel busy
Aug 10 14:07:37 localhost kernel: hda: dma_timer_expiry: dma status ==
0x60
Aug 10 14:07:37 localhost kernel: hda: DMA timeout retry
Aug 10 14:07:37 localhost kernel: hda: timeout waiting for DMA
Aug 10 14:07:37 localhost kernel: bad: scheduling while atomic!
Aug 10 14:07:37 localhost kernel: Call Trace:
Aug 10 14:07:37 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:37 localhost kernel:  [<c011d729>] schedule+0x6e4/0x6e9
Aug 10 14:07:37 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:37 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:37 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:37 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:37 localhost kernel:  [<c0107308>] cpu_idle+0x38/0x3a
Aug 10 14:07:37 localhost kernel:  [<c039672a>] start_kernel+0x1bd/0x215
Aug 10 14:07:37 localhost kernel:  [<c039643f>]
unknown_bootoption+0x0/0xfa
Aug 10 14:07:37 localhost kernel:
Aug 10 14:07:37 localhost kernel: bad: scheduling while atomic!
Aug 10 14:07:37 localhost kernel: Call Trace:
Aug 10 14:07:37 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:37 localhost kernel:  [<c011d729>] schedule+0x6e4/0x6e9
Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c0107308>] cpu_idle+0x38/0x3a
Aug 10 14:07:38 localhost kernel:  [<c039672a>] start_kernel+0x1bd/0x215
Aug 10 14:07:38 localhost kernel:  [<c039643f>]
unknown_bootoption+0x0/0xfa
Aug 10 14:07:38 localhost kernel:
Aug 10 14:07:38 localhost kernel: bad: scheduling while atomic!
Aug 10 14:07:38 localhost kernel: Call Trace:
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c011d729>] schedule+0x6e4/0x6e9
Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c0107308>] cpu_idle+0x38/0x3a
Aug 10 14:07:38 localhost kernel:  [<c039672a>] start_kernel+0x1bd/0x215
Aug 10 14:07:38 localhost kernel:  [<c039643f>]
unknown_bootoption+0x0/0xfa
Aug 10 14:07:38 localhost kernel:
Aug 10 14:07:38 localhost kernel: bad: scheduling while atomic!
Aug 10 14:07:38 localhost kernel: Call Trace:
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c011d729>] schedule+0x6e4/0x6e9
Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
Aug 10 14:07:38 localhost kernel:  [<c0107308>] cpu_idle+0x38/0x3a
Aug 10 14:07:38 localhost kernel:  [<c039672a>] start_kernel+0x1bd/0x215
Aug 10 14:07:38 localhost kernel:  [<c039643f>]
unknown_bootoption+0x0/0xfa

... the bad: scheduling while atomic!  keeps blasting away at my screen
until I shutdown.  I *do* shutdown right away before the system decides
to really hang (and take out my root partition on next startup like it
has done when I get these atomic crashes).  Long before any real testing
begins, nasty bugs like this have to go!


-- 
Bob Gill <gillb4@telusplanet.net>

