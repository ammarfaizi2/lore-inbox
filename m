Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSK1AQg>; Wed, 27 Nov 2002 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSK1AQf>; Wed, 27 Nov 2002 19:16:35 -0500
Received: from s383.jpl.nasa.gov ([137.78.170.215]:16326 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S264963AbSK1AQL>; Wed, 27 Nov 2002 19:16:11 -0500
Message-ID: <3DE561FD.5020209@jpl.nasa.gov>
Date: Wed, 27 Nov 2002 16:23:25 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 oops and trace...
Content-Type: multipart/mixed;
 boundary="------------050709040006090900060406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050709040006090900060406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

note: /export/home/kernel/linux-2.5.48/ <- .48 was original tar ball, 
patched in .49 and .50

ksymoops 2.4.8 on i686 2.4.19-16mdksmp.  Options used
      -v /export/home/kernel/linux-2.5.48/vmlinux (specified)
      -K (specified)
      -l /proc/modules (default)
      -o /lib/modules/2.5.50-1jpl/ (specified)
      -m /boot/System.map-2.5.50-1jpl (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0000
CPU:    0
EIP:    0060:[<c013612e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: e08ee064   ecx: ffffffff   edx: e08e4e14
esi: dec85db0   edi: e08e4e14   ebp: dec85e00   esp: dec85db0
ds: 0068   es: 0068   ss: 0068
Stack: e0810000 e08ee064 dec85de0 dec85ddc 00000008 c04809df e081000c 
00000246
        0000000e dec85e00 e081000c 00000020 000040b8 c031e803 dec85e10 
00000400
        c0325001 e08ee064 dff762c0 00000282 dec85e14 c010c297 c0324bff 
e08ee064
Call Trace:
  [<e08ee064>] <1>Unable to handle kernel paging request at virtual 
address e08e4e14
c013612e
*pde = 1fe8f067
Warning (Oops_read): Code line not seen, dumping what data is available


 >>EIP; c013612e <__print_symbol+48/11a>   <=====

Trace; e08ee064 <END_OF_CODE+20408a38/????>


1 warning issued.  Results may not be reliable.

I attached my .config and logs from serial console. After I printed the 
task list the machine locked up, SysRq didn't even work... :(

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

--------------050709040006090900060406
Content-Type: text/plain;
 name="mulan.boot"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="mulan.boot"

Connecting to /dev/ttyS0, speed 9600.
The escape character is Ctrl-\ (ASCII 28, FS)
Type the escape character followed by C to get back,
or followed by ? to see other options.
----------------------------------------------------
Linux version 2.5.50-1jpl (root@mulan.jpl.nasa.gov) (gcc version 3.2 (Man=
drake Linux 9.0 3.2-1mdk)) #1 SMP Wed Nov 27 15:27:37 PST 2002

Video mode to be used for restore is f00

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000001ff77000 (usable)

 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)

 BIOS-e820: 000000001ff79000 - 0000000020000000 (reserved)

 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)

 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)

0MB HIGHMEM available.

511MB LOWMEM available.

found SMP MP-table at 000fe710

hm, page 000fe000 reserved twice.

hm, page 000ff000 reserved twice.

hm, page 000f0000 reserved twice.

On node 0 totalpages: 130935

  DMA zone: 4096 pages, LIFO batch:1

  Normal zone: 126839 pages, LIFO batch:16

  HighMem zone: 0 pages, LIFO batch:1

Intel MultiProcessor Specification v1.4

    Virtual Wire compatibility mode.

OEM ID: DELL     Product ID: WS 530       APIC at: 0xFEE00000

Processor #0 15:1 APIC version 20

Processor #1 15:1 APIC version 20

I/O APIC #2 Version 32 at 0xFEC00000.

Enabling APIC mode:  Flat.  Using 1 I/O APICs

Processors: 2

Building zonelist for node : 0

Kernel command line: BOOT_IMAGE=3D2550-1jpl ro root=3D805 devfs=3Dmount h=
da=3Dide-scsi console=3DttyS0,9600 console=3Dtty0

ide_setup: hda=3Dide-scsi

Initializing CPU#0

Detected 1694.687 MHz processor.

Console: colour VGA+ 80x25

Calibrating delay loop... 3342.33 BogoMIPS

Memory: 513588k/523740k available (2129k kernel code, 9372k reserved, 123=
1k data, 120k init, 0k highmem)

Security Scaffold v1.0.0 initialized

Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)

Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

-> /dev

-> /dev/console

-> /root

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 256K

CPU: Hyper-Threading is disabled

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available

CPU#0: Thermal monitoring enabled

Machine check exception polling timer started.

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

CPU0: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02

per-CPU timeslice cutoff: 731.29 usecs.

task migration cache decay timeout: 1 msecs.

enabled ExtINT on CPU#0

ESR value before enabling vector: 00000040

ESR value after enabling vector: 00000000

Booting processor 1/1 eip 2000

Initializing CPU#1

masked ExtINT on CPU#1

ESR value before enabling vector: 00000000

ESR value after enabling vector: 00000000

Calibrating delay loop... 3383.29 BogoMIPS

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 256K

CPU: Hyper-Threading is disabled

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#1.

CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available

CPU#1: Thermal monitoring enabled

CPU1: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02

Total of 2 processors activated (6725.63 BogoMIPS).

ENABLING IO-APIC IRQs

Setting 2 in the phys_id_present_map

=2E..changing IO-APIC physical APIC ID to 2 ... ok.

=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0

testing the IO APIC.......................


=2E................................... done.

Using local APIC timer interrupts.

calibrating APIC timer ...

=2E.... CPU clock speed is 1694.0605 MHz.

=2E.... host bus clock speed is 99.0682 MHz.

checking TSC synchronization across 2 CPUs: passed.

Starting migration thread for cpu 0

Bringing up 1

CPU 1 IS NOW UP!

Starting migration thread for cpu 1

CPUS done 32

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

mtrr: v2.0 (20020519)

PCI: PCI BIOS revision 2.10 entry at 0xfbe4e, last bus=3D4

PCI: Using configuration type 1

BIO: pool of 256 setup, 14Kb (56 bytes/bio)

biovec pool[0]:   1 bvecs: 256 entries (12 bytes)

biovec pool[1]:   4 bvecs: 256 entries (48 bytes)

biovec pool[2]:  16 bvecs: 256 entries (192 bytes)

biovec pool[3]:  64 bvecs: 256 entries (768 bytes)

biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)

biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)

Linux Plug and Play Support v0.9 (c) Adam Belay

block request queues:

 128 requests per read queue

 128 requests per write queue

 8 requests per batch

 enter congestion at 31

 exit congestion at 33

PCI: Probing PCI hardware

PCI: Probing PCI hardware (bus 00)

Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br

PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0

PCI->APIC IRQ transform: (B0,I31,P3) -> 19

PCI->APIC IRQ transform: (B0,I31,P1) -> 17

PCI->APIC IRQ transform: (B0,I31,P2) -> 23

PCI->APIC IRQ transform: (B1,I0,P0) -> 16

PCI->APIC IRQ transform: (B3,I14,P0) -> 22

PCI->APIC IRQ transform: (B4,I11,P0) -> 23

PCI->APIC IRQ transform: (B4,I12,P0) -> 16

PCI->APIC IRQ transform: (B4,I15,P0) -> 19

SBF: Simple Boot Flag extension found and enabled.

SBF: Setting boot flags 0x80

aio_setup: sizeof(struct page) =3D 40

[dff0c080] eventpoll: successfully initialized.

VFS: Disk quotas vdquot_6.5.1

Journalled Block Device driver loaded

devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

SGI XFS CVS-09/15/02:17 with ACLs, realtime, quota, no debug enabled

Capability LSM initialized

Initializing Cryptographic API

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled

tts/0 at I/O 0x3f8 (irq =3D 4) is a 16550A

tts/1 at I/O 0x2f8 (irq =3D 3) is a 16550A

pty: 256 Unix98 ptys configured

Real Time Clock Driver v1.11

i810_rng hardware driver 0.9.8 loaded

Linux agpgart interface v0.99 (c) Jeff Hartmann

agpgart: Maximum main memory to use for agp memory: 439M

RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx

ICH2: IDE controller at PCI slot 00:1f.1

ICH2: chipset revision 4

ICH2: not 100% native mode: will probe irqs later

    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio

hda: Hewlett-Packard DVD Writer 200, ATAPI CD/DVD-ROM drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

ide-floppy driver 0.99.newide

SCSI subsystem driver Revision: 1.00

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4

        <Adaptec aic7892 Ultra160 SCSI adapter>

        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs


(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)

  Vendor: FUJITSU   Model: MAN3184MP         Rev: 5507

  Type:   Direct-Access                      ANSI SCSI revision: 03

(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)

  Vendor: FUJITSU   Model: MAJ3182MP         Rev: 5508

  Type:   Direct-Access                      ANSI SCSI revision: 04

scsi0:A:0:0: Tagged Queuing enabled.  Depth 253

SCSI device sda: drive cache: write back

SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)

 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >

Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

scsi0:A:1:0: Tagged Queuing enabled.  Depth 253

SCSI device sdb: drive cache: write back

SCSI device sdb: 35566478 512-byte hdwr sectors (18210 MB)

 /dev/scsi/host0/bus0/target1/lun0: p1

Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0

input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1

serio: i8042 AUX port at 0x60,0x64 irq 12

input: AT Set 2 keyboard on isa0060/serio0

serio: i8042 KBD port at 0x60,0x64 irq 1

NET4: Linux TCP/IP 1.0 for NET4.0

IP: routing cache hash table of 2048 buckets, 32Kbytes

TCP: Hash tables configured (established 16384 bind 21845)

Linux IP multicast router 0.06 plus PIM-SM

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

XFS mounting filesystem sd(8,5)

VFS: Mounted root (xfs filesystem) readonly.

Mounted devfs on /dev

Freeing unused kernel memory: 120k freed

SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem showPc unRaw Sync=
 showTasks Unmount=20

SysRq : Changing Loglevel

Loglevel set to 8

scsi: Device offlined - not ready or command retry failed after error rec=
overy: host 1 channel 0 id 0 lun 0

XFS mounting filesystem sd(8,7)

Ending clean XFS mount for filesystem: sd(8,7)

XFS mounting filesystem sd(8,8)

Ending clean XFS mount for filesystem: sd(8,8)

XFS mounting filesystem sd(8,17)

Ending clean XFS mount for filesystem: sd(8,17)

ohci1394: $Rev: 601 $ Ben Collins <bcollins@debian.org>

ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[16]  MMIO=3D[fe1ff000-fe1ff7ff]  =
Max Packet=3D[2048]

Debug: sleeping function called from illegal context at mm/slab.c:1304

Call Trace:

 [<c0141c5b>] kmem_flagcheck+0x61/0x64

 [<c01425f2>] kmalloc+0x5c/0xbe

 [<e08ee064>] <1>Unable to handle kernel paging request at virtual addres=
s e08e4e14

 printing eip:

c013612e

*pde =3D 1fe8f067

*pte =3D 00000000

Oops: 0000

CPU:    0

EIP:    0060:[<c013612e>]    Not tainted

EFLAGS: 00010246

EIP is at __print_symbol+0x48/0x11a

eax: 00000000   ebx: e08ee064   ecx: ffffffff   edx: e08e4e14

esi: dec85db0   edi: e08e4e14   ebp: dec85e00   esp: dec85db0

ds: 0068   es: 0068   ss: 0068

Process modprobe (pid: 471, threadinfo=3Ddec84000 task=3Ddf521d00)

Stack: e0810000 e08ee064 dec85de0 dec85ddc 00000008 c04809df e081000c 000=
00246=20

       0000000e dec85e00 e081000c 00000020 000040b8 c031e803 dec85e10 000=
00400=20

       c0325001 e08ee064 dff762c0 00000282 dec85e14 c010c297 c0324bff e08=
ee064=20

Call Trace:

 [<e08ee064>] <1>Unable to handle kernel paging request at virtual addres=
s e08e4e14

 printing eip:

c013612e

*pde =3D 1fe8f067

*pte =3D 00000000

SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem showPc unRaw Sync=
 showTasks Unmount=20

SysRq : Show Memory

Mem-info:

Free pages:      491512kB (     0kB HighMem)

Zone:DMA freepages: 12072kB min:   128kB low:   256kB high:   384kB activ=
e:     0kB inactive:     0kB

Zone:Normal freepages:479440kB min:  1020kB low:  2040kB high:  3060kB ac=
tive:  6624kB inactive:  6448kB

Zone:HighMem freepages:     0kB min:     0kB low:     0kB high:     0kB a=
ctive:     0kB inactive:     0kB

( Active:1656 inactive:1612 dirty:0 writeback:0 free:122878 )

2*4kB 2*8kB 3*16kB 1*32kB 3*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048k=
B 2*4096kB =3D 12072kB)

36*4kB 10*8kB 3*16kB 0*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*204=
8kB 116*4096kB =3D 479440kB)

Swap cache: add 0, delete 0, find 0/0, race 0+0

Free swap:       1020088kB

130935 pages of RAM

0 pages of HIGHMEM

2409 reserved pages

1282 pages shared

0 pages swap cached

SysRq : Show State


                         free                        sibling

  task             PC    stack   pid father child younger older

init          S C042F300     0     1      0     2               (NOTLB)

Call Trace:

 [<c012a082>] schedule_timeout+0x6a/0xbc

 [<c012a00e>] process_timeout+0x0/0xa

 [<c016aa9b>] do_select+0x131/0x24c

 [<c016a7de>] __pollwait+0x0/0xaa

 [<c016ae84>] sys_select+0x2a6/0x4a8

 [<c01605eb>] sys_stat64+0x35/0x38

 [<c010b61f>] syscall_call+0x7/0xb


migration/0   S C042E900     0     2      1             3       (L-TLB)

Call Trace:

 [<c011e23d>] migration_thread+0x339/0x346

 [<c011df04>] migration_thread+0x0/0x346

 [<c010915d>] kernel_thread_helper+0x5/0xc


ksoftirqd/0   S DF85B588     0     3      1             4     2 (L-TLB)

Call Trace:

 [<c0126226>] ksoftirqd+0xc0/0x10c

 [<c0126166>] ksoftirqd+0x0/0x10c

 [<c010915d>] kernel_thread_helper+0x5/0xc


migration/1   S C042F300     0     4      1             5     3 (L-TLB)

Call Trace:

 [<c0226a0b>] sprintf+0x1f/0x24

 [<c011e23d>] migration_thread+0x339/0x346

 [<c010b57d>] ret_from_fork+0x5/0x14

 [<c011df04>] migration_thread+0x0/0x346

 [<c010915d>] kernel_thread_helper+0x5/0xc


ksoftirqd/1   S C042F300     0     5      1             6     4 (L-TLB)

Call Trace:

 [<c0226a0b>] sprintf+0x1f/0x24

 [<c0126226>] ksoftirqd+0xc0/0x10c

 [<c0126166>] ksoftirqd+0x0/0x10c

 [<c010915d>] kernel_thread_helper+0x5/0xc


events/0      S DFC2DA8C     0     6      1             7     5 (L-TLB)

Call Trace:

 [<c0226a0b>] sprintf+0x1f/0x24

 [<c0131096>] worker_thread+0x2fe/0x32a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0130d98>] worker_thread+0x0/0x32a

 [<c010915d>] kernel_thread_helper+0x5/0xc


events/1      S C042F300     0     7      1             8     6 (L-TLB)

Call Trace:

 [<c0131096>] worker_thread+0x2fe/0x32a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0130d98>] worker_thread+0x0/0x32a

 [<c010915d>] kernel_thread_helper+0x5/0xc


kswapd0       S C02269E7     0     8      1             9     7 (L-TLB)

Call Trace:

 [<c02269e7>] vsprintf+0x27/0x2c

 [<c0226a0b>] sprintf+0x1f/0x24

 [<c0146014>] kswapd+0xec/0x11c

 [<c011c0a5>] schedule+0x37/0x406

 [<c011f1aa>] autoremove_wake_function+0x0/0x4c

 [<c011f1aa>] autoremove_wake_function+0x0/0x4c

 [<c0145f28>] kswapd+0x0/0x11c

 [<c010915d>] kernel_thread_helper+0x5/0xc


pdflush       S DFD0B500     0     9      1            10     8 (L-TLB)

Call Trace:

 [<c0123464>] reparent_to_init+0x108/0x1ac

 [<c014e611>] __pdflush+0x1dd/0x3da

 [<c011c4aa>] preempt_schedule+0x36/0x50

 [<c011b8e4>] schedule_tail+0x8a/0x8c

 [<c014e80e>] pdflush+0x0/0x16

 [<c014e81f>] pdflush+0x11/0x16

 [<c010915d>] kernel_thread_helper+0x5/0xc


pdflush       S C042F300     0    10      1            11     9 (L-TLB)

Call Trace:

 [<c014e611>] __pdflush+0x1dd/0x3da

 [<c011c4aa>] preempt_schedule+0x36/0x50

 [<c011b8e4>] schedule_tail+0x8a/0x8c

 [<c014e80e>] pdflush+0x0/0x16

 [<c014e81f>] pdflush+0x11/0x16

 [<c010915d>] kernel_thread_helper+0x5/0xc


aio/0         S DFEF7780     0    11      1            12    10 (L-TLB)

Call Trace:

 [<c012d1a0>] do_sigaction+0x17e/0x18a

 [<c0226a0b>] sprintf+0x1f/0x24

 [<c0131096>] worker_thread+0x2fe/0x32a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0130d98>] worker_thread+0x0/0x32a

 [<c010915d>] kernel_thread_helper+0x5/0xc


aio/1         S C042F300     0    12      1            13    11 (L-TLB)

Call Trace:

 [<c012d1a0>] do_sigaction+0x17e/0x18a

 [<c0131096>] worker_thread+0x2fe/0x32a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0130d98>] worker_thread+0x0/0x32a

 [<c010915d>] kernel_thread_helper+0x5/0xc


pagebufd      S C042F300     0    13      1            14    12 (L-TLB)

Call Trace:

 [<c011ca13>] interruptible_sleep_on+0xaf/0x138

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c021afe0>] xfs_bdstrat_cb+0x0/0x46

 [<c021392b>] pagebuf_daemon+0x33d/0x352

 [<c011c4aa>] preempt_schedule+0x36/0x50

 [<c02135c4>] pagebuf_daemon_wakeup+0x0/0x2a

 [<c02135ee>] pagebuf_daemon+0x0/0x352

 [<c010915d>] kernel_thread_helper+0x5/0xc


pagebuf/0     S C042E900     0    14      1            15    13 (L-TLB)

Call Trace:

 [<c0226a0b>] sprintf+0x1f/0x24

 [<c0131096>] worker_thread+0x2fe/0x32a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0130d98>] worker_thread+0x0/0x32a

 [<c010915d>] kernel_thread_helper+0x5/0xc


pagebuf/1     S C042F300     0    15      1            16    14 (L-TLB)

Call Trace:

 [<c0131096>] worker_thread+0x2fe/0x32a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0130d98>] worker_thread+0x0/0x32a

 [<c010915d>] kernel_thread_helper+0x5/0xc


scsi_eh_0     S 00000096     0    16      1            17    15 (L-TLB)

Call Trace:

 [<c011c4f6>] default_wake_function+0x32/0x3e

 [<c010a25c>] __down_interruptible+0x10a/0x1e6

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c010a412>] __down_failed_interruptible+0xa/0x10

 [<c028143b>] .text.lock.scsi_error+0xb1/0xc2

 [<c0280da8>] scsi_error_handler+0x0/0x1e6

 [<c010915d>] kernel_thread_helper+0x5/0xc


kseriod       S DFC23FA0     0    17      1            18    16 (L-TLB)

Call Trace:

 [<c011ee35>] add_wait_queue+0xa3/0xa6

 [<c02ab179>] serio_thread+0xe1/0x140

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c02ab098>] serio_thread+0x0/0x140

 [<c010915d>] kernel_thread_helper+0x5/0xc


init          S DFC2DC38     0    18      1    19     117    17 (NOTLB)

Call Trace:

 [<c012446e>] sys_wait4+0x1f8/0x504

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c010b61f>] syscall_call+0x7/0xb


rc.sysinit    S DFC2D734     0    19     18   440               (NOTLB)

Call Trace:

 [<c021530f>] linvfs_readv+0x3f/0x44

 [<c012446e>] sys_wait4+0x1f8/0x504

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c012c6d2>] sys_rt_sigprocmask+0x16a/0x27a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c010b61f>] syscall_call+0x7/0xb


devfsd        S DF636DE4     0   117      1           303    18 (NOTLB)

Call Trace:

 [<c01a9f06>] devfsd_read+0x104/0x452

 [<c016059e>] cp_new_stat64+0xb4/0xcc

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c0155d09>] vfs_read+0xd3/0x13a

 [<c015500f>] filp_close+0xb5/0xd4

 [<c0155f9c>] sys_read+0x3c/0x52

 [<c010b61f>] syscall_call+0x7/0xb


scsi_eh_1     S DFD4002C     0   303      1                 117 (L-TLB)

Call Trace:

 [<c025514b>] elv_next_request+0x11/0xf2

 [<c010a25c>] __down_interruptible+0x10a/0x1e6

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c010a412>] __down_failed_interruptible+0xa/0x10

 [<c028143b>] .text.lock.scsi_error+0xb1/0xc2

 [<c0280da8>] scsi_error_handler+0x0/0x1e6

 [<c010915d>] kernel_thread_helper+0x5/0xc


rc.sysinit    S DF85BC38     0   440     19   470     441       (NOTLB)

Call Trace:

 [<c012446e>] sys_wait4+0x1f8/0x504

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c012c6d2>] sys_rt_sigprocmask+0x16a/0x27a

 [<c011c4c4>] default_wake_function+0x0/0x3e

 [<c010b61f>] syscall_call+0x7/0xb


getkey        S C042E900     0   441     19                 440 (NOTLB)

Call Trace:

 [<c012a0d1>] schedule_timeout+0xb9/0xbc

 [<c023ccf6>] tty_poll+0x7e/0x96

 [<c016b0dd>] do_pollfd+0x57/0x98

 [<c016b1c8>] do_poll+0xaa/0xf8

 [<c016b36c>] sys_poll+0x156/0x2cf

 [<c016a7de>] __pollwait+0x0/0xaa

 [<c010b61f>] syscall_call+0x7/0xb


initlog       S C042F300     0   470    440   471               (NOTLB)

Call Trace:

 [<c012a082>] schedule_timeout+0x6a/0xbc

 [<c012a00e>] process_timeout+0x0/0xa

 [<c016b1c8>] do_poll+0xaa/0xf8

 [<c016b36c>] sys_poll+0x156/0x2cf

 [<c016a7de>] __pollwait+0x0/0xaa

 [<c010b61f>] syscall_call+0x7/0xb


modprobe      R DEC85E9C     0   471    470                     (NOTLB)

Call Trace:

 [<e08eaa1d>] <1>Unable to handle kernel paging request at virtual addres=
s e08e558b

 printing eip:

c013612e

*pde =3D 1fe8f067

*pte =3D 00000000

=00=00=07=07
Closing /dev/ttyS0...OK

--------------050709040006090900060406
Content-Type: application/x-java-vm;
 name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMK
Q09ORklHX1g4Nj15CkNPTkZJR19NTVU9eQpDT05GSUdfU1dBUD15CkNPTkZJR19VSUQxNj15
CkNPTkZJR19HRU5FUklDX0lTQV9ETUE9eQoKIwojIENvZGUgbWF0dXJpdHkgbGV2ZWwgb3B0
aW9ucwojCkNPTkZJR19FWFBFUklNRU5UQUw9eQoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05G
SUdfTkVUPXkKQ09ORklHX1NZU1ZJUEM9eQpDT05GSUdfQlNEX1BST0NFU1NfQUNDVD15CkNP
TkZJR19TWVNDVEw9eQoKIwojIExvYWRhYmxlIG1vZHVsZSBzdXBwb3J0CiMKQ09ORklHX01P
RFVMRVM9eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CkNPTkZJR19NT0RVTEVfRk9SQ0VfVU5M
T0FEPXkKQ09ORklHX0tNT0Q9eQoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwoj
CiMgQ09ORklHX00zODYgaXMgbm90IHNldAojIENPTkZJR19NNDg2IGlzIG5vdCBzZXQKIyBD
T05GSUdfTTU4NiBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZUU0MgaXMgbm90IHNldAojIENP
TkZJR19NNTg2TU1YIGlzIG5vdCBzZXQKIyBDT05GSUdfTTY4NiBpcyBub3Qgc2V0CiMgQ09O
RklHX01QRU5USVVNSUlJIGlzIG5vdCBzZXQKQ09ORklHX01QRU5USVVNND15CiMgQ09ORklH
X01LNiBpcyBub3Qgc2V0CiMgQ09ORklHX01LNyBpcyBub3Qgc2V0CiMgQ09ORklHX01FTEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUNSVVNPRSBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5D
SElQQzYgaXMgbm90IHNldAojIENPTkZJR19NV0lOQ0hJUDIgaXMgbm90IHNldAojIENPTkZJ
R19NV0lOQ0hJUDNEIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNZUklYSUlJIGlzIG5vdCBzZXQK
Q09ORklHX1g4Nl9DTVBYQ0hHPXkKQ09ORklHX1g4Nl9YQUREPXkKQ09ORklHX1g4Nl9MMV9D
QUNIRV9TSElGVD03CkNPTkZJR19SV1NFTV9YQ0hHQUREX0FMR09SSVRITT15CkNPTkZJR19Y
ODZfV1BfV09SS1NfT0s9eQpDT05GSUdfWDg2X0lOVkxQRz15CkNPTkZJR19YODZfQlNXQVA9
eQpDT05GSUdfWDg2X1BPUEFEX09LPXkKQ09ORklHX1g4Nl9UU0M9eQpDT05GSUdfWDg2X0dP
T0RfQVBJQz15CkNPTkZJR19YODZfSU5URUxfVVNFUkNPUFk9eQpDT05GSUdfWDg2X1VTRV9Q
UFJPX0NIRUNLU1VNPXkKIyBDT05GSUdfSFVHRVRMQl9QQUdFIGlzIG5vdCBzZXQKQ09ORklH
X1NNUD15CkNPTkZJR19QUkVFTVBUPXkKQ09ORklHX1g4Nl9MT0NBTF9BUElDPXkKQ09ORklH
X1g4Nl9JT19BUElDPXkKQ09ORklHX05SX0NQVVM9MzIKIyBDT05GSUdfWDg2X05VTUEgaXMg
bm90IHNldApDT05GSUdfWDg2X01DRT15CkNPTkZJR19YODZfTUNFX05PTkZBVEFMPXkKQ09O
RklHX1g4Nl9NQ0VfUDRUSEVSTUFMPXkKIyBDT05GSUdfQ1BVX0ZSRVEgaXMgbm90IHNldAoj
IENPTkZJR19UT1NISUJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSThLIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUlDUk9DT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X01TUiBpcyBub3Qgc2V0
CiMgQ09ORklHX1g4Nl9DUFVJRCBpcyBub3Qgc2V0CiMgQ09ORklHX0VERCBpcyBub3Qgc2V0
CiMgQ09ORklHX05PSElHSE1FTSBpcyBub3Qgc2V0CkNPTkZJR19ISUdITUVNNEc9eQojIENP
TkZJR19ISUdITUVNNjRHIGlzIG5vdCBzZXQKQ09ORklHX0hJR0hNRU09eQojIENPTkZJR19I
SUdIUFRFIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFUSF9FTVVMQVRJT04gaXMgbm90IHNldApD
T05GSUdfTVRSUj15CkNPTkZJR19IQVZFX0RFQ19MT0NLPXkKCiMKIyBQb3dlciBtYW5hZ2Vt
ZW50IG9wdGlvbnMgKEFDUEksIEFQTSkKIwoKIwojIEFDUEkgU3VwcG9ydAojCiMgQ09ORklH
X0FDUEkgaXMgbm90IHNldAojIENPTkZJR19QTSBpcyBub3Qgc2V0CgojCiMgQnVzIG9wdGlv
bnMgKFBDSSwgUENNQ0lBLCBFSVNBLCBNQ0EsIElTQSkKIwpDT05GSUdfUENJPXkKIyBDT05G
SUdfUENJX0dPQklPUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9HT0RJUkVDVCBpcyBub3Qg
c2V0CkNPTkZJR19QQ0lfR09BTlk9eQpDT05GSUdfUENJX0JJT1M9eQpDT05GSUdfUENJX0RJ
UkVDVD15CiMgQ09ORklHX1NDeDIwMCBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfTkFNRVM9eQoj
IENPTkZJR19JU0EgaXMgbm90IHNldAojIENPTkZJR19NQ0EgaXMgbm90IHNldApDT05GSUdf
SE9UUExVRz15CgojCiMgUENNQ0lBL0NhcmRCdXMgc3VwcG9ydAojCiMgQ09ORklHX1BDTUNJ
QSBpcyBub3Qgc2V0CgojCiMgUENJIEhvdHBsdWcgU3VwcG9ydAojCiMgQ09ORklHX0hPVFBM
VUdfUENJIGlzIG5vdCBzZXQKCiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwojCkNPTkZJ
R19LQ09SRV9FTEY9eQojIENPTkZJR19LQ09SRV9BT1VUIGlzIG5vdCBzZXQKQ09ORklHX0JJ
TkZNVF9BT1VUPW0KQ09ORklHX0JJTkZNVF9FTEY9eQpDT05GSUdfQklORk1UX01JU0M9bQoK
IwojIE1lbW9yeSBUZWNobm9sb2d5IERldmljZXMgKE1URCkKIwojIENPTkZJR19NVEQgaXMg
bm90IHNldAoKIwojIFBhcmFsbGVsIHBvcnQgc3VwcG9ydAojCkNPTkZJR19QQVJQT1JUPW0K
Q09ORklHX1BBUlBPUlRfUEM9bQpDT05GSUdfUEFSUE9SVF9QQ19DTUwxPW0KIyBDT05GSUdf
UEFSUE9SVF9TRVJJQUwgaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUX1BDX0ZJRk8gaXMg
bm90IHNldAojIENPTkZJR19QQVJQT1JUX1BDX1NVUEVSSU8gaXMgbm90IHNldAojIENPTkZJ
R19QQVJQT1JUX09USEVSIGlzIG5vdCBzZXQKQ09ORklHX1BBUlBPUlRfMTI4ND15CgojCiMg
UGx1ZyBhbmQgUGxheSBjb25maWd1cmF0aW9uCiMKQ09ORklHX1BOUD15CiMgQ09ORklHX1BO
UF9OQU1FUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BOUF9ERUJVRyBpcyBub3Qgc2V0CgojCiMg
UHJvdG9jb2xzCiMKIyBDT05GSUdfSVNBUE5QIGlzIG5vdCBzZXQKIyBDT05GSUdfUE5QQklP
UyBpcyBub3Qgc2V0CgojCiMgQmxvY2sgZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0ZEPW0K
IyBDT05GSUdfUEFSSURFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfREFDOTYwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VTUVNIGlzIG5vdCBzZXQK
Q09ORklHX0JMS19ERVZfTE9PUD1tCkNPTkZJR19CTEtfREVWX05CRD1tCkNPTkZJR19CTEtf
REVWX1JBTT15CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTMyMDAwCkNPTkZJR19CTEtfREVW
X0lOSVRSRD15CiMgQ09ORklHX0xCRCBpcyBub3Qgc2V0CgojCiMgQVRBL0FUQVBJL01GTS9S
TEwgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSURFPXkKCiMKIyBJREUsIEFUQSBhbmQgQVRB
UEkgQmxvY2sgZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0lERT15CgojCiMgUGxlYXNlIHNl
ZSBEb2N1bWVudGF0aW9uL2lkZS50eHQgZm9yIGhlbHAvaW5mbyBvbiBJREUgZHJpdmVzCiMK
IyBDT05GSUdfQkxLX0RFVl9IRF9JREUgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0hE
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRElTSz15CkNPTkZJR19JREVESVNLX01V
TFRJX01PREU9eQojIENPTkZJR19JREVESVNLX1NUUk9LRSBpcyBub3Qgc2V0CkNPTkZJR19C
TEtfREVWX0lERUNEPXkKQ09ORklHX0JMS19ERVZfSURFRkxPUFBZPXkKQ09ORklHX0JMS19E
RVZfSURFU0NTST1tCkNPTkZJR19JREVfVEFTS19JT0NUTD15CgojCiMgSURFIGNoaXBzZXQg
c3VwcG9ydC9idWdmaXhlcwojCiMgQ09ORklHX0JMS19ERVZfQ01ENjQwIGlzIG5vdCBzZXQK
Q09ORklHX0JMS19ERVZfSURFUENJPXkKQ09ORklHX0JMS19ERVZfR0VORVJJQz15CkNPTkZJ
R19JREVQQ0lfU0hBUkVfSVJRPXkKQ09ORklHX0JMS19ERVZfSURFRE1BX1BDST15CiMgQ09O
RklHX0JMS19ERVZfSURFX1RDUSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX09GRkJPQVJE
PXkKIyBDT05GSUdfQkxLX0RFVl9JREVETUFfRk9SQ0VEIGlzIG5vdCBzZXQKQ09ORklHX0lE
RURNQV9QQ0lfQVVUTz15CiMgQ09ORklHX0lERURNQV9PTkxZRElTSyBpcyBub3Qgc2V0CkNP
TkZJR19CTEtfREVWX0lERURNQT15CkNPTkZJR19JREVETUFfUENJX1dJUD15CkNPTkZJR19J
REVETUFfTkVXX0RSSVZFX0xJU1RJTkdTPXkKQ09ORklHX0JMS19ERVZfQURNQT15CiMgQ09O
RklHX0JMS19ERVZfQUVDNjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQUxJMTVY
MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQU1ENzRYWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DWTgyQzY5
MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1M1NTIwIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9IUFQzNFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0hQVDM2NiBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU0MxMjAwIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfUElJWD15CiMgQ09ORklHX0JMS19ERVZfTkZPUkNFIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9OUzg3NDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9PUFRJNjIx
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9PTEQgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX1BEQzIwMlhYX05FVyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfUloxMDAwIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfU1ZXS1M9eQojIENPTkZJR19C
TEtfREVWX1NJSU1BR0UgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NJUzU1MTMgaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX1NMQzkwRTY2IGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9UUk0yOTAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1ZJQTgyQ1hYWCBp
cyBub3Qgc2V0CkNPTkZJR19JREVETUFfQVVUTz15CkNPTkZJR19JREVETUFfSVZCPXkKQ09O
RklHX0JMS19ERVZfSURFX01PREVTPXkKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09O
RklHX1NDU0k9eQoKIwojIFNDU0kgc3VwcG9ydCB0eXBlIChkaXNrLCB0YXBlLCBDRC1ST00p
CiMKQ09ORklHX0JMS19ERVZfU0Q9eQpDT05GSUdfQ0hSX0RFVl9TVD1tCkNPTkZJR19DSFJf
REVWX09TU1Q9bQpDT05GSUdfQkxLX0RFVl9TUj1tCkNPTkZJR19CTEtfREVWX1NSX1ZFTkRP
Uj15CkNPTkZJR19DSFJfREVWX1NHPW0KCiMKIyBTb21lIFNDU0kgZGV2aWNlcyAoZS5nLiBD
RCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxlIExVTnMKIwojIENPTkZJR19TQ1NJX01VTFRJ
X0xVTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUkVQT1JUX0xVTlMgaXMgbm90IHNldApD
T05GSUdfU0NTSV9DT05TVEFOVFM9eQpDT05GSUdfU0NTSV9MT0dHSU5HPXkKCiMKIyBTQ1NJ
IGxvdy1sZXZlbCBkcml2ZXJzCiMKIyBDT05GSUdfQkxLX0RFVl8zV19YWFhYX1JBSUQgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0FDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9B
QUNSQUlEIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfQUlDN1hYWD15CkNPTkZJR19BSUM3WFhY
X0NNRFNfUEVSX0RFVklDRT0yNTMKQ09ORklHX0FJQzdYWFhfUkVTRVRfREVMQVlfTVM9MTUw
MDAKIyBDT05GSUdfQUlDN1hYWF9CVUlMRF9GSVJNV0FSRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfQUlDN1hYWF9PTEQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RQVF9JMk8gaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0FEVkFOU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9JTjIwMDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FNNTNDOTc0IGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9NRUdBUkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQlVTTE9H
SUMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NQUUZDVFMgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0RNWDMxOTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9FQVRBX0RNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRUFU
QV9QSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZVVFVSRV9ET01BSU4gaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0dEVEggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0dFTkVSSUNf
TkNSNTM4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0VORVJJQ19OQ1I1MzgwX01NSU8g
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
SU5JVElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JTklBMTAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9QUEEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lNTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfTkNSNTNDN3h4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TWU01
M0M4WFhfMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkNSNTNDOFhYIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9TWU01M0M4WFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BDSTIw
MDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BDSTIyMjBJIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9RTE9HSUNfSVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTE9HSUNfRkMg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9EQzM5MFQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1UxNF8zNEYgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX05TUDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ERUJV
RyBpcyBub3Qgc2V0CgojCiMgTXVsdGktZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExWTSkK
IwojIENPTkZJR19NRCBpcyBub3Qgc2V0CgojCiMgRnVzaW9uIE1QVCBkZXZpY2Ugc3VwcG9y
dAojCiMgQ09ORklHX0ZVU0lPTiBpcyBub3Qgc2V0CgojCiMgSUVFRSAxMzk0IChGaXJlV2ly
ZSkgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKQojCkNPTkZJR19JRUVFMTM5ND1tCgojCiMgRGV2
aWNlIERyaXZlcnMKIwpDT05GSUdfSUVFRTEzOTRfUENJTFlOWD1tCkNPTkZJR19JRUVFMTM5
NF9PSENJMTM5ND1tCgojCiMgUHJvdG9jb2wgRHJpdmVycwojCkNPTkZJR19JRUVFMTM5NF9W
SURFTzEzOTQ9bQpDT05GSUdfSUVFRTEzOTRfU0JQMj1tCkNPTkZJR19JRUVFMTM5NF9TQlAy
X1BIWVNfRE1BPXkKQ09ORklHX0lFRUUxMzk0X0VUSDEzOTQ9bQpDT05GSUdfSUVFRTEzOTRf
RFYxMzk0PW0KQ09ORklHX0lFRUUxMzk0X1JBV0lPPW0KQ09ORklHX0lFRUUxMzk0X0NNUD1t
CkNPTkZJR19JRUVFMTM5NF9BTURUUD1tCiMgQ09ORklHX0lFRUUxMzk0X1ZFUkJPU0VERUJV
RyBpcyBub3Qgc2V0CgojCiMgSTJPIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfSTJPIGlz
IG5vdCBzZXQKCiMKIyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPW0KQ09O
RklHX1BBQ0tFVF9NTUFQPXkKQ09ORklHX05FVExJTktfREVWPW0KQ09ORklHX05FVEZJTFRF
Uj15CiMgQ09ORklHX05FVEZJTFRFUl9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19GSUxURVI9
eQpDT05GSUdfVU5JWD15CiMgQ09ORklHX05FVF9LRVkgaXMgbm90IHNldApDT05GSUdfSU5F
VD15CkNPTkZJR19JUF9NVUxUSUNBU1Q9eQpDT05GSUdfSVBfQURWQU5DRURfUk9VVEVSPXkK
Q09ORklHX0lQX01VTFRJUExFX1RBQkxFUz15CkNPTkZJR19JUF9ST1VURV9GV01BUks9eQpD
T05GSUdfSVBfUk9VVEVfTkFUPXkKQ09ORklHX0lQX1JPVVRFX01VTFRJUEFUSD15CkNPTkZJ
R19JUF9ST1VURV9UT1M9eQpDT05GSUdfSVBfUk9VVEVfVkVSQk9TRT15CkNPTkZJR19JUF9S
T1VURV9MQVJHRV9UQUJMRVM9eQojIENPTkZJR19JUF9QTlAgaXMgbm90IHNldApDT05GSUdf
TkVUX0lQSVA9bQpDT05GSUdfTkVUX0lQR1JFPW0KQ09ORklHX05FVF9JUEdSRV9CUk9BRENB
U1Q9eQpDT05GSUdfSVBfTVJPVVRFPXkKQ09ORklHX0lQX1BJTVNNX1YxPXkKQ09ORklHX0lQ
X1BJTVNNX1YyPXkKIyBDT05GSUdfQVJQRCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUX0VDTj15
CkNPTkZJR19TWU5fQ09PS0lFUz15CkNPTkZJR19JTkVUX0FIPW0KQ09ORklHX0lORVRfRVNQ
PW0KQ09ORklHX1hGUk1fVVNFUj1tCgojCiMgSVA6IE5ldGZpbHRlciBDb25maWd1cmF0aW9u
CiMKQ09ORklHX0lQX05GX0NPTk5UUkFDSz1tCkNPTkZJR19JUF9ORl9GVFA9bQpDT05GSUdf
SVBfTkZfSVJDPW0KIyBDT05GSUdfSVBfTkZfUVVFVUUgaXMgbm90IHNldApDT05GSUdfSVBf
TkZfSVBUQUJMRVM9bQpDT05GSUdfSVBfTkZfTUFUQ0hfTElNSVQ9bQpDT05GSUdfSVBfTkZf
TUFUQ0hfTUFDPW0KQ09ORklHX0lQX05GX01BVENIX1BLVFRZUEU9bQpDT05GSUdfSVBfTkZf
TUFUQ0hfTUFSSz1tCkNPTkZJR19JUF9ORl9NQVRDSF9NVUxUSVBPUlQ9bQpDT05GSUdfSVBf
TkZfTUFUQ0hfVE9TPW0KQ09ORklHX0lQX05GX01BVENIX0VDTj1tCkNPTkZJR19JUF9ORl9N
QVRDSF9EU0NQPW0KQ09ORklHX0lQX05GX01BVENIX0FIX0VTUD1tCkNPTkZJR19JUF9ORl9N
QVRDSF9MRU5HVEg9bQpDT05GSUdfSVBfTkZfTUFUQ0hfVFRMPW0KQ09ORklHX0lQX05GX01B
VENIX1RDUE1TUz1tCkNPTkZJR19JUF9ORl9NQVRDSF9IRUxQRVI9bQpDT05GSUdfSVBfTkZf
TUFUQ0hfU1RBVEU9bQpDT05GSUdfSVBfTkZfTUFUQ0hfQ09OTlRSQUNLPW0KIyBDT05GSUdf
SVBfTkZfTUFUQ0hfVU5DTEVBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX09X
TkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfTUFUQ0hfUEhZU0RFViBpcyBub3Qgc2V0
CkNPTkZJR19JUF9ORl9GSUxURVI9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1JFSkVDVD1tCiMg
Q09ORklHX0lQX05GX1RBUkdFVF9NSVJST1IgaXMgbm90IHNldApDT05GSUdfSVBfTkZfTkFU
PW0KQ09ORklHX0lQX05GX05BVF9ORUVERUQ9eQpDT05GSUdfSVBfTkZfVEFSR0VUX01BU1FV
RVJBREU9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1JFRElSRUNUPW0KQ09ORklHX0lQX05GX05B
VF9MT0NBTD15CiMgQ09ORklHX0lQX05GX05BVF9TTk1QX0JBU0lDIGlzIG5vdCBzZXQKQ09O
RklHX0lQX05GX05BVF9JUkM9bQpDT05GSUdfSVBfTkZfTkFUX0ZUUD1tCkNPTkZJR19JUF9O
Rl9NQU5HTEU9bQpDT05GSUdfSVBfTkZfVEFSR0VUX1RPUz1tCiMgQ09ORklHX0lQX05GX1RB
UkdFVF9FQ04gaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9UQVJHRVRfRFNDUCBpcyBub3Qg
c2V0CkNPTkZJR19JUF9ORl9UQVJHRVRfTUFSSz1tCkNPTkZJR19JUF9ORl9UQVJHRVRfTE9H
PW0KQ09ORklHX0lQX05GX1RBUkdFVF9VTE9HPW0KQ09ORklHX0lQX05GX1RBUkdFVF9UQ1BN
U1M9bQpDT05GSUdfSVBfTkZfQVJQVEFCTEVTPW0KQ09ORklHX0lQX05GX0FSUEZJTFRFUj1t
CiMgQ09ORklHX0lQX05GX0NPTVBBVF9JUENIQUlOUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQ
X05GX0NPTVBBVF9JUEZXQURNIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNiBpcyBub3Qgc2V0
CgojCiMgU0NUUCBDb25maWd1cmF0aW9uIChFWFBFUklNRU5UQUwpCiMKQ09ORklHX0lQVjZf
U0NUUF9fPXkKIyBDT05GSUdfSVBfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBu
b3Qgc2V0CkNPTkZJR19WTEFOXzgwMjFRPW0KIyBDT05GSUdfTExDIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVDTkVUIGlzIG5vdCBzZXQKQ09ORklHX0JSSURHRT1tCiMgQ09ORklHX0JSSURH
RV9ORl9FQlRBQkxFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09O
RklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRElWRVJUIGlzIG5vdCBzZXQKIyBD
T05GSUdfRUNPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOX1JPVVRFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9GQVNUUk9VVEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfSFdfRkxP
V0NPTlRST0wgaXMgbm90IHNldAoKIwojIFFvUyBhbmQvb3IgZmFpciBxdWV1ZWluZwojCkNP
TkZJR19ORVRfU0NIRUQ9eQpDT05GSUdfTkVUX1NDSF9DQlE9bQpDT05GSUdfTkVUX1NDSF9I
VEI9bQpDT05GSUdfTkVUX1NDSF9DU1o9bQpDT05GSUdfTkVUX1NDSF9QUklPPW0KQ09ORklH
X05FVF9TQ0hfUkVEPW0KQ09ORklHX05FVF9TQ0hfU0ZRPW0KQ09ORklHX05FVF9TQ0hfVEVR
TD1tCkNPTkZJR19ORVRfU0NIX1RCRj1tCkNPTkZJR19ORVRfU0NIX0dSRUQ9bQpDT05GSUdf
TkVUX1NDSF9EU01BUks9bQpDT05GSUdfTkVUX1NDSF9JTkdSRVNTPW0KQ09ORklHX05FVF9R
T1M9eQpDT05GSUdfTkVUX0VTVElNQVRPUj15CkNPTkZJR19ORVRfQ0xTPXkKQ09ORklHX05F
VF9DTFNfVENJTkRFWD1tCkNPTkZJR19ORVRfQ0xTX1JPVVRFND1tCkNPTkZJR19ORVRfQ0xT
X1JPVVRFPXkKQ09ORklHX05FVF9DTFNfRlc9bQpDT05GSUdfTkVUX0NMU19VMzI9bQpDT05G
SUdfTkVUX0NMU19SU1ZQPW0KQ09ORklHX05FVF9DTFNfUlNWUDY9bQpDT05GSUdfTkVUX0NM
U19QT0xJQ0U9eQoKIwojIE5ldHdvcmsgdGVzdGluZwojCkNPTkZJR19ORVRfUEtUR0VOPW0K
CiMKIyBOZXR3b3JrIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX05FVERFVklDRVM9eQoKIwoj
IEFSQ25ldCBkZXZpY2VzCiMKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKQ09ORklHX0RV
TU1ZPW0KQ09ORklHX0JPTkRJTkc9bQpDT05GSUdfRVFVQUxJWkVSPW0KQ09ORklHX1RVTj1t
CiMgQ09ORklHX0VUSEVSVEFQIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAw
TWJpdCkKIwpDT05GSUdfTkVUX0VUSEVSTkVUPXkKIyBDT05GSUdfSEFQUFlNRUFMIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1VOR0VNIGlzIG5vdCBzZXQKQ09ORklHX05FVF9WRU5ET1JfM0NP
TT15CkNPTkZJR19WT1JURVg9bQojIENPTkZJR19ORVRfVkVORE9SX1NNQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9WRU5ET1JfUkFDQUwgaXMgbm90IHNldAoKIwojIFR1bGlwIGZhbWls
eSBuZXR3b3JrIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfTkVUX1RVTElQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFAxMDAgaXMgbm90IHNldAojIENPTkZJR19ORVRfUENJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1BPQ0tFVCBpcyBub3Qgc2V0CgojCiMgRXRoZXJuZXQgKDEwMDAg
TWJpdCkKIwojIENPTkZJR19BQ0VOSUMgaXMgbm90IHNldAojIENPTkZJR19ETDJLIGlzIG5v
dCBzZXQKIyBDT05GSUdfRTEwMDAgaXMgbm90IHNldAojIENPTkZJR19OUzgzODIwIGlzIG5v
dCBzZXQKIyBDT05GSUdfSEFNQUNISSBpcyBub3Qgc2V0CiMgQ09ORklHX1lFTExPV0ZJTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NLOThMSU4gaXMgbm90IHNldAojIENPTkZJR19USUdPTjMg
aXMgbm90IHNldAojIENPTkZJR19GRERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElQUEkgaXMg
bm90IHNldAojIENPTkZJR19QTElQIGlzIG5vdCBzZXQKQ09ORklHX1BQUD1tCkNPTkZJR19Q
UFBfTVVMVElMSU5LPXkKQ09ORklHX1BQUF9GSUxURVI9eQpDT05GSUdfUFBQX0FTWU5DPW0K
Q09ORklHX1BQUF9TWU5DX1RUWT1tCkNPTkZJR19QUFBfREVGTEFURT1tCkNPTkZJR19QUFBf
QlNEQ09NUD1tCkNPTkZJR19QUFBPRT1tCkNPTkZJR19TTElQPW0KQ09ORklHX1NMSVBfQ09N
UFJFU1NFRD15CkNPTkZJR19TTElQX1NNQVJUPXkKQ09ORklHX1NMSVBfTU9ERV9TTElQNj15
CgojCiMgV2lyZWxlc3MgTEFOIChub24taGFtcmFkaW8pCiMKIyBDT05GSUdfTkVUX1JBRElP
IGlzIG5vdCBzZXQKCiMKIyBUb2tlbiBSaW5nIGRldmljZXMgKGRlcGVuZHMgb24gTExDPXkp
CiMKIyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNQQ0kgaXMgbm90IHNl
dAojIENPTkZJR19TSEFQRVIgaXMgbm90IHNldAoKIwojIFdhbiBpbnRlcmZhY2VzCiMKIyBD
T05GSUdfV0FOIGlzIG5vdCBzZXQKCiMKIyBBbWF0ZXVyIFJhZGlvIHN1cHBvcnQKIwojIENP
TkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CgojCiMgSXJEQSAoaW5mcmFyZWQpIHN1cHBvcnQK
IwojIENPTkZJR19JUkRBIGlzIG5vdCBzZXQKCiMKIyBJU0ROIHN1YnN5c3RlbQojCiMgQ09O
RklHX0lTRE5fQk9PTCBpcyBub3Qgc2V0CgojCiMgVGVsZXBob255IFN1cHBvcnQKIwojIENP
TkZJR19QSE9ORSBpcyBub3Qgc2V0CgojCiMgSW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05G
SUdfSU5QVVQ9eQoKIwojIFVzZXJsYW5kIGludGVyZmFjZXMKIwpDT05GSUdfSU5QVVRfTU9V
U0VERVY9bQpDT05GSUdfSU5QVVRfTU9VU0VERVZfUFNBVVg9eQpDT05GSUdfSU5QVVRfTU9V
U0VERVZfU0NSRUVOX1g9MTAyNApDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1k9NzY4
CkNPTkZJR19JTlBVVF9KT1lERVY9bQojIENPTkZJR19JTlBVVF9UU0RFViBpcyBub3Qgc2V0
CkNPTkZJR19JTlBVVF9FVkRFVj1tCiMgQ09ORklHX0lOUFVUX0VWQlVHIGlzIG5vdCBzZXQK
CiMKIyBJbnB1dCBJL08gZHJpdmVycwojCiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQK
Q09ORklHX1NPVU5EX0dBTUVQT1JUPXkKQ09ORklHX1NFUklPPXkKQ09ORklHX1NFUklPX0k4
MDQyPXkKQ09ORklHX1NFUklPX1NFUlBPUlQ9eQojIENPTkZJR19TRVJJT19DVDgyQzcxMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BBUktCRCBpcyBub3Qgc2V0CgojCiMgSW5wdXQg
RGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9B
UkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAojIENPTkZJ
R19LRVlCT0FSRF9YVEtCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX05FV1RPTiBp
cyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRT15CkNPTkZJR19NT1VTRV9QUzI9eQojIENP
TkZJR19NT1VTRV9TRVJJQUwgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElDSyBp
cyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5QVVRfTUlTQyBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmljZXMKIwpDT05G
SUdfVlQ9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkKQ09ORklH
X1NFUklBTF9OT05TVEFOREFSRD15CiMgQ09ORklHX0NPTVBVVE9ORSBpcyBub3Qgc2V0CiMg
Q09ORklHX1JPQ0tFVFBPUlQgaXMgbm90IHNldAojIENPTkZJR19DWUNMQURFUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RJR0lFUENBIGlzIG5vdCBzZXQKIyBDT05GSUdfRElHSSBpcyBub3Qg
c2V0CiMgQ09ORklHX01PWEFfSU5URUxMSU8gaXMgbm90IHNldAojIENPTkZJR19NT1hBX1NN
QVJUSU8gaXMgbm90IHNldAojIENPTkZJR19JU0kgaXMgbm90IHNldAojIENPTkZJR19TWU5D
TElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTkNMSU5LTVAgaXMgbm90IHNldAojIENPTkZJ
R19OX0hETEMgaXMgbm90IHNldAojIENPTkZJR19SSVNDT004IGlzIG5vdCBzZXQKIyBDT05G
SUdfU1BFQ0lBTElYIGlzIG5vdCBzZXQKIyBDT05GSUdfU1ggaXMgbm90IHNldAojIENPTkZJ
R19SSU8gaXMgbm90IHNldAojIENPTkZJR19TVEFMRFJWIGlzIG5vdCBzZXQKCiMKIyBTZXJp
YWwgZHJpdmVycwojCkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9D
T05TT0xFPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfRVhURU5ERUQgaXMgbm90IHNldAoKIwoj
IE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQKIwpDT05GSUdfU0VSSUFMX0NPUkU9eQpD
T05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJ
R19VTklYOThfUFRZX0NPVU5UPTI1NgpDT05GSUdfUFJJTlRFUj1tCiMgQ09ORklHX0xQX0NP
TlNPTEUgaXMgbm90IHNldApDT05GSUdfUFBERVY9bQojIENPTkZJR19USVBBUiBpcyBub3Qg
c2V0CgojCiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPW0KQ09ORklHX0kyQ19BTEdPQklU
PW0KQ09ORklHX0kyQ19QSElMSVBTUEFSPW0KQ09ORklHX0kyQ19FTFY9bQpDT05GSUdfSTJD
X1ZFTExFTUFOPW0KIyBDT05GSUdfU0N4MjAwX0FDQiBpcyBub3Qgc2V0CkNPTkZJR19JMkNf
QUxHT1BDRj1tCkNPTkZJR19JMkNfRUxFS1RPUj1tCkNPTkZJR19JMkNfQ0hBUkRFVj1tCkNP
TkZJR19JMkNfUFJPQz1tCgojCiMgTWljZQojCkNPTkZJR19CVVNNT1VTRT1tCiMgQ09ORklH
X1FJQzAyX1RBUEUgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKQ09ORklHX1dB
VENIRE9HPXkKIyBDT05GSUdfV0FUQ0hET0dfTk9XQVlPVVQgaXMgbm90IHNldApDT05GSUdf
U09GVF9XQVRDSERPRz1tCkNPTkZJR19XRFQ9bQpDT05GSUdfV0RUUENJPW0KQ09ORklHX1dE
VF81MDE9eQpDT05GSUdfV0RUXzUwMV9GQU49eQpDT05GSUdfUENXQVRDSERPRz1tCkNPTkZJ
R19BQ1FVSVJFX1dEVD1tCkNPTkZJR19BRFZBTlRFQ0hfV0RUPW0KQ09ORklHX0VVUk9URUNI
X1dEVD1tCkNPTkZJR19JQjcwMF9XRFQ9bQpDT05GSUdfSTgxMF9UQ089bQpDT05GSUdfTUlY
Q09NV0Q9bQojIENPTkZJR19TQ3gyMDBfV0RUIGlzIG5vdCBzZXQKQ09ORklHXzYwWFhfV0RU
PW0KQ09ORklHX1c4Mzg3N0ZfV0RUPW0KQ09ORklHX01BQ0haX1dEVD1tCkNPTkZJR19JTlRF
TF9STkc9eQojIENPTkZJR19BTURfUk5HIGlzIG5vdCBzZXQKQ09ORklHX05WUkFNPW0KQ09O
RklHX1JUQz15CiMgQ09ORklHX0RUTEsgaXMgbm90IHNldAojIENPTkZJR19SMzk2NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfU09OWVBJIGlz
IG5vdCBzZXQKCiMKIyBGdGFwZSwgdGhlIGZsb3BweSB0YXBlIGRldmljZSBkcml2ZXIKIwoj
IENPTkZJR19GVEFQRSBpcyBub3Qgc2V0CkNPTkZJR19BR1A9eQojIENPTkZJR19BR1BfSU5U
RUwgaXMgbm90IHNldApDT05GSUdfQUdQX0k4MTA9eQojIENPTkZJR19BR1BfVklBIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUdQX0FNRCBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9TSVMgaXMg
bm90IHNldAojIENPTkZJR19BR1BfQUxJIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX1NXT1JL
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9BTURfODE1MSBpcyBub3Qgc2V0CkNPTkZJR19E
Uk09eQojIENPTkZJR19EUk1fVERGWCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9SMTI4IGlz
IG5vdCBzZXQKIyBDT05GSUdfRFJNX1JBREVPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9J
ODEwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0k4MzAgaXMgbm90IHNldApDT05GSUdfRFJN
X01HQT1tCiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFXX0RSSVZFUiBp
cyBub3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZpY2VzCiMKIyBDT05GSUdfVklERU9fREVW
IGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfUVVPVEE9eQojIENPTkZJ
R19RRk1UX1YxIGlzIG5vdCBzZXQKQ09ORklHX1FGTVRfVjI9eQpDT05GSUdfUVVPVEFDVEw9
eQojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNldApDT05GSUdfQVVUT0ZTNF9GUz1tCkNP
TkZJR19SRUlTRVJGU19GUz1tCiMgQ09ORklHX1JFSVNFUkZTX0NIRUNLIGlzIG5vdCBzZXQK
Q09ORklHX1JFSVNFUkZTX1BST0NfSU5GTz15CkNPTkZJR19BREZTX0ZTPW0KIyBDT05GSUdf
QURGU19GU19SVyBpcyBub3Qgc2V0CkNPTkZJR19BRkZTX0ZTPW0KQ09ORklHX0hGU19GUz1t
CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldApDT05GSUdfQkZTX0ZTPW0KQ09ORklHX0VY
VDNfRlM9bQpDT05GSUdfRVhUM19GU19YQVRUUj15CkNPTkZJR19FWFQzX0ZTX1BPU0lYX0FD
TD15CkNPTkZJR19KQkQ9eQojIENPTkZJR19KQkRfREVCVUcgaXMgbm90IHNldApDT05GSUdf
RkFUX0ZTPW0KQ09ORklHX01TRE9TX0ZTPW0KQ09ORklHX1ZGQVRfRlM9bQpDT05GSUdfRUZT
X0ZTPW0KQ09ORklHX0NSQU1GUz1tCkNPTkZJR19UTVBGUz15CkNPTkZJR19SQU1GUz15CkNP
TkZJR19JU085NjYwX0ZTPW0KQ09ORklHX0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQpDT05G
SUdfSkZTX0ZTPW0KQ09ORklHX0pGU19QT1NJWF9BQ0w9eQojIENPTkZJR19KRlNfREVCVUcg
aXMgbm90IHNldApDT05GSUdfSkZTX1NUQVRJU1RJQ1M9eQpDT05GSUdfTUlOSVhfRlM9bQpD
T05GSUdfVlhGU19GUz1tCkNPTkZJR19OVEZTX0ZTPW0KIyBDT05GSUdfTlRGU19ERUJVRyBp
cyBub3Qgc2V0CiMgQ09ORklHX05URlNfUlcgaXMgbm90IHNldApDT05GSUdfSFBGU19GUz1t
CkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX0RFVkZTX0ZTPXkKQ09ORklHX0RFVkZTX01PVU5U
PXkKIyBDT05GSUdfREVWRlNfREVCVUcgaXMgbm90IHNldApDT05GSUdfREVWUFRTX0ZTPXkK
IyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX1JPTUZTX0ZTPW0KQ09ORklH
X0VYVDJfRlM9eQpDT05GSUdfRVhUMl9GU19YQVRUUj15CkNPTkZJR19FWFQyX0ZTX1BPU0lY
X0FDTD15CkNPTkZJR19TWVNWX0ZTPW0KQ09ORklHX1VERl9GUz1tCkNPTkZJR19VRlNfRlM9
bQojIENPTkZJR19VRlNfRlNfV1JJVEUgaXMgbm90IHNldApDT05GSUdfWEZTX0ZTPXkKQ09O
RklHX1hGU19SVD15CkNPTkZJR19YRlNfUVVPVEE9eQpDT05GSUdfWEZTX1BPU0lYX0FDTD15
CgojCiMgTmV0d29yayBGaWxlIFN5c3RlbXMKIwojIENPTkZJR19DT0RBX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5URVJNRVpaT19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORlNfRlM9bQpD
T05GSUdfTkZTX1YzPXkKIyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBzZXQKQ09ORklHX05GU0Q9
bQpDT05GSUdfTkZTRF9WMz15CiMgQ09ORklHX05GU0RfVjQgaXMgbm90IHNldAojIENPTkZJ
R19ORlNEX1RDUCBpcyBub3Qgc2V0CkNPTkZJR19TVU5SUEM9bQpDT05GSUdfTE9DS0Q9bQpD
T05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfRVhQT1JURlM9bQojIENPTkZJR19DSUZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfU01CX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkNQX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX1pJU09GU19GUz1tCkNP
TkZJR19GU19NQkNBQ0hFPXkKQ09ORklHX0ZTX1BPU0lYX0FDTD15CgojCiMgUGFydGl0aW9u
IFR5cGVzCiMKIyBDT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEIGlzIG5vdCBzZXQKQ09ORklH
X01TRE9TX1BBUlRJVElPTj15CkNPTkZJR19OTFM9eQoKIwojIE5hdGl2ZSBMYW5ndWFnZSBT
dXBwb3J0CiMKQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiCkNPTkZJR19OTFNfQ09E
RVBBR0VfNDM3PW0KQ09ORklHX05MU19DT0RFUEFHRV83Mzc9bQpDT05GSUdfTkxTX0NPREVQ
QUdFXzc3NT1tCkNPTkZJR19OTFNfQ09ERVBBR0VfODUwPW0KQ09ORklHX05MU19DT0RFUEFH
RV84NTI9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg1NT1tCkNPTkZJR19OTFNfQ09ERVBBR0Vf
ODU3PW0KQ09ORklHX05MU19DT0RFUEFHRV84NjA9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg2
MT1tCkNPTkZJR19OTFNfQ09ERVBBR0VfODYyPW0KQ09ORklHX05MU19DT0RFUEFHRV84NjM9
bQpDT05GSUdfTkxTX0NPREVQQUdFXzg2ND1tCkNPTkZJR19OTFNfQ09ERVBBR0VfODY1PW0K
Q09ORklHX05MU19DT0RFUEFHRV84NjY9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg2OT1tCkNP
TkZJR19OTFNfQ09ERVBBR0VfOTM2PW0KQ09ORklHX05MU19DT0RFUEFHRV85NTA9bQpDT05G
SUdfTkxTX0NPREVQQUdFXzkzMj1tCkNPTkZJR19OTFNfQ09ERVBBR0VfOTQ5PW0KQ09ORklH
X05MU19DT0RFUEFHRV84NzQ9bQpDT05GSUdfTkxTX0lTTzg4NTlfOD1tCkNPTkZJR19OTFNf
Q09ERVBBR0VfMTI1MD1tCkNPTkZJR19OTFNfQ09ERVBBR0VfMTI1MT1tCkNPTkZJR19OTFNf
SVNPODg1OV8xPW0KQ09ORklHX05MU19JU084ODU5XzI9bQpDT05GSUdfTkxTX0lTTzg4NTlf
Mz1tCkNPTkZJR19OTFNfSVNPODg1OV80PW0KQ09ORklHX05MU19JU084ODU5XzU9bQpDT05G
SUdfTkxTX0lTTzg4NTlfNj1tCkNPTkZJR19OTFNfSVNPODg1OV83PW0KQ09ORklHX05MU19J
U084ODU5Xzk9bQpDT05GSUdfTkxTX0lTTzg4NTlfMTM9bQpDT05GSUdfTkxTX0lTTzg4NTlf
MTQ9bQpDT05GSUdfTkxTX0lTTzg4NTlfMTU9bQpDT05GSUdfTkxTX0tPSThfUj1tCkNPTkZJ
R19OTFNfS09JOF9VPW0KQ09ORklHX05MU19VVEY4PW0KCiMKIyBDb25zb2xlIGRyaXZlcnMK
IwpDT05GSUdfVkdBX0NPTlNPTEU9eQpDT05GSUdfVklERU9fU0VMRUNUPXkKIyBDT05GSUdf
TURBX0NPTlNPTEUgaXMgbm90IHNldAoKIwojIEZyYW1lLWJ1ZmZlciBzdXBwb3J0CiMKIyBD
T05GSUdfRkIgaXMgbm90IHNldAoKIwojIFNvdW5kCiMKQ09ORklHX1NPVU5EPW0KCiMKIyBP
cGVuIFNvdW5kIFN5c3RlbQojCiMgQ09ORklHX1NPVU5EX1BSSU1FIGlzIG5vdCBzZXQKCiMK
IyBBZHZhbmNlZCBMaW51eCBTb3VuZCBBcmNoaXRlY3R1cmUKIwpDT05GSUdfU05EPW0KQ09O
RklHX1NORF9TRVFVRU5DRVI9bQpDT05GSUdfU05EX1NFUV9EVU1NWT1tCkNPTkZJR19TTkRf
T1NTRU1VTD15CkNPTkZJR19TTkRfTUlYRVJfT1NTPW0KQ09ORklHX1NORF9QQ01fT1NTPW0K
Q09ORklHX1NORF9TRVFVRU5DRVJfT1NTPXkKIyBDT05GSUdfU05EX1JUQ1RJTUVSIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX1ZFUkJPU0VfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBHZW5lcmljIGRldmljZXMKIwpDT05GSUdfU05E
X0RVTU1ZPW0KQ09ORklHX1NORF9WSVJNSURJPW0KQ09ORklHX1NORF9NVFBBVj1tCkNPTkZJ
R19TTkRfU0VSSUFMX1UxNjU1MD1tCkNPTkZJR19TTkRfTVBVNDAxPW0KCiMKIyBQQ0kgZGV2
aWNlcwojCiMgQ09ORklHX1NORF9BTEk1NDUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NT
NDZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DUzQyODEgaXMgbm90IHNldApDT05GSUdf
U05EX0VNVTEwSzE9bQojIENPTkZJR19TTkRfS09SRzEyMTIgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfTk0yNTYgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FMzIgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfUk1FOTYgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FOTY1MiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1RSSURF
TlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfWU1GUENJIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0FMUzQwMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQ01JUENJIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0VOUzEzNzAgaXMgbm90IHNldAojIENPTkZJR19TTkRfRU5TMTM3MSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5MzggaXMgbm90IHNldAojIENPTkZJR19TTkRf
RVMxOTY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01BRVNUUk8zIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0ZNODAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MTIgaXMgbm90
IHNldAojIENPTkZJR19TTkRfSU5URUw4WDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09O
SUNWSUJFUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WSUE4MlhYIGlzIG5vdCBzZXQKCiMK
IyBBTFNBIFVTQiBkZXZpY2VzCiMKQ09ORklHX1NORF9VU0JfQVVESU89bQoKIwojIFVTQiBz
dXBwb3J0CiMKQ09ORklHX1VTQj1tCiMgQ09ORklHX1VTQl9ERUJVRyBpcyBub3Qgc2V0Cgoj
CiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0JfREVWSUNFRlM9eQoj
IENPTkZJR19VU0JfQkFORFdJRFRIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RZTkFNSUNf
TUlOT1JTIGlzIG5vdCBzZXQKCiMKIyBVU0IgSG9zdCBDb250cm9sbGVyIERyaXZlcnMKIwpD
T05GSUdfVVNCX0VIQ0lfSENEPW0KQ09ORklHX1VTQl9PSENJX0hDRD1tCkNPTkZJR19VU0Jf
VUhDSV9IQ0Q9bQoKIwojIFVTQiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCkNPTkZJR19VU0Jf
QVVESU89bQojIENPTkZJR19VU0JfQkxVRVRPT1RIX1RUWSBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9NSURJIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BQ009bQpDT05GSUdfVVNCX1BSSU5U
RVI9bQpDT05GSUdfVVNCX1NUT1JBR0U9bQojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJVRyBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCPXkKQ09ORklHX1VTQl9TVE9S
QUdFX0ZSRUVDT009eQpDT05GSUdfVVNCX1NUT1JBR0VfSVNEMjAwPXkKQ09ORklHX1VTQl9T
VE9SQUdFX0RQQ009eQpDT05GSUdfVVNCX1NUT1JBR0VfSFA4MjAwZT15CkNPTkZJR19VU0Jf
U1RPUkFHRV9TRERSMDk9eQojIENPTkZJR19VU0JfU1RPUkFHRV9TRERSNTUgaXMgbm90IHNl
dApDT05GSUdfVVNCX1NUT1JBR0VfSlVNUFNIT1Q9eQoKIwojIFVTQiBIdW1hbiBJbnRlcmZh
Y2UgRGV2aWNlcyAoSElEKQojCkNPTkZJR19VU0JfSElEPW0KQ09ORklHX1VTQl9ISURJTlBV
VD15CiMgQ09ORklHX0hJRF9GRiBpcyBub3Qgc2V0CkNPTkZJR19VU0JfSElEREVWPXkKCiMK
IyBVU0IgSElEIEJvb3QgUHJvdG9jb2wgZHJpdmVycwojCkNPTkZJR19VU0JfS0JEPW0KQ09O
RklHX1VTQl9NT1VTRT1tCiMgQ09ORklHX1VTQl9BSVBURUsgaXMgbm90IHNldApDT05GSUdf
VVNCX1dBQ09NPW0KIyBDT05GSUdfVVNCX1BPV0VSTUFURSBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9YUEFEIGlzIG5vdCBzZXQKCiMKIyBVU0IgSW1hZ2luZyBkZXZpY2VzCiMKQ09ORklH
X1VTQl9NREM4MDA9bQpDT05GSUdfVVNCX1NDQU5ORVI9bQpDT05GSUdfVVNCX01JQ1JPVEVL
PW0KQ09ORklHX1VTQl9IUFVTQlNDU0k9bQoKIwojIFVTQiBNdWx0aW1lZGlhIGRldmljZXMK
IwpDT05GSUdfVVNCX0RBQlVTQj1tCgojCiMgVmlkZW80TGludXggc3VwcG9ydCBpcyBuZWVk
ZWQgZm9yIFVTQiBNdWx0aW1lZGlhIGRldmljZSBzdXBwb3J0CiMKCiMKIyBVU0IgTmV0d29y
ayBhZGFwdG9ycwojCkNPTkZJR19VU0JfQ0FUQz1tCkNPTkZJR19VU0JfQ0RDRVRIRVI9bQpD
T05GSUdfVVNCX0tBV0VUSD1tCkNPTkZJR19VU0JfUEVHQVNVUz1tCkNPTkZJR19VU0JfUlRM
ODE1MD1tCkNPTkZJR19VU0JfVVNCTkVUPW0KCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKQ09O
RklHX1VTQl9VU1M3MjA9bQoKIwojIFVTQiBTZXJpYWwgQ29udmVydGVyIHN1cHBvcnQKIwpD
T05GSUdfVVNCX1NFUklBTD1tCkNPTkZJR19VU0JfU0VSSUFMX0dFTkVSSUM9eQpDT05GSUdf
VVNCX1NFUklBTF9CRUxLSU49bQpDT05GSUdfVVNCX1NFUklBTF9XSElURUhFQVQ9bQpDT05G
SUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQ9bQpDT05GSUdfVVNCX1NFUklBTF9FTVBF
Rz1tCkNPTkZJR19VU0JfU0VSSUFMX0ZURElfU0lPPW0KQ09ORklHX1VTQl9TRVJJQUxfVklT
T1I9bQpDT05GSUdfVVNCX1NFUklBTF9JUEFRPW0KQ09ORklHX1VTQl9TRVJJQUxfSVI9bQpD
T05GSUdfVVNCX1NFUklBTF9FREdFUE9SVD1tCiMgQ09ORklHX1VTQl9TRVJJQUxfRURHRVBP
UlRfVEkgaXMgbm90IHNldApDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1BEQT1tCkNPTkZJ
R19VU0JfU0VSSUFMX0tFWVNQQU49bQpDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4
PXkKQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0EyOFg9eQpDT05GSUdfVVNCX1NFUklB
TF9LRVlTUEFOX1VTQTI4WEE9eQpDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WEI9
eQpDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTE5PXkKQ09ORklHX1VTQl9TRVJJQUxf
S0VZU1BBTl9VU0ExOFg9eQpDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTE5Vz15CiMg
Q09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0ExOVFXIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9LRVlTUEFOX1VTQTE5UUkgaXMgbm90IHNldApDT05GSUdfVVNCX1NFUklB
TF9LRVlTUEFOX1VTQTQ5Vz15CkNPTkZJR19VU0JfU0VSSUFMX0tMU0k9bQpDT05GSUdfVVNC
X1NFUklBTF9NQ1RfVTIzMj1tCkNPTkZJR19VU0JfU0VSSUFMX1BMMjMwMz1tCkNPTkZJR19V
U0JfU0VSSUFMX1NBRkU9bQpDT05GSUdfVVNCX1NFUklBTF9TQUZFX1BBRERFRD15CkNPTkZJ
R19VU0JfU0VSSUFMX0NZQkVSSkFDSz1tCkNPTkZJR19VU0JfU0VSSUFMX1hJUkNPTT1tCkNP
TkZJR19VU0JfU0VSSUFMX09NTklORVQ9bQpDT05GSUdfVVNCX0VaVVNCPXkKCiMKIyBVU0Ig
TWlzY2VsbGFuZW91cyBkcml2ZXJzCiMKQ09ORklHX1VTQl9FTUkyNj1tCiMgQ09ORklHX1VT
Ql9USUdMIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9BVUVSU1dBTEQ9bQpDT05GSUdfVVNCX1JJ
TzUwMD1tCkNPTkZJR19VU0JfQlJMVkdFUj1tCiMgQ09ORklHX1VTQl9MQ0QgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfVEVTVCBpcyBub3Qgc2V0CgojCiMgQmx1ZXRvb3RoIHN1cHBvcnQK
IwojIENPTkZJR19CVCBpcyBub3Qgc2V0CgojCiMgUHJvZmlsaW5nIHN1cHBvcnQKIwojIENP
TkZJR19QUk9GSUxJTkcgaXMgbm90IHNldAoKIwojIEtlcm5lbCBoYWNraW5nCiMKQ09ORklH
X0RFQlVHX0tFUk5FTD15CkNPTkZJR19ERUJVR19TVEFDS09WRVJGTE9XPXkKQ09ORklHX0RF
QlVHX1NMQUI9eQpDT05GSUdfREVCVUdfSU9WSVJUPXkKQ09ORklHX01BR0lDX1NZU1JRPXkK
Q09ORklHX0RFQlVHX1NQSU5MT0NLPXkKQ09ORklHX0RFQlVHX0hJR0hNRU09eQpDT05GSUdf
S0FMTFNZTVM9eQpDT05GSUdfREVCVUdfU1BJTkxPQ0tfU0xFRVA9eQpDT05GSUdfRlJBTUVf
UE9JTlRFUj15CkNPTkZJR19YODZfRVhUUkFfSVJRUz15CkNPTkZJR19YODZfRklORF9TTVBf
Q09ORklHPXkKQ09ORklHX1g4Nl9NUFBBUlNFPXkKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMK
Q09ORklHX1NFQ1VSSVRZPXkKQ09ORklHX1NFQ1VSSVRZX0NBUEFCSUxJVElFUz15CgojCiMg
Q3J5cHRvZ3JhcGhpYyBvcHRpb25zCiMKQ09ORklHX0NSWVBUTz15CkNPTkZJR19DUllQVE9f
SE1BQz15CkNPTkZJR19DUllQVE9fTlVMTD1tCkNPTkZJR19DUllQVE9fTUQ0PW0KQ09ORklH
X0NSWVBUT19NRDU9bQpDT05GSUdfQ1JZUFRPX1NIQTE9bQpDT05GSUdfQ1JZUFRPX1NIQTI1
Nj1tCkNPTkZJR19DUllQVE9fREVTPW0KQ09ORklHX0NSWVBUT19CTE9XRklTSD1tCkNPTkZJ
R19DUllQVE9fVEVTVD1tCgojCiMgTGlicmFyeSByb3V0aW5lcwojCkNPTkZJR19DUkMzMj1t
CkNPTkZJR19aTElCX0lORkxBVEU9bQpDT05GSUdfWkxJQl9ERUZMQVRFPW0KQ09ORklHX1g4
Nl9TTVA9eQpDT05GSUdfWDg2X0hUPXkKQ09ORklHX1g4Nl9CSU9TX1JFQk9PVD15Cg==
--------------050709040006090900060406--

