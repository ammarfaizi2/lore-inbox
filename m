Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWEWUhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWEWUhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWEWUhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:37:51 -0400
Received: from euklides.vdsoft.org ([82.208.56.17]:46575 "EHLO
	euklides.vdsoft.org") by vger.kernel.org with ESMTP id S932166AbWEWUhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:37:50 -0400
Message-ID: <4473729B.8030301@vdsoft.org>
Date: Tue, 23 May 2006 22:37:47 +0200
From: Vladimir Dvorak <dvorakv@vdsoft.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPUx
References: <CFF307C98FEABE47A452B27C06B85BB686E5B4@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB686E5B4@hdsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------070303010203040500010203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303010203040500010203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Brown, Len wrote:

>>http://www.abclinuxu.cz/images/hosting/sr1200.pdf
>>    
>>
>
>An Intel SCB2, a Dual P3/Serverworks board....
>Run it in the default IOAPIC mode and ignore the warnings.
>No, upgrading the kernel will almost certainly not make
>any difference.
>My note about running with "noapic" was mis-guided --
>I didn't realize this was an SMP server board
>
>Curious, however that you can't boot in IOAPIC mode with acpi=off.
>I thought that in that era they still had MPS support.  You might
>take a peek at the BIOS setup options.  dmesg will also mention
>MPS if it is there.  However, even if you succeeded in booting
>in acpi=off MPS IOAPIC mode, I would not expect it to have an
>effect on the warnings you see.
>
>cheers,
>-Len
>
>  
>
Thanks Len.

I cannot boot with 'noapic' ( as you mentioned ), with 'acpi=off' its ok.

btw... dmesg output in attachement.

Vladimir

--------------070303010203040500010203
Content-Type: text/plain;
 name="boot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.txt"

Linux version 2.6.8-3-686-smp (root@lart) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Thu Feb 9 07:05:39 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
 BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 131008
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126912 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: SCB20        APIC at: 0xFEE00000
Processor #3 6:11 APIC version 17
Processor #0 6:11 APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: root=/dev/hde1 ro acpi=off
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1130.651 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 510584k/524032k available (1665k kernel code, 12692k reserved, 771k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2236.41 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
per-CPU timeslice cutoff: 1463.49 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2252.80 BogoMIPS
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Pentium(R) III CPU family      1133MHz stepping 01
Total of 2 processors activated (4489.21 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-11, 5-0, 5-1, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................
IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
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
 0a 001 01  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 001 01  1    1    0   1   0    1    1    91
 03 001 01  1    1    0   1   0    1    1    99
 04 001 01  1    1    0   1   0    1    1    A1
 05 001 01  1    1    0   1   0    1    1    A9
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
Using vector-based indexing
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ145 -> 1:2
IRQ153 -> 1:3
IRQ161 -> 1:4
IRQ169 -> 1:5
IRQ105 -> 0:10
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1130.0272 MHz.
..... host bus clock speed is 132.0972 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 01
  groups: 01
  domain 1: span 03
   groups: 01 02
CPU1:  online
 domain 0: span 02
  groups: 02
  domain 1: span 03
   groups: 02 01
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 4624k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda75, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f36e0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x2f9f, dseg 0xf0000
pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
pnp: 00:09: ioport range 0x40b-0x40b has been reserved
pnp: 00:09: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:09: ioport range 0xc00-0xc01 has been reserved
pnp: 00:09: ioport range 0xc14-0xc14 has been reserved
pnp: 00:09: ioport range 0xc49-0xc4a has been reserved
pnp: 00:0a: ioport range 0x580-0x58f has been reserved
pnp: 00:0a: ioport range 0x500-0x51f has been reserved
pnp: 00:0a: ioport range 0x5a0-0x5af has been reserved
pnp: 00:0a: ioport range 0x520-0x53f has been reserved
pnp: 00:0a: ioport range 0x560-0x574 has been reserved
pnp: 00:0a: ioport range 0x540-0x55f has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 0000:00:0f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 153
PCI->APIC IRQ transform: (B0,I3,P0) -> 169
PCI->APIC IRQ transform: (B0,I4,P0) -> 161
PCI->APIC IRQ transform: (B0,I12,P0) -> 145
PCI->APIC IRQ transform: (B0,I15,P0) -> 105
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4624 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 168k freed
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller at PCI slot 0000:00:02.0
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0xfe7e0000
PDC20267: 100% native mode on irq 153
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0x1440-0x1447, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1448-0x144f, BIOS settings: hdg:pio, hdh:pio
hde: ST380011A, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0x1400-0x1407,0x140a on irq 153
hde: max request size: 1024KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3
hdg: ST380011A, ATA DISK drive
ide3 at 0x1410-0x1417,0x140e on irq 153
hdg: max request size: 1024KiB
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1
SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB5: chipset revision 146
SvrWks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:pio, hdd:pio
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 3903784k swap on /dev/hde2.  Priority:-1 extents:1
EXT3 FS on hde1, internal journal
Real Time Clock Driver v1.12
Generic RTC Driver v1.07
Capability LSM initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e100: Intel(R) PRO/100 Network Driver, 3.0.18
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xfe790000, irq 169, MAC addr 00:03:47:A5:33:5D
e100: eth1: e100_probe: addr 0xfe750000, irq 161, MAC addr 00:03:47:A5:33:5E
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
Disabled Privacy Extensions on device c031f0c0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
APIC error on CPU1: 00(40)
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU1: 40(40)

--------------070303010203040500010203--
