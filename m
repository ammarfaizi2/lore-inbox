Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265816AbUFOSVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUFOSVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFOSVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:21:07 -0400
Received: from mail.riseup.net ([216.162.217.191]:28296 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S265816AbUFOSUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:20:04 -0400
Date: Tue, 15 Jun 2004 13:19:08 -0500
From: Micah Anderson <micah@riseup.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.6 grinds to a halt with moderate I/O
Message-ID: <20040615181908.GC22650@riseup.net>
References: <20040615154745.GD22650@riseup.net> <20040615160049.GX1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20040615160049.GX1444@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>Thanks for the bugreport. I'm going to file this in the Debian BTS
>after I get the FPU fixes out. Could you send along a dmesg
>(/var/log/dmesg on Debian) and /proc/meminfo and /proc/cpuinfo at some
>point when you can log into the box? I'll also try to reproduce this.

I am not sure why this would be filed in the Debian BTS, yes the
underlying OS is Debian, but this is not a Debian Kernel, it is a
vanilla 2.6.6 kernel that I compiled by hand.

Please find attached the dmesg and the /proc/meminfo, the
/proc/cpuinfo was already included in the original email.

1. dmesg
Linux version 2.6.6 (root@willow) (gcc version 3.3.3 (Debian 20040422)) #10=
 SMP Tue Jun 15 09:25:44 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e9400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000080000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1152MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7580
On node 0 totalpages: 524288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294912 pages, LIFO batch:16
DMI 2.3 present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LP 1Kr/2Kr   APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #3 6:8 APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: apic=3Doff root=3D/dev/sda1 ro
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc03e4000 soft=3Dc03e2000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 934.115 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 2076156k/2097152k available (1991k kernel code, 19820k reserved, 56=
5k data, 368k init, 1179648k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1843.20 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.34 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/3 eip 2000
CPU 1 irqstacks, hard=3Dc03e5000 soft=3Dc03e3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1863.68 BogoMIPS
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3706.88 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 1 ... ok.
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-5, 1-9, 1-10, 1-11, 1-15, 2-1, 2-2, 2-3, 2-4, =
2-5, 2-10, 2-11, 2-12, 2-14, 2-15 not connected.
=2E.TIMER: vector=3D0x31 pin1=3D-1 pin2=3D0
=2E..trying to set up timer (IRQ0) through the 8259A ...=20
=2E.... (found pin 0) ...works.
number of MP IRQ sources: 18.
number of IO-APIC #1 registers: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................
IO APIC #1......
=2E... register #00: 01000000
=2E......    : physical APIC id: 01
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 000F0011
=2E......     : max redirection entries: 000F
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0011
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 000 00  1    0    0   0   0    0    0    00
IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 000F0011
=2E......     : max redirection entries: 000F
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0011
=2E... register #02: 0D000000
=2E......     : arbitration: 0D
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 001 01  1    1    0   1   0    1    1    81
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  1    1    0   1   0    1    1    89
 07 001 01  1    1    0   1   0    1    1    91
 08 001 01  1    1    0   1   0    1    1    99
 09 001 01  1    1    0   1   0    1    1    A1
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  1    1    0   1   0    1    1    A9
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ16 -> 1:0
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ29 -> 1:13
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 933.0294 MHz.
=2E.... host bus clock speed is 133.0327 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda11, last bus=3D3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I2,P0) -> 22
PCI->APIC IRQ transform: (B0,I8,P0) -> 23
PCI->APIC IRQ transform: (B0,I15,P0) -> 33
PCI->APIC IRQ transform: (B1,I5,P0) -> 24
PCI->APIC IRQ transform: (B1,I5,P1) -> 25
PCI->APIC IRQ transform: (B2,I1,P0) -> 29
PCI->APIC IRQ transform: (B3,I0,P0) -> 16
Machine check exception polling timer started.
Starting balanced_irq
highmem bounce pool size: 64 pages
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xe8001000, irq 22, MAC addr 00:30:6E:05:E9:D0
e100: eth1: e100_probe: addr 0xe8003000, irq 23, MAC addr 00:30:6E:05:E9:D1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
hda: CD-224E, ATAPI CD/DVD-ROM drive
hdc: IRQ probe failed (0xffffffba)
hdc: IRQ probe failed (0xffffffba)
hdd: IRQ probe failed (0xffffffba)
hdd: IRQ probe failed (0xffffffba)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
megaraid: found 0x101e:0x1960:bus 3:slot 0:func 0
scsi0:Found MegaRAID controller at 0xf8804000, IRQ:16
megaraid: [K01.04:J01.01] detected 1 logical drives.
megaraid: supports extended CDBs.
megaraid: channel[0] is raid.
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID K01.04 254 commands 16 targs 5 chans 7 luns
scsi0: scanning scsi channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD 0 RAID5  140G  Rev:   K=20
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: scanning scsi channel 1 for logical drives.
scsi0: scanning scsi channel 2 for logical drives.
scsi0: scanning scsi channel 4 [P0] for physical devices.
scsi0: scanning scsi channel 5 [P1] for physical devices.
  Vendor: SDR       Model: GEM318            Rev: 0  =20
  Type:   Processor                          ANSI SCSI revision: 02
SCSI device sda: 286744576 512-byte hdwr sectors (146813 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 5, id 11, lun 0,  type 3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1704.000 MB/sec
   8regs_prefetch:  1364.000 MB/sec
   32regs    :   900.000 MB/sec
   32regs_prefetch:   796.000 MB/sec
   pIII_sse  :  1900.000 MB/sec
   pII_mmx   :  2340.000 MB/sec
   p5_mmx    :  2504.000 MB/sec
raid5: using function: pIII_sse (1900.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/=
projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 368k freed
Adding 979920k swap on /dev/sda6.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex


2. /proc/meminfo
MemTotal:      2077312 kB
MemFree:       1583540 kB
Buffers:         27804 kB
Cached:         374892 kB
SwapCached:          0 kB
Active:          65300 kB
Inactive:       375884 kB
HighTotal:     1179648 kB
HighFree:       765056 kB
LowTotal:       897664 kB
LowFree:        818484 kB
SwapTotal:      979920 kB
SwapFree:       979920 kB
Dirty:              64 kB
Writeback:           0 kB
Mapped:          51084 kB
Slab:            41584 kB
Committed_AS:   184572 kB
PageTables:       1032 kB
VmallocTotal:   114680 kB
VmallocUsed:       788 kB
VmallocChunk:   113892 kB




On Tue, 15 Jun 2004, William Lee Irwin III wrote:

> On Tue, Jun 15, 2004 at 10:47:45AM -0500, Micah Anderson wrote:
> > Following the format from REPORTING-BUGS please see the below informati=
on.
> > I unfortunately cannot subscribe to the list, but will follow the threa=
d. I
> > have searched high and low, read a number of threads somewhat tangentia=
l to
> > this problem, and asked a few times in #kernelnewbies before I got to my
> > wits end and now will try here. I really appreciate any insight anyone =
has,
> > and will be happy to provide more information or additional tests
> > 1. When doing moderate I/O on a 2.6.6 system the machine becomes unusab=
le.
> > 2. I found that with HIGHMEM support compiled into the kernel, when I
> > did a cp -vr /var /usr/tmp it would work fine until it got about
> > halfway through the large ldap.log file (approximately 500 megs) when
> > the system would no longer be able to fork new processes. Your
> > existing shell would function, but if you tried to run top, free, etc.
> > it would hang. vmstat 1 would print the first line, but never
> > continue. I ran a million different kernel configs to try and isolate
> > things, and I thought I had it nailed down with passing apic=3Doff to
> > the kernel at boot because the large logfile copy test would
> > pass, but when rsyncing maildirs tonight the same problem appeared. Ear=
ly
> > in my tests I thought the problem was dm-crypt, but the problem existed
> > even when no encrypted filesystems were involved, and existed when I
> > removed dm-crypt support from the kernel. Disabling HIGHMEM support see=
ms
> > to make the problem go away.
>=20
> Thanks for the bugreport. I'm going to file this in the Debian BTS
> after I get the FPU fixes out. Could you send along a dmesg
> (/var/log/dmesg on Debian) and /proc/meminfo and /proc/cpuinfo at some
> point when you can log into the box? I'll also try to reproduce this.
>=20
> Thanks.
>=20
>=20
> -- wli

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzz2c9n4qXRzy1ioRAhm0AJ9favzilD9FwybVwtnlZywHsE0T+ACdHXvs
A8c3UWZpIXoxE/S+trsfl3M=
=BFAi
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
