Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbTBINDu>; Sun, 9 Feb 2003 08:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTBINDt>; Sun, 9 Feb 2003 08:03:49 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:50189 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267229AbTBINDf>; Sun, 9 Feb 2003 08:03:35 -0500
Date: Sun, 9 Feb 2003 14:12:59 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.59-mm8 / ext3 oops
Message-ID: <20030209131259.GA1944@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just happened after startup, before I was inputting anything.
It certainly isn't repeatable, since I never got it in the 10+ earlier
reboots I did with 2.5.59-mm8. Below are the oops, the mounting table,
dmesg, .config and lspci.

Kind regards,
Jurriaan

------------[ cut here ]------------
kernel BUG at fs/ext3/super.c:1724!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c019ae0c>]    Tainted: PF
EFLAGS: 00010246
EIP is at ext3_write_super+0x4c/0x90
eax: 00000000   ebx: 00000000   ecx: c1789050   edx: dfdbc000
esi: c1789000   edi: dfdbdfdc   ebp: dfdbdfd0   esp: dfdbdec8
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 11, threadinfo=dfdbc000 task=dfdbe680)
Stack: df74aa00 00000000 c1789000 c1789050 c015b42b c1789000 dfdbc000 dfdbc000
       c013c6ce c04ef340 00012fe0 0000a728 00000000 00000000 dfdbdef4 00000000
       00000001 00000000 00000001 00000000 0000019b 00000000 00002e11 00000134
Call Trace:
 [<c015b42b>] sync_supers+0xcb/0xf0
 [<c013c6ce>] wb_kupdate+0x4e/0x120
 [<c011d4c8>] do_schedule+0x1d8/0x3c0
 [<c013cfdc>] __pdflush+0x16c/0x290
 [<c011ca55>] schedule_tail+0x65/0x70
 [<c013d100>] pdflush+0x0/0x20
 [<c013d10f>] pdflush+0xf/0x20
 [<c013c680>] wb_kupdate+0x0/0x120
 [<c01072c8>] kernel_thread_helper+0x0/0x18
 [<c01072cd>] kernel_thread_helper+0x5/0x18

Code: 0f 0b bc 06 78 a9 3b c0 c6 46 15 00 8b 86 48 01 00 00 c7 44

/dev/hda7 on / type ext2 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda6 on /grub-boot type ext2 (rw,errors=remount-ro)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
sysfs on /devices type sysfs (rw)
/dev/hda8 on /usr type ext3 (rw)
/dev/hda10 on /var type ext3 (rw)
/dev/hda11 on /var/spool type reiserfs (rw)
/dev/hda12 on /vmware type reiserfs (rw)
/dev/md0 on /home type reiserfs (rw)
/dev/md1 on /var/spool/newszilla type reiserfs (rw)
/dev/hde1 on /space1 type reiserfs (rw)
/dev/hde2 on /space2 type reiserfs (rw)
/dev/hdf1 on /space3 type reiserfs (rw)
/dev/hdf2 on /space4 type reiserfs (rw)
/dev/hda1 on /dos/c type ntfs (ro,noexec,nosuid,nodev,uid=500,gid=500)
/dev/hda5 on /dos/d type vfat (rw,noexec,nosuid,nodev,umask=022,uid=1000,gid=100)

Linux middle 2.5.59 #1 SMP Fri Feb 7 20:37:10 CET 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.9
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.6
Modules Loaded         vmnet vmmon

Linux version 2.5.59 (root@middle) (gcc version 3.2.2) #1 SMP Fri Feb 7 20:37:10 CET 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4f80
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:11 APIC version 17
Processor #1 6:11 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram apm=smp apm=power-off
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
sched_init().
smp_processor_id(): 0.
rq_idx(smp_processor_id()): 0.
this_rq(): c0470b00.
Detected 1173.675 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2318.33 BogoMIPS
Memory: 514028k/524224k available (2686k kernel code, 9456k reserved, 842k data, 396k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) III CPU - S         1400MHz stepping 04
per-CPU timeslice cutoff: 1463.48 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2342.91 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Pentium(R) III CPU - S         1400MHz stepping 04
Total of 2 processors activated (4661.24 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 25.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
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
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1173.0636 MHz.
..... host bus clock speed is 111.0774 MHz.
checking TSC synchronization across 2 CPUs: passed.
cpu_has_ht: 0, smp_num_siblings: 1, num_online_cpus(): 1.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem driver Revision: 1.00
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3101] at 00:00.0
PCI->APIC IRQ transform: (B0,I9,P0) -> 11
PCI->APIC IRQ transform: (B0,I11,P0) -> 10
PCI->APIC IRQ transform: (B0,I12,P0) -> 5
PCI->APIC IRQ transform: (B0,I13,P0) -> 11
PCI->APIC IRQ transform: (B0,I14,P0) -> 10
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 5
PCI->APIC IRQ transform: (B0,I17,P3) -> 5
PCI->APIC IRQ transform: (B0,I17,P3) -> 5
PCI->APIC IRQ transform: (B0,I18,P0) -> 11
PCI->APIC IRQ transform: (B1,I0,P0) -> 11
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Starting balanced_irq
Enabling SEP on CPU 0
Enabling SEP on CPU 1
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(30)
parport0: assign_addrs: aa5500ff(30)
parport0: cpp_daisy: aa5500ff(30)
parport0: assign_addrs: aa5500ff(30)
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD4000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 266T chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xda022000, 00:d0:68:00:5a:8b, IRQ 11.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xe281e000, 00:A0:CC:21:A1:AC, IRQ 5.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 00:0d.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 4G120J6, ATA DISK drive
hdf: Maxtor 4G120J6, ATA DISK drive
ide2 at 0xb000-0xb007,0xb402 on irq 11
hdg: IBM-DTLA-307045, ATA DISK drive
ide3 at 0xb800-0xb807,0xbc02 on irq 11
HPT370A: IDE controller at PCI slot 00:0f.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xd800-0xd807, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xd808-0xd80f, BIOS settings: hdk:DMA, hdl:pio
hdi: WDC WD800JB-00CRA1, ATA DISK drive
ide4 at 0xc800-0xc807,0xcc02 on irq 10
hdk: WDC WD800JB-00CRA1, ATA DISK drive
ide5 at 0xd000-0xd007,0xd402 on irq 10
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 33073H3, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hde: host protected area => 1
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
 hde: hde1 hde2
hdf: host protected area => 1
hdf: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
 hdf: hdf1 hdf2
hdg: host protected area => 1
hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 hdg: hdg1 hdg2
hdi: host protected area => 1
hdi: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hdi: hdi1 hdi2
hdk: host protected area => 1
hdk: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hdk: hdk1 hdk2
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=59556/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 1984kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
scsi HBA driver sym53c8xx didn't set a release method, please fix the template
sym.0.11.0: setting PCI_COMMAND_PARITY...
sym.0.11.0: setting PCI_COMMAND_INVALIDATE.
sym0: <860> rev 0x13 on pci bus 0 device 11 function 0 irq 10
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sym0:5: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.10:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-dev.o: Registered 'DDC:fb0 #0 on i2c-matroxfb' as minor 0
i2c-dev.o: Registered 'DDC:fb0 #1 on i2c-matroxfb' as minor 1
i2c-dev.o: Registered 'MAVEN:fb0 on i2c-matroxfb' as minor 2
i2c-proc.o version 2.6.4 (20020719)
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2144.000 MB/sec
   8regs_prefetch:  1832.000 MB/sec
   32regs    :  1100.000 MB/sec
   32regs_prefetch:  1128.000 MB/sec
   pIII_sse  :  2692.000 MB/sec
   pII_mmx   :  2580.000 MB/sec
   p5_mmx    :  2700.000 MB/sec
raid5: using function: pIII_sse (2692.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Jan 28 12:17:23 2003 UTC).
ALSA device list:
  #0: Sound Blaster Live! (rev.7) at 0xa000, irq 11
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdk2 ...
md:  adding hdk2 ...
md: hdk1 has different UUID to hdk2
md:  adding hdi2 ...
md: hdi1 has different UUID to hdk2
md: created md1
md: bind<hdi2>
md: bind<hdk2>
md: running: <hdk2><hdi2>
md1: max total readahead window set to 512k
md1: 2 data-disks, max readahead per data-disk: 256k
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdk2
raid0:   comparing hdk2(7590656) with hdk2(7590656)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdi2
raid0:   comparing hdi2(7590656) with hdk2(7590656)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 15181312 blocks.
raid0 : conf->smallest->size is 15181312 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md1 RAID superblock on device
md: hdk2 <6>(write) hdk2's sb offset: 7590656
md: hdi2 <6>(write) hdi2's sb offset: 7590656
md: considering hdk1 ...
md:  adding hdk1 ...
md:  adding hdi1 ...
md: created md0
md: bind<hdi1>
md: bind<hdk1>
md: running: <hdk1><hdi1>
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdk1
raid0:   comparing hdk1(70559872) with hdk1(70559872)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdi1
raid0:   comparing hdi1(70559872) with hdk1(70559872)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 141119744 blocks.
raid0 : conf->smallest->size is 141119744 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md0 RAID superblock on device
md: hdk1 <6>(write) hdk1's sb offset: 70559872
md: hdi1 <6>(write) hdi1's sb offset: 70559872
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 396k freed
Adding 1574328k swap on /dev/hda9.  Priority:-1 extents:1
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,11), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,11)) for (ide0(3,11))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,12), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,12)) for (ide0(3,12))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,0), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,0)) for (md(9,0))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,1)) for (md(9,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,1)) for (ide2(33,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,2)) for (ide2(33,2))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,65), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,65)) for (ide2(33,65))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,66), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,66)) for (ide2(33,66))
Using r5 hash to sort names
NTFS volume version 3.0.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
vmmon: no version magic, tainting kernel.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
vmnet: no version magic, tainting kernel.
vmnet: module license 'unspecified' taints kernel.
/dev/vmnet: open called by PID 594 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
/dev/vmnet: open called by PID 617 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1318 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1319 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1348 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1342 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_SMP=y
CONFIG_NR_SIBLINGS_0=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
# ISDN subsystem
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_RAW_DRIVER=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_FS_MBCACHE=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_FB=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FONT_SUN12x22=y
CONFIG_FONTS=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_MATROX_MAVEN=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_ACCEL=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_EMU10K1=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_PRINTER=y
CONFIG_USB_SCANNER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y


00:00.0 Host bridge: VIA Technologies, Inc. VT8653 Host Bridge
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d8ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	Capabilities: [80] Power Management version 2

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a000 [size=32]
	Capabilities: [dc] Power Management version 1

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 1

00:0b.0 SCSI storage controller: LSI Logic / Symbios Logic 53c860 (rev 13)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at a800 [size=256]
	Memory at da020000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1

00:0c.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Lite-On Communications Inc LNE100TX
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at ac00 [size=256]
	Memory at da021000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at b000 [size=8]
	I/O ports at b400 [size=4]
	I/O ports at b800 [size=8]
	I/O ports at bc00 [size=4]
	I/O ports at c000 [size=64]
	Memory at da000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1

00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Iwill Corp: Unknown device 0007
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at c400 [size=256]
	Capabilities: [c0] Power Management version 2

00:0f.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 04)
	Subsystem: Triones Technologies, Inc. HPT370A
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 10
	I/O ports at c800 [size=8]
	I/O ports at cc00 [size=4]
	I/O ports at d000 [size=8]
	I/O ports at d400 [size=4]
	I/O ports at d800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at dc00 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 62)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ec00 [size=256]
	Memory at da022000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SGRAM
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
	Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

-- 
Darkness is seen
Thru blindness in the mind
	The Organization - The Past
GNU/Linux 2.5.59 SMP/ReiserFS 2x2318 bogomips load av: 0.57 0.36 0.14
