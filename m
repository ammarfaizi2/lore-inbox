Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTAUW4t>; Tue, 21 Jan 2003 17:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTAUW4t>; Tue, 21 Jan 2003 17:56:49 -0500
Received: from user-24-214-12-221.knology.net ([24.214.12.221]:5082 "EHLO
	localdomain") by vger.kernel.org with ESMTP id <S267274AbTAUW4m>;
	Tue, 21 Jan 2003 17:56:42 -0500
Message-ID: <000d01c2c1a1$9a9756a0$0900000a@citynetwireless.net>
From: "Ro0tSiEgE" <lkml@ro0tsiege.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ac1 Kernel Oops: 0002
Date: Tue, 21 Jan 2003 17:05:33 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this have something to do with the problems in ext{2,3} in 2.4.20?
This happened during an rsync mirror of Debian GNU/Linux, the last
modification time of my rsync log file was 1 minute after the kernel oopsed.
What exactly (if that can be told) caused this?

Attached kern.log output with the oops first, then boot msgs.
--snip--
Jan 20 14:37:52 citynetwireless kernel: device eth0 entered promiscuous mode
Jan 20 14:38:03 citynetwireless kernel: device eth0 left promiscuous mode
Jan 20 14:38:17 citynetwireless kernel: device eth1 entered promiscuous mode
Jan 20 14:38:19 citynetwireless kernel: device eth1 left promiscuous mode
Jan 20 17:47:12 citynetwireless kernel: Unable to handle kernel paging
request at virtual address 0100541d
Jan 20 17:47:12 citynetwireless kernel: printing eip:
Jan 20 17:47:12 citynetwireless kernel: c011543b
Jan 20 17:47:12 citynetwireless kernel: *pde = 00000000
Jan 20 17:47:12 citynetwireless kernel: Oops: 0002
Jan 20 17:47:12 citynetwireless kernel: CPU: 0
Jan 20 17:47:12 citynetwireless kernel: EIP: 0010:[do_page_fault+107/1076]
Not tainted
Jan 20 17:47:12 citynetwireless kernel: EFLAGS: 00010202
Jan 20 17:47:12 citynetwireless kernel: eax: 0100541d ebx: 01005401 ecx:
00000018 edx: f7a42000
Jan 20 17:47:12 citynetwireless kernel: esi: 0100541d edi: 0100541d ebp:
00000000 esp: f7a4208c
Jan 20 17:47:12 citynetwireless kernel: ds: 0018 es: 0018 ss: 0018
Jan 20 17:47:12 citynetwireless kernel: Process mysqld (pid: 271,
stackpage=f7a41000)
Jan 20 17:47:12 citynetwireless kernel: Stack: f7a42000 00000002 c01153d0
00000000 0a313d65 f7a42000 31333231 35313120
Jan 20 17:47:12 citynetwireless kernel: 00030001 626f7270 6e652065 0a646564
32303032 31333231 35313120 20363238
Jan 20 17:47:12 citynetwireless kernel: 72617473 732f2074 2f6e6962 70646f6d
65626f72 206b2d20 2f20432d 2f637465
Jan 20 17:47:12 citynetwireless kernel: Call Trace: [do_page_fault+0/1076]
[error_code+52/60] [do_page_fault+107/1076] [do_page_fault+0/1076]
[error_code+52/60]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+107/1076]
[do_page_fault+0/1076] [error_code+52/60] [do_page_fault+107/1076]
[do_page_fault+0/1076] [error_code+52/60]
Jan 20 17:47:12 citynetwireless last message repeated 7 times
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+107/1076]
[do_page_fault+0/1076] [error_code+52/60] [do_page_fault+107/1076]
[do_page_fault+0/1076] [end_buffer_io_async+0/160]
Jan 20 17:47:12 citynetwireless kernel: [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [end_buffer_io_async+0/160]
[error_code+52/60]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+107/1076]
[do_page_fault+0/1076] [journal_end_buffer_io_sync+0/32] [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
Jan 20 17:47:12 citynetwireless kernel: [journal_end_buffer_io_sync+0/32]
[error_code+52/60] [do_page_fault+107/1076] [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [error_code+52/60]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+107/1076]
[do_page_fault+0/1076] [end_buffer_io_async+0/160] [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
Jan 20 17:47:12 citynetwireless kernel: [end_buffer_io_async+0/160]
[error_code+52/60] [do_page_fault+107/1076] [do_page_fault+0/1076]
[end_buffer_io_async+0/160] [error_code+52/60]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+107/1076]
[do_page_fault+0/1076] [end_buffer_io_async+0/160] [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
Jan 20 17:47:12 citynetwireless kernel: [end_buffer_io_async+0/160]
[error_code+52/60] [do_page_fault+107/1076] [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [error_code+52/60]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+107/1076]
[do_page_fault+0/1076] [error_code+52/60] [do_page_fault+107/1076]
[do_page_fault+0/1076] [journal_end_buffer_io_sync+0/32]
Jan 20 17:47:12 citynetwireless kernel: [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [error_code+52/60]
[do_page_fault+107/1076]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32]
Jan 20 17:47:12 citynetwireless kernel: [error_code+52/60]
[do_page_fault+107/1076] [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [error_code+52/60]
[do_page_fault+107/1076]
Jan 20 17:47:12 citynetwireless kernel: [do_page_fault+0/1076]
[journal_end_buffer_io_sync+0/32] [journal_end_buffer_io_sync+0/32]
[error_code+52/60] [journal_end_buffer_io_sync+0/32]
Jan 20 17:47:12 citynetwireless kernel:
Jan 20 17:47:12 citynetwireless kernel: Code: ff 00 0f 88 c1 03 00 00 56 53
e8 06 2a 01 00 89 c5 83 c4 08
Jan 21 16:45:31 citynetwireless kernel: klogd 1.4.1#10, log source =
/proc/kmsg started.
Jan 21 16:45:31 citynetwireless kernel: Inspecting
/boot/System.map-2.4.20-ac1
Jan 21 16:45:31 citynetwireless kernel: Loaded 21227 symbols from
/boot/System.map-2.4.20-ac1.
Jan 21 16:45:31 citynetwireless kernel: Symbols match kernel version 2.4.20.
Jan 21 16:45:31 citynetwireless kernel: No module symbols loaded.
Jan 21 16:45:31 citynetwireless kernel: Linux version 2.4.20-ac1 (root@noc)
(gcc version 2.95.4 20011002 (Debian prerelease)) #4 Mon Dec 9 20:56:49 CST
2002
Jan 21 16:45:31 citynetwireless kernel: BIOS-provided physical RAM map:
Jan 21 16:45:31 citynetwireless kernel: BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Jan 21 16:45:31 citynetwireless kernel: BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Jan 21 16:45:31 citynetwireless kernel: BIOS-e820: 0000000000100000 -
000000003fff0000 (usable)
Jan 21 16:45:31 citynetwireless kernel: BIOS-e820: 000000003fff0000 -
000000003fff3000 (ACPI NVS)
Jan 21 16:45:31 citynetwireless kernel: BIOS-e820: 000000003fff3000 -
0000000040000000 (ACPI data)
Jan 21 16:45:31 citynetwireless kernel: BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Jan 21 16:45:31 citynetwireless kernel: 127MB HIGHMEM available.
Jan 21 16:45:31 citynetwireless kernel: 896MB LOWMEM available.
Jan 21 16:45:31 citynetwireless kernel: On node 0 totalpages: 262128
Jan 21 16:45:31 citynetwireless kernel: zone(0): 4096 pages.
Jan 21 16:45:31 citynetwireless kernel: zone(1): 225280 pages.
Jan 21 16:45:31 citynetwireless kernel: zone(2): 32752 pages.
Jan 21 16:45:31 citynetwireless kernel: Kernel command line: auto
BOOT_IMAGE=Linux ro root=301
Jan 21 16:45:31 citynetwireless kernel: Local APIC disabled by BIOS --
reenabling.
Jan 21 16:45:31 citynetwireless kernel: Found and enabled local APIC!
Jan 21 16:45:31 citynetwireless kernel: Initializing CPU#0
Jan 21 16:45:31 citynetwireless kernel: Detected 1668.711 MHz processor.
Jan 21 16:45:31 citynetwireless kernel: Console: colour VGA+ 80x25
Jan 21 16:45:31 citynetwireless kernel: Calibrating delay loop... 3329.22
BogoMIPS
Jan 21 16:45:31 citynetwireless kernel: Memory: 1027360k/1048512k available
(1961k kernel code, 17572k reserved, 621k data, 288k init, 131008k highmem)
Jan 21 16:45:31 citynetwireless kernel: Dentry cache hash table entries:
131072 (order: 8, 1048576 bytes)
Jan 21 16:45:31 citynetwireless kernel: Inode cache hash table entries:
65536 (order: 7, 524288 bytes)
Jan 21 16:45:31 citynetwireless kernel: Mount cache hash table entries: 512
(order: 0, 4096 bytes)
Jan 21 16:45:31 citynetwireless kernel: ramfs: mounted with options:
<defaults>
Jan 21 16:45:31 citynetwireless kernel: ramfs: max_pages=128819
max_file_pages=0 max_inodes=0 max_dentries=128819
Jan 21 16:45:31 citynetwireless kernel: Buffer cache hash table entries:
65536 (order: 6, 262144 bytes)
Jan 21 16:45:31 citynetwireless kernel: Page-cache hash table entries:
262144 (order: 8, 1048576 bytes)
Jan 21 16:45:31 citynetwireless kernel: CPU: L1 I Cache: 64K (64
bytes/line), D cache 64K (64 bytes/line)
Jan 21 16:45:31 citynetwireless kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jan 21 16:45:31 citynetwireless kernel: Intel machine check architecture
supported.
Jan 21 16:45:31 citynetwireless kernel: Intel machine check reporting
enabled on CPU#0.
Jan 21 16:45:31 citynetwireless kernel: CPU: After generic, caps: 0383fbff
c1c3fbff 00000000 00000000
Jan 21 16:45:31 citynetwireless kernel: CPU: Common caps: 0383fbff c1c3fbff
00000000 00000000
Jan 21 16:45:31 citynetwireless kernel: CPU: AMD Athlon(tm) XP 2000+
stepping 02
Jan 21 16:45:31 citynetwireless kernel: Enabling fast FPU save and
restore... done.
Jan 21 16:45:31 citynetwireless kernel: Enabling unmasked SIMD FPU exception
support... done.
Jan 21 16:45:31 citynetwireless kernel: Checking 'hlt' instruction... OK.
Jan 21 16:45:31 citynetwireless kernel: POSIX conformance testing by UNIFIX
Jan 21 16:45:31 citynetwireless kernel: enabled ExtINT on CPU#0
Jan 21 16:45:31 citynetwireless kernel: ESR value before enabling vector:
00000000
Jan 21 16:45:31 citynetwireless kernel: ESR value after enabling vector:
00000000
Jan 21 16:45:31 citynetwireless kernel: Using local APIC timer interrupts.
Jan 21 16:45:31 citynetwireless kernel: calibrating APIC timer ...
Jan 21 16:45:31 citynetwireless kernel: ..... CPU clock speed is 1668.8019
MHz.
Jan 21 16:45:31 citynetwireless kernel: ..... host bus clock speed is
267.0083 MHz.
Jan 21 16:45:31 citynetwireless kernel: cpu: 0, clocks: 2670083, slice:
1335041
Jan 21 16:45:31 citynetwireless kernel:
CPU0<T0:2670080,T1:1335024,D:15,S:1335041,C:2670083>
Jan 21 16:45:31 citynetwireless kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Jan 21 16:45:31 citynetwireless kernel: mtrr: detected mtrr type: Intel
Jan 21 16:45:31 citynetwireless kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb690, last bus=1
Jan 21 16:45:31 citynetwireless kernel: PCI: Using configuration type 1
Jan 21 16:45:31 citynetwireless kernel: PCI: Probing PCI hardware
Jan 21 16:45:31 citynetwireless kernel: PCI: Using IRQ router VIA
[1106/0686] at 00:07.0
Jan 21 16:45:31 citynetwireless kernel: PCI: Disabling Via external APIC
routing
Jan 21 16:45:31 citynetwireless kernel: Linux NET4.0 for Linux 2.4
Jan 21 16:45:31 citynetwireless kernel: Based upon Swansea University
Computer Society NET3.039
Jan 21 16:45:31 citynetwireless kernel: Initializing RT netlink socket
Jan 21 16:45:31 citynetwireless kernel: IA-32 Microcode Update Driver: v1.11
<tigran@veritas.com>
Jan 21 16:45:31 citynetwireless kernel: apm: BIOS version 1.2 Flags 0x07
(Driver version 1.16)
Jan 21 16:45:31 citynetwireless kernel: Starting kswapd
Jan 21 16:45:31 citynetwireless kernel: allocated 32 pages and 32 bhs
reserved for the highmem bounces
Jan 21 16:45:31 citynetwireless kernel: VFS: Disk quotas vdquot_6.5.1
Jan 21 16:45:31 citynetwireless kernel: Journalled Block Device driver
loaded
Jan 21 16:45:31 citynetwireless kernel: devfs: v1.12c (20020818) Richard
Gooch (rgooch@atnf.csiro.au)
Jan 21 16:45:31 citynetwireless kernel: devfs: boot_options: 0x1
Jan 21 16:45:31 citynetwireless kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Jan 21 16:45:31 citynetwireless kernel: NTFS driver v1.1.22 [Flags: R/O]
Jan 21 16:45:31 citynetwireless kernel: udf: registering filesystem
Jan 21 16:45:31 citynetwireless kernel: Detected PS/2 Mouse Port.
Jan 21 16:45:31 citynetwireless kernel: pty: 256 Unix98 ptys configured
Jan 21 16:45:31 citynetwireless kernel: Serial driver version 5.05c
(2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jan 21 16:45:31 citynetwireless kernel: ttyS00 at 0x03f8 (irq = 4) is a
16550A
Jan 21 16:45:31 citynetwireless kernel: ttyS01 at 0x02f8 (irq = 3) is a
16550A
Jan 21 16:45:31 citynetwireless kernel: Real Time Clock Driver v1.10e
Jan 21 16:45:31 citynetwireless kernel: Non-volatile memory driver v1.2
Jan 21 16:45:31 citynetwireless kernel: Floppy drive(s): fd0 is 1.44M
Jan 21 16:45:31 citynetwireless kernel: floppy0: no floppy controllers found
Jan 21 16:45:31 citynetwireless kernel: SLIP: version 0.8.4-NET3.019-NEWTTY
(dynamic channels, max=256) (6 bit encapsulation enabled).
Jan 21 16:45:31 citynetwireless kernel: CSLIP: code copyright 1989 Regents
of the University of California.
Jan 21 16:45:31 citynetwireless kernel: SLIP linefill/keepalive option.
Jan 21 16:45:31 citynetwireless kernel: RAMDISK driver initialized: 16 RAM
disks of 4096K size 1024 blocksize
Jan 21 16:45:31 citynetwireless kernel: loop: loaded (max 8 devices)
Jan 21 16:45:31 citynetwireless kernel: eepro100.c:v1.09j-t 9/29/99 Donald
Becker http://www.scyld.com/network/eepro100.html
Jan 21 16:45:31 citynetwireless kernel: eepro100.c: $Revision: 1.36 $
2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jan 21 16:45:31 citynetwireless kernel: PCI: Found IRQ 12 for device 00:09.0
Jan 21 16:45:31 citynetwireless kernel: eth0: Intel Corp. 82557/8/9
[Ethernet Pro 100], 00:02:B3:8A:2A:F1, IRQ 12.
Jan 21 16:45:31 citynetwireless kernel: Board assembly 751767-004, Physical
connectors present: RJ45
Jan 21 16:45:31 citynetwireless kernel: Primary interface chip i82555 PHY
#1.
Jan 21 16:45:31 citynetwireless kernel: Secondary interface chip i82555.
Jan 21 16:45:31 citynetwireless kernel: General self-test: passed.
Jan 21 16:45:31 citynetwireless kernel: Serial sub-system self-test: passed.
Jan 21 16:45:31 citynetwireless kernel: Internal registers self-test:
passed.
Jan 21 16:45:31 citynetwireless kernel: ROM checksum self-test: passed
(0x3258698e).
Jan 21 16:45:31 citynetwireless kernel: PCI: Found IRQ 10 for device 00:0b.0
Jan 21 16:45:31 citynetwireless kernel: PCI: Sharing IRQ 10 with 00:08.0
Jan 21 16:45:31 citynetwireless kernel: eth1: Intel Corp. 82557/8/9
[Ethernet Pro 100] (#2), 00:02:B3:AC:BB:4B, IRQ 10.
Jan 21 16:45:31 citynetwireless kernel: Board assembly 751767-004, Physical
connectors present: RJ45
Jan 21 16:45:31 citynetwireless kernel: Primary interface chip i82555 PHY
#1.
Jan 21 16:45:31 citynetwireless kernel: Secondary interface chip i82555.
Jan 21 16:45:31 citynetwireless kernel: General self-test: passed.
Jan 21 16:45:31 citynetwireless kernel: Serial sub-system self-test: passed.
Jan 21 16:45:31 citynetwireless kernel: Internal registers self-test:
passed.
Jan 21 16:45:31 citynetwireless kernel: ROM checksum self-test: passed
(0x3258698e).
Jan 21 16:45:31 citynetwireless kernel: PCI: Found IRQ 11 for device 00:0d.0
Jan 21 16:45:31 citynetwireless kernel: eth2: Intel Corp. 82557/8/9
[Ethernet Pro 100] (#3), 00:02:B3:AC:BD:FA, IRQ 11.
Jan 21 16:45:31 citynetwireless kernel: Board assembly 751767-004, Physical
connectors present: RJ45
Jan 21 16:45:31 citynetwireless kernel: Primary interface chip i82555 PHY
#1.
Jan 21 16:45:31 citynetwireless kernel: Secondary interface chip i82555.
Jan 21 16:45:31 citynetwireless kernel: General self-test: passed.
Jan 21 16:45:31 citynetwireless kernel: Serial sub-system self-test: passed.
Jan 21 16:45:31 citynetwireless kernel: Internal registers self-test:
passed.
Jan 21 16:45:31 citynetwireless kernel: ROM checksum self-test: passed
(0x3258698e).
Jan 21 16:45:31 citynetwireless kernel: PPP generic driver version 2.4.2
Jan 21 16:45:31 citynetwireless kernel: PPP Deflate Compression module
registered
Jan 21 16:45:31 citynetwireless kernel: PPP BSD Compression module
registered
Jan 21 16:45:31 citynetwireless kernel: bond0 registered without MII link
monitoring, in bonding mode.
Jan 21 16:45:31 citynetwireless kernel: Equalizer1996: $Revision: 1.2.1 $
$Date: 1996/09/22 13:52:00 $ Simon Janes (simon@ncm.com)
Jan 21 16:45:31 citynetwireless kernel: Universal TUN/TAP device driver 1.5
(C)1999-2002 Maxim Krasnyansky
Jan 21 16:45:31 citynetwireless kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00beta-2.4
Jan 21 16:45:31 citynetwireless kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Jan 21 16:45:31 citynetwireless kernel: VP_IDE: IDE controller at PCI slot
00:07.1
Jan 21 16:45:31 citynetwireless kernel: VP_IDE: chipset revision 6
Jan 21 16:45:31 citynetwireless kernel: VP_IDE: not 100%% native mode: will
probe irqs later
Jan 21 16:45:31 citynetwireless kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Jan 21 16:45:31 citynetwireless kernel: VP_IDE: VIA vt82c686b (rev 40) IDE
UDMA100 controller on pci00:07.1
Jan 21 16:45:31 citynetwireless kernel: ide0: BM-DMA at 0xd400-0xd407, BIOS
settings: hda:DMA, hdb:DMA
Jan 21 16:45:31 citynetwireless kernel: ide1: BM-DMA at 0xd408-0xd40f, BIOS
settings: hdc:pio, hdd:pio
Jan 21 16:45:31 citynetwireless kernel: hda: WDC WD1200JB-75CRA0, ATA DISK
drive
Jan 21 16:45:31 citynetwireless kernel: hdb: WDC WD1200JB-75CRA0, ATA DISK
drive
Jan 21 16:45:31 citynetwireless kernel: hda: DMA disabled
Jan 21 16:45:31 citynetwireless kernel: blk: queue c040c140, I/O limit
4095Mb (mask 0xffffffff)
Jan 21 16:45:31 citynetwireless kernel: hdb: DMA disabled
Jan 21 16:45:31 citynetwireless kernel: blk: queue c040c28c, I/O limit
4095Mb (mask 0xffffffff)
Jan 21 16:45:31 citynetwireless kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 21 16:45:31 citynetwireless kernel: hda: host protected area => 1
Jan 21 16:45:31 citynetwireless kernel: hda: 234441648 sectors (120034 MB)
w/8192KiB Cache, CHS=14593/255/63, UDMA(100)
Jan 21 16:45:31 citynetwireless kernel: hdb: host protected area => 1
Jan 21 16:45:31 citynetwireless kernel: hdb: 234441648 sectors (120034 MB)
w/8192KiB Cache, CHS=14593/255/63, UDMA(100)
Jan 21 16:45:31 citynetwireless kernel: ide-floppy driver 0.99.newide
Jan 21 16:45:31 citynetwireless kernel: Partition check:
Jan 21 16:45:31 citynetwireless kernel: /dev/ide/host0/bus0/target0/lun0: p1
Jan 21 16:45:31 citynetwireless kernel: /dev/ide/host0/bus0/target1/lun0: p1
Jan 21 16:45:31 citynetwireless kernel: ide-floppy driver 0.99.newide
Jan 21 16:45:31 citynetwireless kernel: SCSI subsystem driver Revision: 1.00
Jan 21 16:45:31 citynetwireless kernel: kmod: failed to exec
/sbin/modprobe -s -k scsi_hostadapter, errno = 2
Jan 21 16:45:31 citynetwireless kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jan 21 16:45:31 citynetwireless kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jan 21 16:45:31 citynetwireless kernel: IP: routing cache hash table of 8192
buckets, 64Kbytes
Jan 21 16:45:31 citynetwireless kernel: TCP: Hash tables configured
(established 262144 bind 65536)
Jan 21 16:45:31 citynetwireless kernel: IPv4 over IPv4 tunneling driver
Jan 21 16:45:31 citynetwireless kernel: GRE over IPv4 tunneling driver
Jan 21 16:45:31 citynetwireless kernel: Linux IP multicast router 0.06 plus
PIM-SM
Jan 21 16:45:31 citynetwireless kernel: klips_info:ipsec_init: KLIPS
startup, FreeS/WAN IPSec version: 1.99
Jan 21 16:45:31 citynetwireless kernel: ip_conntrack version 2.1 (8191
buckets, 65528 max) - 292 bytes per conntrack
Jan 21 16:45:31 citynetwireless kernel: ip_tables: (C) 2000-2002 Netfilter
core team
Jan 21 16:45:31 citynetwireless kernel: arp_tables: (C) 2002 David S. Miller
Jan 21 16:45:31 citynetwireless kernel: NET4: Unix domain sockets 1.0/SMP
for Linux NET4.0.
Jan 21 16:45:31 citynetwireless kernel: EXT3-fs: INFO: recovery required on
readonly filesystem.
Jan 21 16:45:31 citynetwireless kernel: EXT3-fs: write access will be
enabled during recovery.
Jan 21 16:45:31 citynetwireless kernel: kjournald starting. Commit interval
5 seconds
Jan 21 16:45:31 citynetwireless kernel: EXT3-fs: ide0(3,1): orphan cleanup
on readonly fs
Jan 21 16:45:31 citynetwireless kernel: ext3_orphan_cleanup: deleting
unreferenced inode 1015872
Jan 21 16:45:31 citynetwireless kernel: ext3_orphan_cleanup: deleting
unreferenced inode 163848
Jan 21 16:45:31 citynetwireless kernel: ext3_orphan_cleanup: deleting
unreferenced inode 9371737
Jan 21 16:45:31 citynetwireless kernel: ext3_orphan_cleanup: deleting
unreferenced inode 14352390
Jan 21 16:45:31 citynetwireless kernel: ext3_orphan_cleanup: deleting
unreferenced inode 4341797
Jan 21 16:45:31 citynetwireless kernel: ext3_orphan_cleanup: deleting
unreferenced inode 2523145
Jan 21 16:45:31 citynetwireless kernel: EXT3-fs: ide0(3,1): 6 orphan inodes
deleted
Jan 21 16:45:31 citynetwireless kernel: EXT3-fs: recovery complete.
Jan 21 16:45:31 citynetwireless kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Jan 21 16:45:31 citynetwireless kernel: VFS: Mounted root (ext3 filesystem)
readonly.
Jan 21 16:45:31 citynetwireless kernel: Mounted devfs on /dev
Jan 21 16:45:31 citynetwireless kernel: Freeing unused kernel memory: 288k
freed
Jan 21 16:45:31 citynetwireless kernel: Adding Swap: 127996k swap-space
(priority -1)
Jan 21 16:45:31 citynetwireless kernel: EXT3 FS 2.4-0.9.19, 19 August 2002
on ide0(3,1), internal journal
Jan 21 16:47:07 citynetwireless kernel: spurious 8259A interrupt: IRQ7.
--snip--



