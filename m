Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTLFHLT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 02:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbTLFHLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 02:11:19 -0500
Received: from p-nya.swiftel.com.au ([202.154.106.98]:13696 "EHLO
	war.coesta.com") by vger.kernel.org with ESMTP id S264961AbTLFHLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 02:11:05 -0500
Message-ID: <3769.192.168.1.3.1070694662.squirrel@www.coesta.com>
In-Reply-To: <20031206045409.GK8039@holomorphy.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
    <20031206024251.GG8039@holomorphy.com>
    <3FD14396.5070205@cyberone.com.au>
    <20031206030755.GI8039@holomorphy.com>
    <1070684918.7934.2.camel@chevrolet.hybel>
    <20031206043757.GJ8039@holomorphy.com>
    <1070686126.1166.0.camel@chevrolet.hybel>
    <20031206045409.GK8039@holomorphy.com>
Date: Sat, 6 Dec 2003 15:11:02 +0800 (WST)
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
From: "Colin Coe" <colin@coesta.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Stian Jordet" <liste@jordet.nu>, "Nick Piggin" <piggin@cyberone.com.au>,
       "Colin Coe" <colin@coesta.com>, linux-kernel@vger.kernel.org
Reply-To: colin@coesta.com
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20031206151102_58579"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20031206151102_58579
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

/proc/cpuinfo and dmesg output is attached.

Thanks!

CC

--
"Obnoxious frog..." Spike, 2071AD

William Lee Irwin III said:
> l?r, 06.12.2003 kl. 05.37 skrev William Lee Irwin III:
>>> Yeah, it looks like it hit you too.
>>> Could you boot with noirqbalance on the kernel commandline and see if
>>> the problem goes away?
>
> On Sat, Dec 06, 2003 at 05:48:46AM +0100, Stian Jordet wrote:
>> Wow, that actually fixed it :)
>>            CPU0       CPU1
>>   0:      65636      63667    IO-APIC-edge  timer
>>   1:        150        136    IO-APIC-edge  i8042
>>   2:                              XT-PIC  cascade
>>   3:          2          1    IO-APIC-edge  serial
>>   8:          3          1    IO-APIC-edge  rtc
>>   9:                       IO-APIC-level  acpi
>>  14:         18         37    IO-APIC-edge  ide0
>
> Okay, irqbalance has gaffed (as predicted). Could you send in
> /proc/cpuinfo and /var/log/dmesg?
>
>
> -- wli
>

------=_20031206151102_58579
Content-Type: text/plain; name="cpuinfo.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="cpuinfo.txt"

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 199.489
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov
bogomips        : 390.14

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 199.489
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov
bogomips        : 397.31
------=_20031206151102_58579
Content-Type: text/plain; name="dmesg.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.0-test11 (root@host.domain.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3 SMP Sat Dec 6 09:49:19 WST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000028000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
640MB LOWMEM available.
found SMP MP-table at 000fdba0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 163840
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159744 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: POWEREDGE    APIC at: 0xFEE00000
Processor #3 6:1 APIC version 17
Processor #0 6:1 APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: ro root=/dev/sdc1 noirqbalance
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 199.489 MHz processor.
Console: colour VGA+ 80x25
Memory: 643948k/655360k available (2308k kernel code, 10636k reserved, 709k data, 456k init, 0k highmem)
Calibrating delay loop... 390.14 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 82k freed
CPU:     After generic identify, caps: 0000fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0000fbff 00000000 00000000 00000000
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0000f3ff 00000000 00000000 00000040
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium Pro stepping 09
per-CPU timeslice cutoff: 1460.32 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 397.31 BogoMIPS
CPU:     After generic identify, caps: 0000fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0000fbff 00000000 00000000 00000000
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0000f3ff 00000000 00000000 00000040
CPU1: Intel Pentium Pro stepping 09
Total of 2 processors activated (787.45 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 16.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
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
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    1    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  1    1    0   0   0    1    1    79
 0b 001 01  1    1    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  1    1    0   0   0    1    1    99
 0f 001 01  1    1    0   0   0    1    1    A1
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 199.0394 MHz.
..... host bus clock speed is 66.0464 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf814d, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fdb70
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x4ce5, dseg 0xf0000
pnp: 00:0f: ioport range 0x400-0x407 has been reserved
pnp: 00:0f: ioport range 0x40a-0x40c has been reserved
pnp: 00:0f: ioport range 0x410-0x43f has been reserved
pnp: 00:0f: ioport range 0x461-0x462 has been reserved
pnp: 00:0f: ioport range 0x464-0x465 has been reserved
pnp: 00:0f: ioport range 0x481-0x48b has been reserved
pnp: 00:0f: ioport range 0x4c6-0x4c6 has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
matroxfb: Matrox Millennium II (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x65536)
matroxfb: framebuffer at 0xFB000000, mapped to 0xe8805000, size 4194304
fb0: MATROX frame buffer device
fb0: initializing hardware
ikconfig 0.7 with /proc/config*
udf: registering filesystem
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:10.0: 3Com PCI 3c905C Tornado at 0xf400. Vers LK1.1.19
0000:00:13.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xf480. Vers LK1.1.19
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7860 Ultra SCSI adapter>
        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
(scsi0:A:6): 5.000MB/s transfers (5.000MHz, offset 15)
  Vendor: NEC       Model: CD-ROM DRIVE:462  Rev: 1.14
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: DEC       Model: DLT2000           Rev: 971E
  Type:   Sequential-Access                  ANSI SCSI revision: 02
megaraid: v2.00.3 (Release Date: Wed Feb 19 08:51:30 EST 2003)
megaraid: found 0x101e:0x9010:bus 1:slot 13:func 0
scsi1:Found MegaRAID controller at 0xd090, IRQ:15
megaraid: [U.75:1.44] detected 4 logical drives.
megaraid: channel[0] is raid.
megaraid: channel[1] is raid.
scsi1 : LSI Logic MegaRAID U.75 254 commands 16 targs 5 chans 7 luns
scsi1: scanning scsi channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID1  8568R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD1 RAID1  4088R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD2 RAID0  4088R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD3 RAID0  4088R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1: scanning scsi channel 4 [P0] for physical devices.
  Vendor: DELL      Model: 6UW BACKPLANE     Rev: 7
  Type:   Processor                          ANSI SCSI revision: 02
scsi1: scanning scsi channel 5 [P1] for physical devices.
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 6, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
SCSI device sda: 17547264 512-byte hdwr sectors (8984 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 8372224 512-byte hdwr sectors (4287 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
SCSI device sdc: 8372224 512-byte hdwr sectors (4287 MB)
sdc: asking for cache data failed
sdc: assuming drive cache: write through
 sdc: sdc1
Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
SCSI device sdd: 8372224 512-byte hdwr sectors (4287 MB)
sdd: asking for cache data failed
sdd: assuming drive cache: write through
 sdd: unknown partition table
Attached scsi disk sdd at scsi1, channel 0, id 3, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 5, lun 0,  type 5
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 1
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi1, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg4 at scsi1, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg5 at scsi1, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg6 at scsi1, channel 4, id 6, lun 0,  type 3
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 1.0.6-ioctl (2002-10-15) initialised: dm@uk.sistina.com
EISA: Probing bus 0 at 0000:00:0f.0
EISA: Mainboard DEL0058 detected.
EISA: Detected 0 cards.
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Fusion CS46xx at 0xfcffc000/0xfce00000, irq 14
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (5120 buckets, 40960 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 456k freed
EXT3 FS on sdc1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kudzu: numerical sysctl 1 23 is obsolete.
process `named' is using obsolete setsockopt SO_BSDCOMPAT
------=_20031206151102_58579--

