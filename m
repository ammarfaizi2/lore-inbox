Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSJHXPx>; Tue, 8 Oct 2002 19:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSJHXPo>; Tue, 8 Oct 2002 19:15:44 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:17144 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S261475AbSJHXOB>; Tue, 8 Oct 2002 19:14:01 -0400
Message-ID: <3DA36807.789E93F0@eyal.emu.id.au>
Date: Wed, 09 Oct 2002 09:19:35 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: scsi crash
References: <05256C4C.001A6B46.00@dns.searchsoftware.com> <3DA2B6B1.DB194DD6@eyal.emu.id.au> <200210081754.g98Hsnp25324@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Kernel version? config?

Oh, forgot I trimmed the boot log. This is 2.4.19. Only very
few compiled in modules (e.g. IDE) and everything else is a
module.

------------------ what was done ------------------
(boot)
(login)
$ su -
# modprobe st
# lsmod
Module                  Size  Used by    Not tainted
sym53c8xx              57636   0  (autoclean) (unused)
st                     27252   0  (unused)
scsi_mod               85720   2  [sym53c8xx st]
autofs                  9412   0  (autoclean) (unused)
nfs                    75644   1  (autoclean)
lockd                  47904   1  (autoclean) [nfs]
sunrpc                 63348   1  (autoclean) [nfs lockd]
8139too                13760   1
mii                     1120   0  [8139too]
af_packet               9352   1  (autoclean)
floppy                 47488   0  (autoclean)
ext3                   59744   1  (autoclean)
jbd                    40184   1  (autoclean) [ext3]
md                     57920   0  (unused)
rtc                     6844   0  (autoclean)
unix                   15588  10  (autoclean)
# mt -f /dev/nst0 status

---------------------------------- /var/log/messages
--------------------------------
Oct  8 13:57:05 ssa28 syslogd 1.4.1: restart.
Oct  8 13:57:05 ssa28 syslog: syslogd startup succeeded
Oct  8 13:57:05 ssa28 kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Oct  8 13:57:05 ssa28 kernel: Inspecting /boot/System.map-2.4.19
Oct  8 13:57:05 ssa28 syslog: klogd startup succeeded
Oct  8 13:57:06 ssa28 portmap: portmap startup succeeded
Oct  8 13:57:06 ssa28 kernel: Loaded 14441 symbols from
/boot/System.map-2.4.19.
Oct  8 13:57:06 ssa28 kernel: Symbols match kernel version 2.4.19.
Oct  8 13:57:06 ssa28 kernel: Loaded 117 symbols from 9 modules.
Oct  8 13:57:06 ssa28 kernel: Linux version 2.4.19 (root@ssa28) (gcc
version
2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Fri Oct 4 16:23:58 EST
2002
Oct  8 13:57:06 ssa28 kernel: BIOS-provided physical RAM map:
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 0000000000100000 -
0000000047ffc000 (usable)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 0000000047ffc000 -
0000000048000000 (ACPI data)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 00000000fec00000 -
00000000fec10000 (reserved)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 00000000fee00000 -
00000000fee10000 (reserved)
Oct  8 13:57:06 ssa28 kernel:  BIOS-e820: 00000000fff80000 -
0000000100000000 (reserved)
Oct  8 13:57:06 ssa28 kernel: 255MB HIGHMEM available.
Oct  8 13:57:06 ssa28 kernel: 896MB LOWMEM available.
Oct  8 13:57:06 ssa28 kernel: found SMP MP-table at 000f4fd0
Oct  8 13:57:06 ssa28 rpc.statd[584]: Version 0.3.1 Starting
Oct  8 13:57:06 ssa28 kernel: hm, page 000f4000 reserved twice.
Oct  8 13:57:06 ssa28 kernel: hm, page 000f5000 reserved twice.
Oct  8 13:57:06 ssa28 kernel: hm, page 000fc000 reserved twice.
Oct  8 13:57:06 ssa28 kernel: hm, page 000fd000 reserved twice.
Oct  8 13:57:06 ssa28 kernel: Advanced speculative caching feature not
present
Oct  8 13:57:06 ssa28 nfslock: rpc.statd startup succeeded
Oct  8 13:57:06 ssa28 kernel: On node 0 totalpages: 294908
Oct  8 13:57:06 ssa28 kernel: zone(0): 4096 pages.
Oct  8 13:57:06 ssa28 kernel: zone(1): 225280 pages.
Oct  8 13:57:06 ssa28 kernel: zone(2): 65532 pages.
Oct  8 13:57:06 ssa28 kernel: Intel MultiProcessor Specification v1.4
Oct  8 13:57:06 ssa28 kernel:     Virtual Wire compatibility mode.
Oct  8 13:57:06 ssa28 kernel: OEM ID: COMPAQ   Product ID: PROLIANT    
APIC at:  0xFEE00000
Oct  8 13:57:06 ssa28 kernel: Processor #3 Pentium(tm) Pro APIC version
16
Oct  8 13:57:06 ssa28 kernel: Processor #0 Pentium(tm) Pro APIC version
16
Oct  8 13:57:06 ssa28 kernel: Processor #1 Pentium(tm) Pro APIC version
16
Oct  8 13:57:06 ssa28 kernel: Processor #2 Pentium(tm) Pro APIC version
16
Oct  8 13:57:06 ssa28 kernel: I/O APIC #8 Version 17 at 0xFEC00000.
Oct  8 13:57:06 ssa28 kernel: Processors: 4
Oct  8 13:57:06 ssa28 kernel: Kernel command line:
Oct  8 13:57:06 ssa28 kernel: Initializing CPU#0
Oct  8 13:57:06 ssa28 kernel: Detected 500.010 MHz processor.
Oct  8 13:57:06 ssa28 kernel: Console: colour VGA+ 80x25
Oct  8 13:57:06 ssa28 kernel: Calibrating delay loop... 996.14 BogoMIPS
Oct  8 13:57:06 ssa28 kernel: Memory: 1163596k/1179632k available (895k
kernel code, 15648k reserved, 380k data, 88k init, 262128k highmem)
Oct  8 13:57:06 ssa28 kernel: Dentry cache hash table entries: 262144
(order: 9, 2097152 bytes)
Oct  8 13:57:06 ssa28 kernel: Inode cache hash table entries: 131072
(order: 8, 1048576 bytes)
Oct  8 13:57:06 ssa28 kernel: Mount-cache hash table entries: 32768
(order: 6, 262144 bytes)
Oct  8 13:57:06 ssa28 kernel: Buffer-cache hash table entries: 131072
(order: 7, 524288 bytes)
Oct  8 13:57:06 ssa28 kernel: Page-cache hash table entries: 524288
(order: 9, 2097152 bytes)
Oct  8 13:57:06 ssa28 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 13:57:06 ssa28 kernel: CPU: L2 cache: 512K
Oct  8 13:57:06 ssa28 keytable: Loading keymap:  succeeded
Oct  8 13:57:06 ssa28 kernel: Enabling fast FPU save and restore...
done.
Oct  8 13:57:06 ssa28 kernel: Enabling unmasked SIMD FPU exception
support... done.
Oct  8 13:57:06 ssa28 kernel: Checking 'hlt' instruction... OK.
Oct  8 13:57:06 ssa28 kernel: POSIX conformance testing by UNIFIX
Oct  8 13:57:06 ssa28 kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Oct  8 13:57:06 ssa28 kernel: mtrr: detected mtrr type: Intel
Oct  8 13:57:06 ssa28 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 13:57:06 ssa28 kernel: CPU: L2 cache: 512K
Oct  8 13:57:06 ssa28 kernel: CPU0: Intel Pentium III (Katmai) stepping
02
Oct  8 13:57:06 ssa28 kernel: per-CPU timeslice cutoff: 1462.01 usecs.
Oct  8 13:57:06 ssa28 kernel: enabled ExtINT on CPU#0
Oct  8 13:57:06 ssa28 kernel: ESR value before enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: ESR value after enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: Booting processor 1/0 eip 2000
Oct  8 13:57:06 ssa28 kernel: Initializing CPU#1
Oct  8 13:57:06 ssa28 kernel: masked ExtINT on CPU#1
Oct  8 13:57:06 ssa28 kernel: ESR value before enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: ESR value after enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: Calibrating delay loop... 999.42 BogoMIPS
Oct  8 13:57:06 ssa28 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 13:57:06 ssa28 kernel: CPU: L2 cache: 512K
Oct  8 13:57:06 ssa28 kernel: CPU1: Intel Pentium III (Katmai) stepping
03
Oct  8 13:57:06 ssa28 kernel: Booting processor 2/1 eip 2000
Oct  8 13:57:06 ssa28 keytable: Loading system font:  succeeded
Oct  8 13:57:06 ssa28 kernel: Initializing CPU#2
Oct  8 13:57:06 ssa28 kernel: masked ExtINT on CPU#2
Oct  8 13:57:06 ssa28 kernel: ESR value before enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: ESR value after enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: Calibrating delay loop... 999.42 BogoMIPS
Oct  8 13:57:06 ssa28 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 13:57:06 ssa28 kernel: CPU: L2 cache: 512K
Oct  8 13:57:06 ssa28 kernel: CPU2: Intel Pentium III (Katmai) stepping
03
Oct  8 13:57:06 ssa28 kernel: Booting processor 3/2 eip 2000
Oct  8 13:57:06 ssa28 kernel: Initializing CPU#3
Oct  8 13:57:06 ssa28 kernel: masked ExtINT on CPU#3
Oct  8 13:57:06 ssa28 kernel: ESR value before enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: ESR value after enabling vector: 00000000
Oct  8 13:57:06 ssa28 kernel: Calibrating delay loop... 999.42 BogoMIPS
Oct  8 13:57:06 ssa28 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 13:57:06 ssa28 kernel: CPU: L2 cache: 512K
Oct  8 13:57:06 ssa28 kernel: CPU3: Intel Pentium III (Katmai) stepping
03
Oct  8 13:57:06 ssa28 kernel: Total of 4 processors activated (3994.41
BogoMIPS).
Oct  8 13:57:06 ssa28 kernel: ENABLING IO-APIC IRQs
Oct  8 13:57:06 ssa28 kernel: Setting 8 in the phys_id_present_map
Oct  8 13:57:06 ssa28 kernel: ...changing IO-APIC physical APIC ID to 8
... ok.
Oct  8 13:57:06 ssa28 kernel: ..TIMER: vector=0x31 pin1=18 pin2=-1
Oct  8 13:57:06 ssa28 kernel: testing the IO APIC.......................
Oct  8 13:57:06 ssa28 kernel:
Oct  8 13:57:06 ssa28 kernel: .................................... done.
Oct  8 13:57:06 ssa28 kernel: Using local APIC timer interrupts.
Oct  8 13:57:06 ssa28 kernel: calibrating APIC timer ...
Oct  8 13:57:06 ssa28 kernel: ..... CPU clock speed is 500.0167 MHz.
Oct  8 13:57:06 ssa28 kernel: ..... host bus clock speed is 100.0032
MHz.
Oct  8 13:57:06 ssa28 kernel: cpu: 0, clocks: 1000032, slice: 200006
Oct  8 13:57:06 ssa28 kernel:
CPU0<T0:1000032,T1:800016,D:10,S:200006,C:1000032>
Oct  8 13:57:06 ssa28 kernel: cpu: 1, clocks: 1000032, slice: 200006
Oct  8 13:57:06 ssa28 kernel: cpu: 3, clocks: 1000032, slice: 200006
Oct  8 13:57:06 ssa28 kernel: cpu: 2, clocks: 1000032, slice: 200006
Oct  8 13:57:06 ssa28 kernel:
CPU2<T0:1000032,T1:400000,D:14,S:200006,C:1000032>
Oct  8 13:57:06 ssa28 kernel:
CPU3<T0:1000032,T1:200000,D:8,S:200006,C:1000032>
Oct  8 13:57:06 ssa28 kernel:
CPU1<T0:1000032,T1:600016,D:4,S:200006,C:1000032>
Oct  8 13:57:06 ssa28 kernel: checking TSC synchronization across CPUs:
passed.
Oct  8 13:57:06 ssa28 kernel: Waiting on wait_init_idle (map = 0xe)
Oct  8 13:57:06 ssa28 kernel: All processors have done init_idle
Oct  8 13:57:06 ssa28 kernel: PCI: PCI BIOS revision 2.10 entry at
0xf0070, last  bus=14
Oct  8 13:57:06 ssa28 kernel: PCI: Using configuration type 1
Oct  8 13:57:06 ssa28 kernel: PCI: Probing PCI hardware
Oct  8 13:57:06 ssa28 kernel: PCI: Searching for i450NX host bridges on
00:10.0
Oct  8 13:57:06 ssa28 kernel: PCI: Device 00:78 not found by BIOS
Oct  8 13:57:06 ssa28 kernel: PCI: Device 00:80 not found by BIOS
Oct  8 13:57:06 ssa28 kernel: PCI: Device 00:90 not found by BIOS
Oct  8 13:57:06 ssa28 kernel: PCI: Device 00:98 not found by BIOS
Oct  8 13:57:06 ssa28 kernel: PCI: Device 00:a0 not found by BIOS
Oct  8 13:57:06 ssa28 kernel: Linux NET4.0 for Linux 2.4
Oct  8 13:57:06 ssa28 kernel: Based upon Swansea University Computer
Society NET3.039
Oct  8 13:57:06 ssa28 kernel: Initializing RT netlink socket
Oct  8 13:57:06 ssa28 kernel: Starting kswapd
Oct  8 13:57:06 ssa28 kernel: allocated 32 pages and 32 bhs reserved for
the highmem bounces
Oct  8 13:57:06 ssa28 kernel: Detected PS/2 Mouse Port.
Oct  8 13:57:06 ssa28 kernel: pty: 256 Unix98 ptys configured
Oct  8 13:57:06 ssa28 kernel: Serial driver version 5.05c (2001-07-08)
with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Oct  8 13:57:06 ssa28 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Oct  8 13:57:06 ssa28 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Oct  8 13:57:06 ssa28 kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Oct  8 13:57:06 ssa28 kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Oct  8 13:57:06 ssa28 kernel: CMD649: IDE controller on PCI bus 00 dev
10
Oct  8 13:57:07 ssa28 kernel: CMD649: chipset revision 2
Oct  8 13:57:07 ssa28 kernel: CMD649: not 100%% native mode: will probe
irqs later
Oct  8 13:57:07 ssa28 kernel:     ide0: BM-DMA at 0x2020-0x2027, BIOS
settings: hda:pio, hdb:pio
Oct  8 13:57:07 ssa28 kernel:     ide1: BM-DMA at 0x2028-0x202f, BIOS
settings: hdc:pio, hdd:pio
Oct  8 13:57:07 ssa28 kernel: PIIX4: IDE controller on PCI bus 00 dev 79
Oct  8 13:57:07 ssa28 kernel: PIIX4: chipset revision 1
Oct  8 13:57:07 ssa28 kernel: PIIX4: not 100%% native mode: will probe
irqs later
Oct  8 13:57:07 ssa28 kernel:     ide2: BM-DMA at 0x3400-0x3407, BIOS
settings: hde:pio, hdf:pio
Oct  8 13:57:07 ssa28 kernel: PIIX4: IDE controller on PCI bus 00 dev 80
Oct  8 13:57:07 ssa28 kernel: PIIX4: device not capable of full native
PCI mode
Oct  8 13:57:07 ssa28 kernel: PIIX4: device disabled (BIOS)
Oct  8 13:57:07 ssa28 kernel: hda: IBM-DTLA-307060, ATA DISK drive
Oct  8 13:57:07 ssa28 kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Oct  8 13:57:07 ssa28 kernel: hdf: CD-ROM CDU611-Q, ATAPI CD/DVD-ROM
drive
Oct  8 13:57:07 ssa28 kernel: ide0 at 0x2000-0x2007,0x200a on irq 10
Oct  8 13:57:07 ssa28 kernel: ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  8 13:57:07 ssa28 kernel: hda: 120103200 sectors (61493 MB)
w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
Oct  8 13:57:07 ssa28 kernel: Partition check:
Oct  8 13:57:07 ssa28 kernel:  hda: [PTBL] [7476/255/63] hda1 hda2 hda3
hda4
Oct  8 13:57:07 ssa28 kernel: Cronyx Ltd, Synchronous PPP and CISCO HDLC
(c)1994
Oct  8 13:57:07 ssa28 kernel: Linux port (c) 1998 Building Number Three
Ltd & Jan "Yenya" Kasprzak.
Oct  8 13:57:07 ssa28 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct  8 13:57:07 ssa28 kernel: IP Protocols: ICMP, UDP, TCP
Oct  8 13:57:07 ssa28 kernel: IP: routing cache hash table of 16384
buckets, 128Kbytes
Oct  8 13:57:07 ssa28 kernel: TCP: Hash tables configured (established
262144 bind 65536)
Oct  8 13:57:07 ssa28 kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Oct  8 13:57:07 ssa28 kernel: Freeing unused kernel memory: 88k freed
Oct  8 13:57:07 ssa28 kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Oct  8 13:57:07 ssa28 kernel: Real Time Clock Driver v1.10e
Oct  8 13:57:07 ssa28 kernel: Adding Swap: 2097136k swap-space (priority
-1)
Oct  8 13:57:07 ssa28 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Oct  8 13:57:07 ssa28 kernel: Journalled Block Device driver loaded
Oct  8 13:57:07 ssa28 kernel: kjournald starting.  Commit interval 5
seconds
Oct  8 13:57:07 ssa28 kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on
ide0(3,4),internal journal
Oct  8 13:57:07 ssa28 kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Oct  8 13:57:07 ssa28 kernel: SCSI subsystem driver Revision: 1.00
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: at PCI bus 0, device 13,
function 0
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 0
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:57:07 ssa28 random: Initializing random number generator: 
succeeded
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 1
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: rev 0x4 on pci bus 0 device
13 function 0 irq 5
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: ID 7, Fast-20, Parity
Checking
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: rev 0x14 on pci bus 4 device
9 function 0 irq 5
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: ID 7, Fast-20, Parity
Checking
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: rev 0x14 on pci bus 4 device
9 function 1 irq 5
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: ID 7, Fast-20, Parity
Checking
Oct  8 13:57:07 ssa28 kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Oct  8 13:57:07 ssa28 kernel: scsi1 : sym53c8xx-1.7.3c-20010512
Oct  8 13:57:07 ssa28 kernel: scsi2 : sym53c8xx-1.7.3c-20010512
Oct  8 13:57:07 ssa28 kernel:   Vendor: ARCHIVE   Model: Python
28388-XXX  Rev: 4.28
Oct  8 13:57:07 ssa28 kernel:   Type:  
Sequential-Access                  ANSI SCSI revision: 02
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: detaching ...
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: resetting chip
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: detaching ...
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: resetting chip
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: detaching ...
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: resetting chip
Oct  8 13:57:07 ssa28 kernel: scsi : 0 hosts left.
Oct  8 13:57:07 ssa28 kernel: inserting floppy driver for 2.4.19
Oct  8 13:57:07 ssa28 kernel: Floppy drive(s): fd0 is 1.44M
Oct  8 13:57:07 ssa28 kernel: FDC 0 is a National Semiconductor PC87306
Oct  8 13:57:07 ssa28 kernel: parport0: PC-style at 0x3bc [PCSPP]
Oct  8 13:57:07 ssa28 kernel: SCSI subsystem driver Revision: 1.00
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: at PCI bus 0, device 13,
function 0
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 0
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 1
Oct  8 13:57:07 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: rev 0x4 on pci bus 0 device
13 function 0 irq 5
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: ID 7, Fast-20, Parity
Checking
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: rev 0x14 on pci bus 4 device
9 function 0 irq 5
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: ID 7, Fast-20, Parity
Checking
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: rev 0x14 on pci bus 4 device
9 function 1 irq 5
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: ID 7, Fast-20, Parity
Checking
Oct  8 13:57:07 ssa28 kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Oct  8 13:57:07 ssa28 kernel: scsi1 : sym53c8xx-1.7.3c-20010512
Oct  8 13:57:07 ssa28 kernel: scsi2 : sym53c8xx-1.7.3c-20010512
Oct  8 13:57:07 ssa28 kernel:   Vendor: ARCHIVE   Model: Python
28388-XXX  Rev: 4.28
Oct  8 13:57:07 ssa28 kernel:   Type:  
Sequential-Access                  ANSI SCSI revision: 02
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: detaching ...
Oct  8 13:57:07 ssa28 kernel: sym53c875-0: resetting chip
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: detaching ...
Oct  8 13:57:07 ssa28 kernel: sym53c875-1: resetting chip
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: detaching ...
Oct  8 13:57:07 ssa28 kernel: sym53c875-2: resetting chip
Oct  8 13:57:07 ssa28 kernel: scsi : 0 hosts left.
Oct  8 13:57:07 ssa28 kernel: 8139too Fast Ethernet driver 0.9.25
Oct  8 13:57:07 ssa28 kernel: eth0: RealTek RTL8139 Fast Ethernet at
0xf894c000, 00:02:44:0b:f8:d3, IRQ 11
Oct  8 13:57:07 ssa28 kernel: eth0: Setting 100mbps half-duplex based on
auto-negotiated partner ability 40a1.
Oct  8 13:57:07 ssa28 netfs: Mounting NFS filesystems:  succeeded
Oct  8 13:57:07 ssa28 netfs: Mounting other filesystems:  succeeded
Oct  8 13:57:07 ssa28 kernel: apm: BIOS not found.
Oct  8 13:57:07 ssa28 autofs: automount startup succeeded
Oct  8 13:57:08 ssa28 sshd: Starting sshd:
Oct  8 13:55:47 ssa28 rc.sysinit: Mounting proc filesystem:  succeeded
Oct  8 13:55:47 ssa28 sysctl: net.ipv4.ip_forward = 0
Oct  8 13:55:47 ssa28 sysctl: net.ipv4.conf.default.rp_filter = 1
Oct  8 13:55:47 ssa28 rc.sysinit: Configuring kernel parameters: 
succeeded
Oct  8 13:55:47 ssa28 date: Tue Oct  8 13:55:46 EST 2002
Oct  8 13:55:47 ssa28 rc.sysinit: Setting clock  (localtime): Tue Oct  8
13:55:46 EST 2002 succeeded
Oct  8 13:55:47 ssa28 rc.sysinit: Loading default keymap succeeded
Oct  8 13:55:47 ssa28 rc.sysinit: Setting default font (lat0-sun16): 
succeeded
Oct  8 13:55:47 ssa28 rc.sysinit: Activating swap partitions:  succeeded
Oct  8 13:55:47 ssa28 rc.sysinit: Setting hostname ssa28:  succeeded
Oct  8 13:55:47 ssa28 fsck: /: clean, 340595/3719168 files,
2491006/7424038 blocks
Oct  8 13:55:47 ssa28 rc.sysinit: Checking root filesystem succeeded
Oct  8 13:55:47 ssa28 rc.sysinit: Remounting root filesystem in
read-write mode:  succeeded
Oct  8 13:55:48 ssa28 rc.sysinit: Finding module dependencies: 
succeeded
Oct  8 13:55:49 ssa28 fsck: /boot: clean, 55/18072 files, 26421/72261
blocks
Oct  8 13:55:49 ssa28 fsck: /root2: clean, 11/3522560 files,
118750/7044502 blocks
Oct  8 13:55:49 ssa28 rc.sysinit: Checking filesystems succeeded
Oct  8 13:55:49 ssa28 rc.sysinit: Mounting local filesystems:  succeeded
Oct  8 13:55:49 ssa28 rc.sysinit: Enabling local filesystem quotas: 
succeeded
Oct  8 13:55:50 ssa28 rc.sysinit: Enabling swap space:  succeeded
Oct  8 13:55:51 ssa28 init: Entering runlevel: 5
Oct  8 13:56:22 ssa28 kudzu: Updating /etc/fstab succeeded
Oct  8 13:57:04 ssa28 kudzu:  succeeded
Oct  8 13:57:04 ssa28 sysctl: net.ipv4.ip_forward = 0
Oct  8 13:57:04 ssa28 sysctl: net.ipv4.conf.default.rp_filter = 1
Oct  8 13:57:04 ssa28 network: Setting network parameters:  succeeded
Oct  8 13:57:05 ssa28 network: Bringing up interface lo:  succeeded
Oct  8 13:57:05 ssa28 ifup: Determining IP information for eth0...
Oct  8 13:57:05 ssa28 ifup:  done.
Oct  8 13:57:05 ssa28 network: Bringing up interface eth0:  succeeded
Oct  8 13:57:09 ssa28 sshd:  succeeded
Oct  8 13:57:09 ssa28 sshd: ^[[60G
Oct  8 13:57:09 ssa28 sshd:
Oct  8 13:57:09 ssa28 rc: Starting sshd:  succeeded
Oct  8 13:57:09 ssa28 xinetd[775]: chargen disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: chargen disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: daytime disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: daytime disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: echo disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: echo disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: finger disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: ntalk disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: exec disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: login disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: rsync disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: talk disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: time disabled, removing
Oct  8 13:57:09 ssa28 xinetd[775]: time disabled, removing
Oct  8 13:57:10 ssa28 xinetd[775]: xinetd Version 2.3.3 started with
libwrap options compiled in.
Oct  8 13:57:10 ssa28 xinetd[775]: Started working: 4 available services
Oct  8 13:57:12 ssa28 xinetd: xinetd startup succeeded
Oct  8 13:57:13 ssa28 lpd: lpd startup succeeded
Oct  8 13:57:14 ssa28 sendmail: sendmail startup succeeded
Oct  8 13:57:14 ssa28 gpm: gpm startup succeeded
Oct  8 13:57:15 ssa28 crond: crond startup succeeded
Oct  8 13:57:15 ssa28 anacron: anacron startup succeeded
Oct  8 13:57:15 ssa28 atd: atd startup succeeded
Oct  8 13:57:15 ssa28 kdm_config[920]: Unrecognized key 'daemonMode' at
/usr/share/config/kdm/kdmrc:61
Oct  8 13:57:48 ssa28 login(pam_unix)[923]: session opened for user eyal
by (uid=0)
Oct  8 13:57:48 ssa28  -- eyal[923]: LOGIN ON pts/0 BY eyal FROM
ssa05.worldgroup.com
Oct  8 13:57:58 ssa28 su(pam_unix)[963]: authentication failure;
logname=eyal uid=605 euid=0 tty= ruser= rhost=  user=root
Oct  8 13:58:05 ssa28 su(pam_unix)[964]: session opened for user root by
eyal(uid=605)
Oct  8 13:58:14 ssa28 kernel: SCSI subsystem driver Revision: 1.00
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: at PCI bus 0, device 13,
function 0
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 0
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 1
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:58:14 ssa28 kernel: sym53c875-0: rev 0x4 on pci bus 0 device
13 function 0 irq 5
Oct  8 13:58:14 ssa28 kernel: sym53c875-0: ID 7, Fast-20, Parity
Checking
Oct  8 13:58:14 ssa28 kernel: sym53c875-1: rev 0x14 on pci bus 4 device
9 function 0 irq 5
Oct  8 13:58:14 ssa28 kernel: sym53c875-1: ID 7, Fast-20, Parity
Checking
Oct  8 13:58:14 ssa28 kernel: sym53c875-2: rev 0x14 on pci bus 4 device
9 function 1 irq 5
Oct  8 13:58:14 ssa28 kernel: sym53c875-2: ID 7, Fast-20, Parity
Checking
Oct  8 13:58:14 ssa28 kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Oct  8 13:58:14 ssa28 kernel: scsi1 : sym53c8xx-1.7.3c-20010512
Oct  8 13:58:14 ssa28 kernel: scsi2 : sym53c8xx-1.7.3c-20010512
Oct  8 13:58:19 ssa28 kernel:   Vendor: ARCHIVE   Model: Python
28388-XXX  Rev: 4.28
Oct  8 13:58:19 ssa28 kernel:   Type:  
Sequential-Access                  ANSI SCSI revision: 02
Oct  8 13:58:42 ssa28 kernel: st: Version 20020205, bufsize 32768, wrt
30720, max init. bufs 4, s/g segs 16
Oct  8 13:58:42 ssa28 kernel: Attached scsi tape st0 at scsi0, channel
0, id 5, lun 0
Oct  8 13:59:42 ssa28 kernel: sym53c875-0: unexpected disconnect
Oct  8 13:59:42 ssa28 kernel: sym53c875-0-<5,0>: COMMAND FAILED (8a
ff)@f711d000.
Oct  8 13:59:42 ssa28 kernel: sym53c875-0: unexpected disconnect
Oct  8 13:59:42 ssa28 kernel: sym53c875-0-<5,0>: COMMAND FAILED (8a
ff)@f711d000.
Oct  8 13:59:42 ssa28 kernel: scsi0 channel 0 : resetting for second
half of retries.
Oct  8 13:59:42 ssa28 kernel: SCSI bus is being reset for host 0 channel
0.
Oct  8 13:59:42 ssa28 kernel: sym53c8xx_reset: pid=91 reset_flags=1
serial_number=0 serial_number_at_timeout=0
Oct  8 13:59:42 ssa28 kernel: scsi0: device driver called scsi_done()
for a synchronous reset.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
