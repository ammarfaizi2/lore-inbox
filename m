Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTEPSyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTEPSyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:54:00 -0400
Received: from [193.10.185.236] ([193.10.185.236]:33547 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S264590AbTEPSw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:52:27 -0400
Date: Fri, 16 May 2003 21:02:33 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: Dave Jones <davej@codemonkey.org.uk>,
       Andreas Henriksson <andreas@fjortis.info>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516190233.GA624@foo>
References: <20030516015407.2768b570.akpm@digeo.com> <20030516172834.GA9774@foo> <20030516175539.GA16626@suse.de> <20030516181042.GA556@foo> <20030516183033.GA18042@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20030516183033.GA18042@suse.de>
X-gpg-key: http://fjortis.info/andreas_henriksson.gpg
X-gpg-fingerprint: C51F 9B43 4390 95BB A22E  16F2 00EF 6094 449E 0434
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2003 at 07:30:33PM +0100, Dave Jones wrote:
> The reports I've seen have shown that i810fb outputs some warnings
> during startup about being unable to allocate using agpgart.
> As i810fb depends on agp, this would imply its functionality would break.
> Are you sure it's working, and not falling back to non-fb mode ?
>=20

I'm not sure.. I'm not really a framebuffer user... but to me it looks
like a framebuffer.... and it works to play movies with mplayers -vo
fbdev and view images with fbi on the console... so I guess it works.
Can you tell from the dmesg output?=20

I'll attach some I've captured.. one that I grabbed when the console=20
got stuck.. 2.5.69-mm5 with hdb plugged in... a second one where I've=20
unplugged hdb (both these with the "wrong fix")... verified that I can=20
view images with fbi .. (all movies on hdb so I couldn't test mplayer)
and another one where I boot 2.5.67-bk6 ... verified that I can both
view images with fbi and watch movies with mplayer -vo fbdev ...

>  > And by the way.... the framebuffer flickers (is that the right word?)
>  > for me.... It looks like an old TV... (Has done with all the (2.5)
>  > kernels I've tried).. Is this a known problem and if so is there a
>  > solution?
>  > I'm using a TFT monitor and this is my append-line..
>  > append=3D"video=3Di810fb:xres:1280,yres:1024,bpp:16,hsync1:30,hsync2:8=
2, \
>  > 		vsync1:50,vsync2:75,accel"
>  > (... if it matters.)
>=20
> That's probably one for Antonio to figure out, unfortunatly he's busy
> right now.
>=20

Ok... I'll add some more info here just in case....=20
When it switches to framebuffer a white square appears in the upper left
corner.. (a 640x480 window?).... it dissapears when text (and the
penguin) is drawn over it... (same for all the 2.5:s I've tried) ...=20
in 2.5.69-mm6 the penguin was missing... (maybee I did a mistake in the
config... all four CONFIG_LOGO_.. stuff enabled).

> 		Dave
>

Regards,
Andreas Henriksson

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.2.5.69-mm6"
Content-Transfer-Encoding: quoted-printable

Linux version 2.5.69-mm6 (fatal@foo) (gcc version 3.2.3) #2 Fri May 16 18:5=
0:34 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fee06c0 (usable)
 BIOS-e820: 000000000fee06c0 - 000000000fee66c0 (ACPI data)
 BIOS-e820: 000000000fee66c0 - 000000000feee700 (ACPI NVS)
 BIOS-e820: 000000000feee700 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
254MB LOWMEM available.
found SMP MP-table at 0009fe00
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
hm, page 000ec000 reserved twice.
hm, page 000ed000 reserved twice.
On node 0 totalpages: 65248
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61152 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 IBM                        ) @ 0x000fdfe0
ACPI: RSDT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee6640
ACPI: FADT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee65c0
ACPI: MADT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee6540
ACPI: DSDT (v001 IBM    CDTPWSPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x=
3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3DLinux25 ro root=3D301 video=3Di810fb:xres=
:1280,yres:1024,bpp:16,hsync1:30,hsync2:82, vsync1:50,vsync2:75,accel
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 930.393 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1839.10 BogoMIPS
Memory: 254716k/260992k available (1861k kernel code, 5560k reserved, 583k =
data, 320k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00170020
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0020
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 930.0210 MHz.
=2E.... host bus clock speed is 132.0887 MHz.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd55c, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN5] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN6] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN7] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN8] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [PIN1] enabled at IRQ 11
ACPI: PCI Interrupt Link [PIN2] enabled at IRQ 10
ACPI: PCI Interrupt Link [PIN3] enabled at IRQ 9
ACPI: PCI Interrupt Link [PIN4] enabled at IRQ 5
ACPI: PCI Interrupt Link [PIN5] enabled at IRQ 11
ACPI: PCI Interrupt Link [PIN6] enabled at IRQ 10
ACPI: PCI Interrupt Link [PIN7] enabled at IRQ 9
ACPI: PCI Interrupt Link [PIN8] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:01[A] -> 2-16 -> IRQ 16
Pin 2-16 already programmed
Pin 2-16 already programmed
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:1e[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:1e[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:1e[D] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23)
00:00:1f[C] -> 2-23 -> IRQ 23
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21)
00:01:0d[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22)
00:01:0d[B] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xe1 -> IRQ 20)
00:01:0d[D] -> 2-20 -> IRQ 20
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xf8000000
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer=
 Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 30-82 KHz V: 60-60 Hz
I810FB: Mode        : 1280x960-16bpp@60Hz
Console: switching to colour frame buffer device 160x60
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:DMA
hda: FUJITSU MPG3102AT E, ATA DISK drive
hdb: WDC WD1200JB-75CRA0, ATA DISK drive
anticipatory scheduling elevator
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 19746720 sectors (10110 MB) w/512KiB Cache, CHS=3D19590/16/63, UDMA(10=
0)
 hda: hda1
hdb: max request size: 128KiB
hdb: host protected area =3D> 1
hdb: setmax LBA 234441648, native  234375000
hdb: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=3D232514/16/63, UDM=
A(100)
 hdb: hdb1 hdb2 hdb3
Console: switching to colour frame buffer device 160x60
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 320k freed
Adding 514072k swap on /dev/hdb3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
Real Time Clock Driver v1.11
apm: Unknown symbol save_processor_state
apm: Unknown symbol restore_processor_state
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
01:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x7880. Vers LK1.1.19
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c032e080(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device cf229c00(burken)
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 41148
eth0: no IPv6 routers present

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.2.5.69-mm6.no-hdb"
Content-Transfer-Encoding: quoted-printable

Linux version 2.5.69-mm6 (fatal@foo) (gcc version 3.2.3) #2 Fri May 16 18:5=
0:34 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fee06c0 (usable)
 BIOS-e820: 000000000fee06c0 - 000000000fee66c0 (ACPI data)
 BIOS-e820: 000000000fee66c0 - 000000000feee700 (ACPI NVS)
 BIOS-e820: 000000000feee700 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
254MB LOWMEM available.
found SMP MP-table at 0009fe00
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
hm, page 000ec000 reserved twice.
hm, page 000ed000 reserved twice.
On node 0 totalpages: 65248
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61152 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 IBM                        ) @ 0x000fdfe0
ACPI: RSDT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee6640
ACPI: FADT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee65c0
ACPI: MADT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee6540
ACPI: DSDT (v001 IBM    CDTPWSPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x=
3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3DLinux25 ro root=3D301 video=3Di810fb:xres=
:1280,yres:1024,bpp:16,hsync1:30,hsync2:82, vsync1:50,vsync2:75,accel
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 930.395 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1839.10 BogoMIPS
Memory: 254716k/260992k available (1861k kernel code, 5560k reserved, 583k =
data, 320k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00170020
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0020
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 930.0210 MHz.
=2E.... host bus clock speed is 132.0887 MHz.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd55c, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN5] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN6] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN7] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN8] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [PIN1] enabled at IRQ 11
ACPI: PCI Interrupt Link [PIN2] enabled at IRQ 10
ACPI: PCI Interrupt Link [PIN3] enabled at IRQ 9
ACPI: PCI Interrupt Link [PIN4] enabled at IRQ 5
ACPI: PCI Interrupt Link [PIN5] enabled at IRQ 11
ACPI: PCI Interrupt Link [PIN6] enabled at IRQ 10
ACPI: PCI Interrupt Link [PIN7] enabled at IRQ 9
ACPI: PCI Interrupt Link [PIN8] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:01[A] -> 2-16 -> IRQ 16
Pin 2-16 already programmed
Pin 2-16 already programmed
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:1e[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:1e[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:1e[D] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23)
00:00:1f[C] -> 2-23 -> IRQ 23
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21)
00:01:0d[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22)
00:01:0d[B] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xe1 -> IRQ 20)
00:01:0d[D] -> 2-20 -> IRQ 20
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xf8000000
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer=
 Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 30-82 KHz V: 60-60 Hz
I810FB: Mode        : 1280x960-16bpp@60Hz
Console: switching to colour frame buffer device 160x60
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
hda: FUJITSU MPG3102AT E, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 19746720 sectors (10110 MB) w/512KiB Cache, CHS=3D19590/16/63, UDMA(10=
0)
 hda: hda1
Console: switching to colour frame buffer device 160x60
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 320k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
Real Time Clock Driver v1.11
apm: Unknown symbol save_processor_state
apm: Unknown symbol restore_processor_state
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
01:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x7880. Vers LK1.1.19
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c032e080(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device cf14c000(burken)
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 41147
eth0: no IPv6 routers present

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.2.5.67-bk6"
Content-Transfer-Encoding: quoted-printable

Linux version 2.5.67-bk6 (fatal@foo) (gcc version 2.95.4 20011002 (Debian p=
rerelease)) #1 Wed Apr 16 01:00:08 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fee06c0 (usable)
 BIOS-e820: 000000000fee06c0 - 000000000fee66c0 (ACPI data)
 BIOS-e820: 000000000fee66c0 - 000000000feee700 (ACPI NVS)
 BIOS-e820: 000000000feee700 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
254MB LOWMEM available.
found SMP MP-table at 0009fe00
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
hm, page 000ec000 reserved twice.
hm, page 000ed000 reserved twice.
On node 0 totalpages: 65248
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61152 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 IBM                        ) @ 0x000fdfe0
ACPI: RSDT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee6640
ACPI: FADT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee65c0
ACPI: MADT (v001 IBM    CDTPWSPI 00000.04112) @ 0x0fee6540
ACPI: DSDT (v001 IBM    CDTPWSPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x=
3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=3DLinux25-old ro root=3D301 video=3Di810fb:=
xres:1280,yres:1024,bpp:16,hsync1:30,hsync2:82, vsync1:50,vsync2:75,accel
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 930.201 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1839.10 BogoMIPS
Memory: 255000k/260992k available (1671k kernel code, 5280k reserved, 665k =
data, 136k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00170020
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0020
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 930.0195 MHz.
=2E.... host bus clock speed is 132.0884 MHz.
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd55c, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030328
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - PCI device 8086:244e
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN5] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN6] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN7] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN8] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [PIN1] enabled at IRQ 11
ACPI: PCI Interrupt Link [PIN2] enabled at IRQ 10
ACPI: PCI Interrupt Link [PIN3] enabled at IRQ 9
ACPI: PCI Interrupt Link [PIN4] enabled at IRQ 5
ACPI: PCI Interrupt Link [PIN5] enabled at IRQ 11
ACPI: PCI Interrupt Link [PIN6] enabled at IRQ 10
ACPI: PCI Interrupt Link [PIN7] enabled at IRQ 9
ACPI: PCI Interrupt Link [PIN8] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:01[A] -> 2-16 -> IRQ 16
Pin 2-16 already programmed
Pin 2-16 already programmed
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:1e[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:1e[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:1e[D] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23)
00:00:1f[C] -> 2-23 -> IRQ 23
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21)
00:01:0d[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22)
00:01:0d[B] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xe1 -> IRQ 20)
00:01:0d[D] -> 2-20 -> IRQ 20
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xf8000000
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer=
 Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 30-82 KHz V: 60-60 Hz
I810FB: Mode        : 1280x960-16bpp@60Hz
Console: switching to colour frame buffer device 160x60
pty: 256 Unix98 ptys configured
[drm] Initialized i810 1.2.1 20020211 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:DMA
hda: FUJITSU MPG3102AT E, ATA DISK drive
hdb: WDC WD1200JB-75CRA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area =3D> 1
hda: 19746720 sectors (10110 MB) w/512KiB Cache, CHS=3D19590/16/63, UDMA(10=
0)
 hda: hda1
hdb: host protected area =3D> 1
hdb: setmax LBA 234441648, native  234375000
hdb: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=3D232514/16/63, UDM=
A(100)
 hdb: hdb1 hdb2 hdb3
Console: switching to colour frame buffer device 160x60
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 514072k swap on /dev/hdb3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Real Time Clock Driver v1.11
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,66), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
01:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x7880. Vers LK1.1.19
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c03122c0(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device cf235400(burken)
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 41147
eth0: no IPv6 routers present

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="config-2.5.67-bk6"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_NAMES is not set
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
# CONFIG_SCTP_ADLER32 is not set
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
CONFIG_FEALNX=m
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=m
# CONFIG_JOYSTICK_TWIDDLER is not set
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_INPUT_JOYDUMP=m
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
CONFIG_TIPAR=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_VIAPRO=m

#
# I2C Hardware Sensors Chip support
#
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=y
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
CONFIG_VIDEO_BWQCAM=m
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=y
# CONFIG_FB_I810_GTF is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
CONFIG_USB_XPAD=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="config-2.5.69-mm6"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_025GB is not set
# CONFIG_05GB is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_KEXEC=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_NAMES is not set
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_ISP_NEW is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
CONFIG_SCTP_ADLER32=y
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_MARK_T=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
CONFIG_FEALNX=m
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_VIAPRO=m

#
# I2C Hardware Sensors Chip support
#
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_I810_TCO=m
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=m
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
CONFIG_VIDEO_CQCAM=m
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=y
# CONFIG_FB_I810_GTF is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
CONFIG_DEBUG_INFO=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--NzB8fVQJ5HfG6fxh--

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+xTXJAO9glESeBDQRAiKyAJ94lBrtFTPgZQlKyi6G6YTTxzchIgCgpRk8
ETQHkpc42KiYJ+/g689Ig+g=
=QRrt
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
