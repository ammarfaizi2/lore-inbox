Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTAUSyQ>; Tue, 21 Jan 2003 13:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbTAUSyQ>; Tue, 21 Jan 2003 13:54:16 -0500
Received: from rhea.tiscali.nl ([195.241.76.178]:18100 "EHLO rhea.tiscali.nl")
	by vger.kernel.org with ESMTP id <S267189AbTAUSxu>;
	Tue, 21 Jan 2003 13:53:50 -0500
Message-ID: <3E2D81F2.8CDCE0C8@freeler.nl>
Date: Tue, 21 Jan 2003 17:22:58 +0000
From: Max Euer <m.euer@freeler.nl>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.18 kernel Segmentation Fault reading from CDU31a [CD Rom 
 Drive]
Content-Type: multipart/mixed;
 boundary="------------28FCB2E8AB673287CABC68EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------28FCB2E8AB673287CABC68EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[2.]
since I used Kernel 2.4.18 [in order to get an usb scanner going] ,
reading from my Sony CDU31a CD drive gets a Segmentation fault 
[see attachment syslog, near the end of it]
Mounting and dir reading is possible however.
System usually hangs after that.
Remedy:using kernel 2.2.17 or 2.2.20.

[3.]
Module [CDU31a,CDrom]

[4.]
Linux version 2.4.18 (root@PENT) (gcc version 2.95.4 20011002 (Debian
prerelease)) #9      SMP Sat Jan 18 19:20:38 UTC 2003

[5.]
Oops Msg: see syslog Attachment

[6.]
mount /crom  [works normal]
ls /cdrom        [works normal]
cp /cdrom/something-big /tmp [Segmentation fault occurs]

[7.1]
max@PENT:/usr/src/kernel-source-2.4.18/scripts$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux PENT 2.4.18 #9 SMP Sat Jan 18 19:20:38 UTC 2003 i586 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         scanner usb-ohci usbcore isofs serial cdu31a cdrom msdos
vfat fat lp sb sb_lib uart401 sound soundcore ne 8390 parport_pc parport

[7.2]
max@PENT:/usr/src/kernel-source-2.4.18/scripts$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
cpu MHz         : 100.017
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic
bogomips        : 199.47

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
cpu MHz         : 100.017
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic
bogomips        : 199.88

[7.3]
max@PENT:/usr/src/kernel-source-2.4.18/scripts$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0220-022f : soundblaster
0230-0233 : cdu31a
02f8-02ff : serial(auto)
0300-031f : eth0
0330-0333 : MPU-401 UART
0378-037a : parport0
03c0-03df : vga+
03f0-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
0cf8-0cfb : PCI conf2
max@PENT:/usr/src/kernel-source-2.4.18/scripts$ cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-047fffff : System RAM
00100000-001e4dc3 : Kernel code
001e4dc4-0021c3bf : Kernel data
f0000000-f3ffffff : S3 Inc. Trio 64V2/DX or /GX
f4000000-f4000fff : OPTi Inc. 82C861
f4000000-f4000fff : usb-ohci
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5]
max@PENT:/usr/src/kernel-source-2.4.18/scripts$ lspci -vvv
00:00.0 Class 0600: 8086:04a3 (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 32 set

00:02.0 Class 0000: 8086:0482 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set

00:04.0 Class 0300: 5333:8901 (rev 04)
        Subsystem: 5333:8901
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:05.0 Class 0c03: 1045:c861 (rev 10) (prog-if 10)
        Subsystem: 1045:c861
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]

[7.6] no scsi
[7.7]
max@PENT:/usr/src/kernel-source-2.4.18/scripts$ cat /proc/interrupts
           CPU0       CPU1
  0:     355521     341790    IO-APIC-edge  timer
  1:       3736       4088    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      18008      16511    IO-APIC-edge  serial
  5:          3          0    IO-APIC-edge  soundblaster
  6:         61         34    IO-APIC-edge  floppy
  7:          0          0    IO-APIC-edge  parport0
  8:          2          1    IO-APIC-edge  rtc
 10:          0          0    IO-APIC-edge  NE2000
 11:          0          0    IO-APIC-edge  usb-ohci
 14:     286183     287128    IO-APIC-edge  ide0
NMI:          0          0
LOC:     697282     697296
ERR:          0
MIS:          0

[X]
work-around: booting Kernel 2.2.17 or 2.2.20 [latest pre 2.4.18 Kernel]
Remark: modul options are: cdu31a_port=0x230 
  [no interrupts.They didnt work with old kernel neither.]
CDU31 is connected onto a Soundblaster.Used to have CDU31 connected to WDH7102
With that, interrupts could be set and it worked.Tried that with the new 2.4.18
Kernel:
same Segmentation  Fault.


Thank you and God bless.

--
Max Euer - Oud Lemiers 18 - NL6295AT Lemiers -  T (NL 043)306 4692
--------------28FCB2E8AB673287CABC68EB
Content-Type: text/plain; charset=us-ascii;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Jan 19 20:32:37 PENT syslogd 1.4.1#10: restart.
Jan 19 20:32:37 PENT kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Jan 19 20:32:37 PENT kernel: Inspecting /boot/System.map-2.4.18
Jan 19 20:32:38 PENT rpc.statd[179]: Version 1.0 Starting
Jan 19 20:32:39 PENT lpd[190]: restarted
Jan 19 20:32:40 PENT kernel: Loaded 14193 symbols from /boot/System.map-2.4.18.
Jan 19 20:32:40 PENT kernel: Symbols match kernel version 2.4.18.
Jan 19 20:32:40 PENT kernel: Loaded 338 symbols from 20 modules.
Jan 19 20:32:40 PENT kernel: Linux version 2.4.18 (root@PENT) (gcc version 2.95.4 20011002 (Debian prerelease)) #9 SMP Sat Jan 18 19:20:38 UTC 2003
Jan 19 20:32:40 PENT kernel: BIOS-provided physical RAM map:
Jan 19 20:32:40 PENT kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Jan 19 20:32:40 PENT kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan 19 20:32:40 PENT kernel:  BIOS-e820: 0000000000100000 - 0000000004800000 (usable)
Jan 19 20:32:40 PENT kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jan 19 20:32:40 PENT kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jan 19 20:32:40 PENT kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan 19 20:32:40 PENT kernel: found SMP MP-table at 000fba00
Jan 19 20:32:40 PENT kernel: hm, page 000fb000 reserved twice.
Jan 19 20:32:40 PENT kernel: hm, page 000fc000 reserved twice.
Jan 19 20:32:40 PENT kernel: hm, page 000fb000 reserved twice.
Jan 19 20:32:40 PENT kernel: hm, page 000fc000 reserved twice.
Jan 19 20:32:40 PENT kernel: On node 0 totalpages: 18432
Jan 19 20:32:40 PENT kernel: zone(0): 4096 pages.
Jan 19 20:32:40 PENT kernel: zone(1): 14336 pages.
Jan 19 20:32:40 PENT kernel: zone(2): 0 pages.
Jan 19 20:32:40 PENT kernel: Intel MultiProcessor Specification v1.1
Jan 19 20:32:40 PENT kernel:     Virtual Wire compatibility mode.
Jan 19 20:32:40 PENT kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Jan 19 20:32:40 PENT kernel: Processor #0 Pentium(tm) APIC version 17
Jan 19 20:32:40 PENT kernel: Processor #1 Pentium(tm) APIC version 17
Jan 19 20:32:40 PENT kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jan 19 20:32:40 PENT kernel: Processors: 2
Jan 19 20:32:40 PENT kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=303
Jan 19 20:32:40 PENT kernel: Initializing CPU#0
Jan 19 20:32:40 PENT kernel: Detected 100.016 MHz processor.
Jan 19 20:32:40 PENT kernel: Console: colour VGA+ 132x25
Jan 19 20:32:40 PENT kernel: Calibrating delay loop... 199.47 BogoMIPS
Jan 19 20:32:40 PENT kernel: Memory: 70444k/73728k available (915k kernel code, 2900k reserved, 221k data, 208k init, 0k highmem)
Jan 19 20:32:40 PENT kernel: Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Jan 19 20:32:40 PENT kernel: Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Jan 19 20:32:40 PENT kernel: Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Jan 19 20:32:40 PENT kernel: Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Jan 19 20:32:40 PENT kernel: Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jan 19 20:32:40 PENT kernel: CPU: Before vendor init, caps: 000003bf 00000000 00000000, vendor = 0
Jan 19 20:32:40 PENT kernel: Intel Pentium with F0 0F bug - workaround enabled.
Jan 19 20:32:40 PENT kernel: CPU: After vendor init, caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU:     After generic, caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU:             Common caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: Checking 'hlt' instruction... OK.
Jan 19 20:32:40 PENT kernel: POSIX conformance testing by UNIFIX
Jan 19 20:32:40 PENT kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jan 19 20:32:40 PENT kernel: mtrr: detected mtrr type: none
Jan 19 20:32:40 PENT kernel: CPU: Before vendor init, caps: 000003bf 00000000 00000000, vendor = 0
Jan 19 20:32:40 PENT kernel: CPU: After vendor init, caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU:     After generic, caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU:             Common caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU0: Intel Pentium 75 - 200 stepping 05
Jan 19 20:32:40 PENT kernel: per-CPU timeslice cutoff: 158.92 usecs.
Jan 19 20:32:40 PENT kernel: enabled ExtINT on CPU#0
Jan 19 20:32:40 PENT kernel: ESR value before enabling vector: 00000000
Jan 19 20:32:40 PENT kernel: ESR value after enabling vector: 00000000
Jan 19 20:32:40 PENT kernel: Booting processor 1/1 eip 2000
Jan 19 20:32:40 PENT kernel: Initializing CPU#1
Jan 19 20:32:40 PENT kernel: masked ExtINT on CPU#1
Jan 19 20:32:40 PENT kernel: ESR value before enabling vector: 00000000
Jan 19 20:32:40 PENT kernel: ESR value after enabling vector: 00000000
Jan 19 20:32:40 PENT kernel: Calibrating delay loop... 199.88 BogoMIPS
Jan 19 20:32:40 PENT kernel: CPU: Before vendor init, caps: 000003bf 00000000 00000000, vendor = 0
Jan 19 20:32:40 PENT kernel: CPU: After vendor init, caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU:     After generic, caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU:             Common caps: 000003bf 00000000 00000000 00000000
Jan 19 20:32:40 PENT kernel: CPU1: Intel Pentium 75 - 200 stepping 05
Jan 19 20:32:40 PENT kernel: Total of 2 processors activated (399.36 BogoMIPS).
Jan 19 20:32:40 PENT kernel: ENABLING IO-APIC IRQs
Jan 19 20:32:40 PENT kernel: Setting 2 in the phys_id_present_map
Jan 19 20:32:40 PENT kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Jan 19 20:32:40 PENT kernel: init IO_APIC IRQs
Jan 19 20:32:40 PENT kernel:  IO-APIC (apicid-pin) 2-0 not connected.
Jan 19 20:32:40 PENT kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jan 19 20:32:40 PENT kernel: number of MP IRQ sources: 15.
Jan 19 20:32:40 PENT kernel: number of IO-APIC #2 registers: 16.
Jan 19 20:32:40 PENT kernel: testing the IO APIC.......................
Jan 19 20:32:40 PENT kernel: 
Jan 19 20:32:40 PENT kernel: IO APIC #2......
Jan 19 20:32:40 PENT kernel: .... register #00: 02000000
Jan 19 20:32:40 PENT kernel: .......    : physical APIC id: 02
Jan 19 20:32:40 PENT kernel: .... register #01: 000F0011
Jan 19 20:32:40 PENT kernel: .......     : max redirection entries: 000F
Jan 19 20:32:40 PENT kernel: .......     : PRQ implemented: 0
Jan 19 20:32:40 PENT kernel: .......     : IO APIC version: 0011
Jan 19 20:32:40 PENT kernel: .... register #02: 00000000
Jan 19 20:32:40 PENT kernel: .......     : arbitration: 00
Jan 19 20:32:40 PENT kernel: .... IRQ redirection table:
Jan 19 20:32:40 PENT kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jan 19 20:32:40 PENT kernel:  00 000 00  1    0    0   0   0    0    0    00
Jan 19 20:32:40 PENT kernel:  01 003 03  0    0    0   0   0    1    1    39
Jan 19 20:32:40 PENT kernel:  02 003 03  0    0    0   0   0    1    1    31
Jan 19 20:32:40 PENT kernel:  03 003 03  0    0    0   0   0    1    1    41
Jan 19 20:32:40 PENT kernel:  04 003 03  0    0    0   0   0    1    1    49
Jan 19 20:32:40 PENT kernel:  05 003 03  0    0    0   0   0    1    1    51
Jan 19 20:32:40 PENT kernel:  06 003 03  0    0    0   0   0    1    1    59
Jan 19 20:32:40 PENT kernel:  07 003 03  0    0    0   0   0    1    1    61
Jan 19 20:32:40 PENT kernel:  08 003 03  0    0    0   0   0    1    1    69
Jan 19 20:32:40 PENT kernel:  09 003 03  0    0    0   0   0    1    1    71
Jan 19 20:32:40 PENT kernel:  0a 003 03  0    0    0   0   0    1    1    79
Jan 19 20:32:40 PENT kernel:  0b 003 03  0    0    0   0   0    1    1    81
Jan 19 20:32:40 PENT kernel:  0c 003 03  0    0    0   0   0    1    1    89
Jan 19 20:32:40 PENT kernel:  0d 003 03  0    0    0   0   0    1    1    91
Jan 19 20:32:40 PENT kernel:  0e 003 03  0    0    0   0   0    1    1    99
Jan 19 20:32:40 PENT kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Jan 19 20:32:40 PENT kernel: IRQ to pin mappings:
Jan 19 20:32:40 PENT kernel: IRQ0 -> 0:2
Jan 19 20:32:40 PENT kernel: IRQ1 -> 0:1
Jan 19 20:32:40 PENT kernel: IRQ3 -> 0:3
Jan 19 20:32:40 PENT kernel: IRQ4 -> 0:4
Jan 19 20:32:40 PENT kernel: IRQ5 -> 0:5
Jan 19 20:32:40 PENT kernel: IRQ6 -> 0:6
Jan 19 20:32:40 PENT kernel: IRQ7 -> 0:7
Jan 19 20:32:40 PENT kernel: IRQ8 -> 0:8
Jan 19 20:32:40 PENT kernel: IRQ9 -> 0:9
Jan 19 20:32:40 PENT kernel: IRQ10 -> 0:10
Jan 19 20:32:40 PENT kernel: IRQ11 -> 0:11
Jan 19 20:32:40 PENT kernel: IRQ12 -> 0:12
Jan 19 20:32:40 PENT kernel: IRQ13 -> 0:13
Jan 19 20:32:40 PENT kernel: IRQ14 -> 0:14
Jan 19 20:32:40 PENT kernel: IRQ15 -> 0:15
Jan 19 20:32:40 PENT kernel: .................................... done.
Jan 19 20:32:40 PENT kernel: Using local APIC timer interrupts.
Jan 19 20:32:40 PENT kernel: calibrating APIC timer ...
Jan 19 20:32:40 PENT kernel: ..... CPU clock speed is 100.0189 MHz.
Jan 19 20:32:40 PENT kernel: ..... host bus clock speed is 66.6787 MHz.
Jan 19 20:32:40 PENT kernel: cpu: 0, clocks: 666787, slice: 222262
Jan 19 20:32:40 PENT kernel: CPU0<T0:666784,T1:444512,D:10,S:222262,C:666787>
Jan 19 20:32:40 PENT kernel: cpu: 1, clocks: 666787, slice: 222262
Jan 19 20:32:40 PENT kernel: CPU1<T0:666784,T1:222256,D:4,S:222262,C:666787>
Jan 19 20:32:40 PENT kernel: checking TSC synchronization across CPUs: passed.
Jan 19 20:32:40 PENT kernel: Waiting on wait_init_idle (map = 0x2)
Jan 19 20:32:40 PENT kernel: All processors have done init_idle
Jan 19 20:32:40 PENT kernel: PCI: PCI BIOS revision 2.00 entry at 0xfa880, last bus=0
Jan 19 20:32:40 PENT kernel: PCI: Using configuration type 2
Jan 19 20:32:40 PENT kernel: PCI: Probing PCI hardware
Jan 19 20:32:40 PENT kernel: PCI BIOS passed nonexistent PCI bus 0!
Jan 19 20:32:40 PENT kernel: PCI BIOS passed nonexistent PCI bus 0!
Jan 19 20:32:40 PENT kernel: Linux NET4.0 for Linux 2.4
Jan 19 20:32:40 PENT kernel: Based upon Swansea University Computer Society NET3.039
Jan 19 20:32:40 PENT kernel: Initializing RT netlink socket
Jan 19 20:32:40 PENT kernel: Starting kswapd
Jan 19 20:32:40 PENT kernel: pty: 256 Unix98 ptys configured
Jan 19 20:32:40 PENT kernel: Real Time Clock Driver v1.10e
Jan 19 20:32:40 PENT kernel: block: 128 slots per queue, batch=32
Jan 19 20:32:40 PENT kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Jan 19 20:32:40 PENT kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 19 20:32:40 PENT kernel: hda: ST33232A, ATA DISK drive
Jan 19 20:32:40 PENT kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 19 20:32:40 PENT kernel: hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=781/128/63
Jan 19 20:32:40 PENT kernel: Partition check:
Jan 19 20:32:40 PENT kernel:  hda: hda1 hda2 < hda5 > hda3 hda4
Jan 19 20:32:40 PENT kernel: Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
Jan 19 20:32:40 PENT kernel: FDC 0 is an 8272A
Jan 19 20:32:40 PENT kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jan 19 20:32:40 PENT kernel: IP Protocols: ICMP, UDP, TCP
Jan 19 20:32:40 PENT kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Jan 19 20:32:40 PENT kernel: TCP: Hash tables configured (established 8192 bind 8192)
Jan 19 20:32:40 PENT kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jan 19 20:32:40 PENT kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jan 19 20:32:40 PENT kernel: Freeing unused kernel memory: 208k freed
Jan 19 20:32:40 PENT kernel: Adding Swap: 177400k swap-space (priority -1)
Jan 19 20:32:40 PENT kernel: parport0: PC-style at 0x378, irq 7 [PCSPP]
Jan 19 20:32:40 PENT kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Jan 19 20:32:40 PENT kernel: Last modified Nov 1, 2000 by Paul Gortmaker
Jan 19 20:32:40 PENT kernel: NE*000 ethercard probe at 0x300: 00 00 e8 0c c2 a7
Jan 19 20:32:40 PENT kernel: eth0: NE2000 found at 0x300, using IRQ 10.
Jan 19 20:32:40 PENT kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
Jan 19 20:32:40 PENT kernel: SB 4.13 detected OK (220)
Jan 19 20:32:40 PENT kernel: lp0: using parport0 (interrupt-driven).
Jan 19 20:32:40 PENT kernel: usb.c: registered new driver usbdevfs
Jan 19 20:32:40 PENT kernel: usb.c: registered new driver hub
Jan 19 20:32:40 PENT kernel: usb-ohci.c: USB OHCI at membase 0xc5087000, IRQ 11
Jan 19 20:32:40 PENT kernel: usb-ohci.c: usb-00:05.0, OPTi Inc. 82C861
Jan 19 20:32:40 PENT kernel: usb.c: new USB bus registered, assigned bus number 1
Jan 19 20:32:40 PENT kernel: usb.c: kmalloc IF c11249c0, numif 1
Jan 19 20:32:40 PENT kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Jan 19 20:32:40 PENT kernel: usb.c: USB device number 1 default language ID 0x0
Jan 19 20:32:40 PENT kernel: Product: USB OHCI Root Hub
Jan 19 20:32:40 PENT kernel: SerialNumber: c5087000
Jan 19 20:32:40 PENT kernel: hub.c: USB hub found
Jan 19 20:32:40 PENT kernel: hub.c: 2 ports detected
Jan 19 20:32:40 PENT kernel: hub.c: standalone hub
Jan 19 20:32:40 PENT kernel: hub.c: ganged power switching
Jan 19 20:32:40 PENT kernel: hub.c: global over-current protection
Jan 19 20:32:40 PENT kernel: hub.c: Port indicators are not supported
Jan 19 20:32:40 PENT kernel: hub.c: power on to power good time: 2ms
Jan 19 20:32:40 PENT kernel: hub.c: hub controller current requirement: 0mA
Jan 19 20:32:40 PENT kernel: hub.c: port removable status: RR
Jan 19 20:32:40 PENT kernel: hub.c: local power source is good
Jan 19 20:32:40 PENT kernel: hub.c: no over-current condition exists
Jan 19 20:32:40 PENT kernel: hub.c: enabling power on all ports
Jan 19 20:32:40 PENT kernel: usb.c: hub driver claimed interface c11249c0
Jan 19 20:32:40 PENT kernel: Uniform CD-ROM driver unloaded
Jan 19 20:32:40 PENT kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jan 19 20:32:40 PENT kernel: ttyS00 at 0x03f8 (irq = 4) is a 16450
Jan 19 20:32:40 PENT kernel: ttyS01 at 0x02f8 (irq = 3) is a 16450
Jan 19 20:32:40 PENT kernel: usb.c: registered new driver usbscanner
Jan 19 20:32:40 PENT kernel: scanner.c: 0.4.6:USB Scanner Driver
Jan 19 20:32:40 PENT kernel: svc: unknown version (3)
Jan 19 20:34:07 PENT kernel: Uniform CD-ROM driver Revision: 3.12
Jan 19 20:40:34 PENT kernel: usb.c: USB disconnect on device 1
Jan 19 20:40:34 PENT kernel: usb.c: USB bus 1 deregistered
Jan 19 20:42:24 PENT kernel: cdu31a: Trying session 1
Jan 19 20:42:25 PENT kernel: cdu31a: Trying session 2
Jan 19 20:42:26 PENT kernel: VFS: Disk change detected on device cdu31a(15,0)
Jan 19 20:42:26 PENT kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Jan 19 20:42:27 PENT kernel: ISOFS: changing to secondary root
Jan 19 20:42:59 PENT kernel: Unable to handle kernel paging request at virtual address c50c4920
Jan 19 20:42:59 PENT kernel:  printing eip:
Jan 19 20:42:59 PENT kernel: c50a10a5
Jan 19 20:42:59 PENT kernel: *pde = 01159067
Jan 19 20:42:59 PENT kernel: *pte = 00000000
Jan 19 20:42:59 PENT kernel: Oops: 0002
Jan 19 20:42:59 PENT kernel: CPU:    1
Jan 19 20:42:59 PENT kernel: EIP:    0010:[serial:__insmod_serial_S.bss_L3328+58437/95389083]    Not tainted
Jan 19 20:42:59 PENT kernel: EFLAGS: 00013286
Jan 19 20:42:59 PENT kernel: eax: 00000004   ebx: 0001f800   ecx: fffe1000   edx: 00000232
Jan 19 20:42:59 PENT kernel: esi: 00000000   edi: c50c4920   ebp: c3600000   esp: c4725e60
Jan 19 20:42:59 PENT kernel: ds: 0018   es: 0018   ss: 0018
Jan 19 20:42:59 PENT kernel: Process le (pid: 2681, stackpage=c4725000)
Jan 19 20:42:59 PENT kernel: Stack: c4725edc 00000000 c3600000 0001f800 00000000 c50a130d c3600000 0001f800 
Jan 19 20:42:59 PENT kernel:        000000fc 00000000 00000000 c4725edc 0000cde8 c4725ed8 000000fc c4724000 
Jan 19 20:42:59 PENT kernel:        00000000 00015944 c50a18ea c3600000 0000cde8 000000fc c4725edc c4725ed8 
Jan 19 20:42:59 PENT kernel: Call Trace: [serial:__insmod_serial_S.bss_L3328+59053/95388467] [serial:__insmod_serial_S.bss_L3328+60554/95386966] [sys_getresgid+64/144] [generic_unplug_device+45/60] [__run_task_queue+100/112] 
Jan 19 20:42:59 PENT kernel:    [block_sync_page+22/28] [___wait_on_page+105/148] [do_generic_file_read+797/1148] [generic_file_read+126/300] [file_read_actor+0/96] [sys_read+146/260] 
Jan 19 20:42:59 PENT kernel:    [system_call+51/64] 
Jan 19 20:42:59 PENT kernel: 
Jan 19 20:42:59 PENT kernel: Code: f3 6c 8b 44 24 20 29 05 c4 4a 0a c5 01 05 70 4c 0a c5 83 3d 
Jan 19 20:45:00 PENT kernel:  <1>Unable to handle kernel paging request at virtual address c84287a8
Jan 19 20:45:00 PENT kernel:  printing eip:
Jan 19 20:45:00 PENT kernel: c012abb6
Jan 19 20:45:00 PENT kernel: *pde = 00000000
Jan 19 20:45:00 PENT kernel: Oops: 0002
Jan 19 20:45:00 PENT kernel: CPU:    0
Jan 19 20:45:00 PENT kernel: EIP:    0010:[free_block+102/220]    Not tainted
Jan 19 20:45:00 PENT kernel: EFLAGS: 00013086
Jan 19 20:45:00 PENT kernel: eax: 013899e4   ebx: 00000000   ecx: c3602000   edx: 00000060
Jan 19 20:45:00 PENT kernel: esi: c1126934   edi: 00000055   ebp: c11472a4   esp: c3aa5e78
Jan 19 20:45:00 PENT kernel: ds: 0018   es: 0018   ss: 0018
Jan 19 20:45:00 PENT kernel: Process XF86_S3 (pid: 226, stackpage=c3aa5000)
Jan 19 20:45:00 PENT kernel: Stack: c1147000 c3ffbac0 00003286 c3ffbac0 c011cfe8 c3602ee0 c112693c c1126944 
Jan 19 20:45:00 PENT kernel:        00000000 c012aefb c1126934 c1147200 0000007e c3ffbac0 c029e4e0 c3ffbb1c 
Jan 19 20:45:00 PENT kernel:        c3ffbac0 c019c67f c1126934 c3ffbac0 c3ffbac0 000000f0 c019c767 c3ffbac0 
Jan 19 20:45:00 PENT kernel: Call Trace: [update_process_times+32/148] [kmem_cache_free+83/128] [kfree_skbmem+95/104] [__kfree_skb+223/232] [unix_stream_recvmsg+786/928] 
Jan 19 20:45:00 PENT kernel:    [sock_recvmsg+61/188] [sock_read+132/144] [sys_read+146/260] [system_call+51/64] 
Jan 19 20:45:00 PENT kernel: 
Jan 19 20:45:00 PENT kernel: Code: 89 5c 81 18 89 41 14 8b 41 10 8d 50 ff 89 51 10 83 f8 01 75 






--------------28FCB2E8AB673287CABC68EB
Content-Type: text/plain; charset=us-ascii;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
# CONFIG_KMOD is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
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
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AHA152X=m
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
# CONFIG_VORTEX is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
# CONFIG_EEXPRESS_PRO is not set
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
CONFIG_NE2000=m
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
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
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=y
# CONFIG_AZTCD is not set
# CONFIG_GSCD is not set
# CONFIG_SBPCD is not set
# CONFIG_MCD is not set
# CONFIG_MCDX is not set
# CONFIG_OPTCD is not set
# CONFIG_CM206 is not set
# CONFIG_SJCD is not set
# CONFIG_ISP16_CDI is not set
CONFIG_CDU31A=m
# CONFIG_CDU535 is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=m
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

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
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_LONG_TIMEOUT=y

#
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set





--------------28FCB2E8AB673287CABC68EB--



