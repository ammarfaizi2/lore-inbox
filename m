Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRFFJdZ>; Wed, 6 Jun 2001 05:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbRFFJdP>; Wed, 6 Jun 2001 05:33:15 -0400
Received: from i1693.vwr.wanadoo.nl ([194.134.214.164]:13952 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S261459AbRFFJdK>; Wed, 6 Jun 2001 05:33:10 -0400
Date: Wed, 6 Jun 2001 11:32:04 +0200
From: Remi Turk <remi@a2zis.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Message-ID: <20010606113204.A859@localhost.localdomain>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010605231549.D2662@localhost.localdomain> <E157ODH-0007PX-00@the-village.bc.nu> <20010605235346.A737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010605235346.A737@localhost.localdomain>; from remi@a2zis.com on Tue, Jun 05, 2001 at 11:53:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2001 at 11:53:46PM +0200, Remi Turk wrote:
> On Tue, Jun 05, 2001 at 10:18:07PM +0100, Alan Cox wrote:
> > Thanks. UP-APIC is a real candidate for this case.
> 
> You're correct. Disabling it stops the hard-locks.
> (Although /usr/bin/apm now says my kernel doesn't
> support APM)
> 
> And now my system is going down for some hours,
> before my dad pulls the plug :-(

I also tried CONFIG_SMP=y and
CONFIG_X86_UP_APIC=y + CONFIG_X86_UP_IOAPIC=n,
but that didn't make any difference.

Even nmi_watchdog doesn't work anymore.

I thought my dmesg might be useful so I attached it.

-- 
Linux 2.4.5-ac9 #3 Wed Jun 6 11:15:40 CEST 2001

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.5-ac9 (src@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Wed Jun 6 11:15:40 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: root=/dev/hdc2 nmi_watchdog=2 console=lp0 console=tty0
Initializing CPU#0
Detected 950.076 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1893.99 BogoMIPS
Memory: 255604k/262080k available (1005k kernel code, 6092k reserved, 270k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 950.0680 MHz.
..... host bus clock speed is 200.0142 MHz.
cpu: 0, clocks: 2000142, slice: 1000071
CPU0<T0:2000128,T1:1000048,D:9,S:1000071,C:2000142>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Found VT82C686A, not applying VIA latency patch.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
parport0: PC-style at 0x378 [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
lp0: console ready
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 169786kB/56595kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL EL5.1A, ATA DISK drive
hdb: CD-ROM 36X/AKW, ATAPI CD/DVD-ROM drive
hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 10018890 sectors (5130 MB) w/418KiB Cache, CHS=10602/15/63, UDMA(33)
hdc: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, (U)DMA
hdb: ATAPI 36X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 133552k swap-space (priority -1)
Creative EMU10K1 PCI Audio Driver, version 0.13, 11:14:52 Jun  6 2001
PCI: Found IRQ 11 for device 00:11.0
emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xdc00-0xdc1f, IRQ 11
ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
spurious 8259A interrupt: IRQ7.
PPP BSD Compression module registered
PPP Deflate Compression module registered

--lrZ03NoBR/3+SXJZ--
