Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSA0BVc>; Sat, 26 Jan 2002 20:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSA0BV0>; Sat, 26 Jan 2002 20:21:26 -0500
Received: from netbox.kleinmann.com ([66.89.62.82]:59299 "EHLO susan.bogus")
	by vger.kernel.org with ESMTP id <S287436AbSA0BVM>;
	Sat, 26 Jan 2002 20:21:12 -0500
Message-Id: <200201270121.g0R1LE5A009188@susan.bogus>
To: linux-kernel@vger.kernel.org
cc: sgk@kleinmann.com
Subject: misconfigured cardbus in 2.4.17 
Date: Sat, 26 Jan 2002 20:21:14 -0500
From: "Susan G. Kleinmann" <sgk@kleinmann.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] misconfigured cardbus in 2.4.17

[2.] On a Toshiba 1805-S203, with:
     -- a probably buggy, but recent version of the BIOS 
        (2.00, 9 Nov. 2001), and  
     -- the BIOS "Controller Mode" set to AUTO, and
     -- a total memory of 384M,
     PCMCIA cards are not recognized.

     However, when
     -- the BIOS "Controller Mode" value is set to PCIC, or 
     -- the total memory is only 128M (which is what the laptop came 
        with).
     a fairly old PCMCIA card _is_ recognized.

     (This limits the usefulness of the cardbus slots in this laptop.)

     The output of dmesg shows the memory allocation when 
        RAM=384M 
        "Controller Mode"=PCIC
        the PCMCIA card *is* recognized:

    Linux version 2.4.17 (root@toshibas) (gcc version 2.95.4 (Debian prerelease)) #1 Sun Jan 13 16:13:18 EST 2002
    BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
     BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
     BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
     BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
     BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 00000000177f0000 (usable)
     BIOS-e820: 00000000177f0000 - 0000000017800000 (ACPI data)
     BIOS-e820: 0000000017800000 - 0000000018000000 (reserved)
     BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
    On node 0 totalpages: 96240
    zone(0): 4096 pages.
    zone(1): 92144 pages.
    zone(2): 0 pages.
    Local APIC disabled by BIOS -- reenabling.
    Found and enabled local APIC!
    Kernel command line: root=/dev/hda5 ro mem=384960K
    Initializing CPU#0
    Detected 801.815 MHz processor.
    Console: colour VGA+ 80x25
    Calibrating delay loop... 1599.07 BogoMIPS
    Memory: 376616k/384960k available (1116k kernel code, 7956k reserved, 343k data, 228k init, 0k highmem)
    Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
    Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
    Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
    Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
    Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
    CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
    CPU: L1 I cache: 16K, L1 D cache: 16K
    CPU: L2 cache: 128K
    CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
    CPU:             Common caps: 0383fbff 00000000 00000000 00000000
    CPU: Intel Celeron (Coppermine) stepping 06
    Enabling fast FPU save and restore... done.
    Enabling unmasked SIMD FPU exception support... done.
    Checking 'hlt' instruction... OK.
    POSIX conformance testing by UNIFIX
    enabled ExtINT on CPU#0
    ESR value before enabling vector: 00000040
    ESR value after enabling vector: 00000000
    Using local APIC timer interrupts.
    calibrating APIC timer ...
    ..... CPU clock speed is 801.8242 MHz.
    ..... host bus clock speed is 100.2278 MHz.
    cpu: 0, clocks: 1002278, slice: 501139
    CPU0<T0:1002272,T1:501120,D:13,S:501139,C:1002278>
    mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
    mtrr: detected mtrr type: Intel
    PCI: PCI BIOS revision 2.10 entry at 0xfe34a, last bus=5
    PCI: Using configuration type 1
    PCI: Probing PCI hardware
    Unknown bridge resource 0: assuming transparent
    Unknown bridge resource 2: assuming transparent
    PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
    isapnp: Scanning for PnP cards...
    isapnp: No Plug & Play device found
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    apm: BIOS version 1.2 Flags 0x02 (Driver version 1.15)
    Starting kswapd
    devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
    devfs: boot_options: 0x0
    pty: 256 Unix98 ptys configured
    Toshiba System Managment Mode driver v1.11 26/9/2001
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
    ttyS00 at 0x03f8 (irq = 4) is a 16550A
    block: 128 slots per queue, batch=32
    RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    ALI15X3: IDE controller on PCI bus 00 dev 20
    PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
    ALI15X3: chipset revision 195
    ALI15X3: not 100% native mode: will probe irqs later
    ALI15X3: simplex device:  DMA disabled
    ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
    ALI15X3: simplex device:  DMA disabled
    ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
    hda: TOSHIBA MK1517GAP, ATA DISK drive
    hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: 29498112 sectors (15103 MB), CHS=1836/255/63
    hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
    Uniform CD-ROM driver Revision: 3.12
    Partition check:
     /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >
    Floppy drive(s): fd0 is 1.44M
    FDC 0 is a post-1991 82077
    Linux agpgart interface v0.99 (c) Jeff Hartmann
    agpgart: Maximum main memory to use for agp memory: 313M
    agpgart: unsupported bridge
    agpgart: no supported devices found.
    orinoco.c 0.08a (David Gibson <hermes@gibson.dropbear.id.au> and others)
    hermes.c: 3 Oct 2001 David Gibson <hermes@gibson.dropbear.id.au>
    usb.c: registered new driver hub
    uhci.c: USB Universal Host Controller Interface driver v1.1
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP
    IP: routing cache hash table of 4096 buckets, 32Kbytes
    TCP: Hash tables configured (established 32768 bind 32768)
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    VFS: Mounted root (ext2 filesystem) readonly.
    Freeing unused kernel memory: 228k freed
    Adding Swap: 128484k swap-space (priority -1)
    PCI: Found IRQ 11 for device 00:02.0
    usb-ohci.c: USB OHCI at membase 0xd801b000, IRQ 11
    usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
    usb.c: new USB bus registered, assigned bus number 1
    hub.c: USB hub found
    hub.c: 2 ports detected
    Real Time Clock Driver v1.10e
    Linux PCMCIA Card Services 3.1.31
      kernel build: 2.4.17 unknown
      options:  [pci] [cardbus] [apm]
    Intel ISA/PCI/CardBus PCIC probe:
      Intel i82365sl B step rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00
        host opts [0]: none
        host opts [1]: none
        PCI irq 9 seems to be wedged!
        ISA irqs (scanned) = 3,4,5,7,10 polling interval = 1000 ms
    cs: memory probe 0x0d0000-0x0dffff: clean.
    cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3e7 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
    cs: IO port probe 0x0380-0x03bf: clean.
    cs: IO port probe 0x03e8-0x0407: clean.
    cs: IO port probe 0x0410-0x047f: clean.
    cs: IO port probe 0x0490-0x04cf: clean.
    cs: IO port probe 0x04d8-0x04ff: clean.
    cs: IO port probe 0x0800-0x08ff: clean.
    cs: IO port probe 0x0a00-0x0aff: clean.
    cs: IO port probe 0x0c00-0x0cff: clean.
    eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:E0:98:76:0B:B8

    *******************************************************************
    In contrast,this is the output of dmesg when
    RAM=384M
    ControllerMode=Auto
    the PCMCIA card is not recognized:

    Linux version 2.4.17 (root@toshibas) (gcc version 2.95.4 (Debian prerelease)) #1 Sun Jan 13 16:13:18 EST 2002
    BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
     BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
     BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
     BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
     BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 00000000177f0000 (usable)
     BIOS-e820: 00000000177f0000 - 0000000017800000 (ACPI data)
     BIOS-e820: 0000000017800000 - 0000000018000000 (reserved)
     BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
    On node 0 totalpages: 96240
    zone(0): 4096 pages.
    zone(1): 92144 pages.
    zone(2): 0 pages.
    Local APIC disabled by BIOS -- reenabling.
    Found and enabled local APIC!
    Kernel command line: root=/dev/hda5 ro mem=384960K
    Initializing CPU#0
    Detected 801.816 MHz processor.
    Console: colour VGA+ 80x25
    Calibrating delay loop... 1599.07 BogoMIPS
    Memory: 376616k/384960k available (1116k kernel code, 7956k reserved, 343k data, 228k init, 0k highmem)
    Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
    Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
    Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
    Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
    Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
    CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
    CPU: L1 I cache: 16K, L1 D cache: 16K
    CPU: L2 cache: 128K
    CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
    CPU:             Common caps: 0383fbff 00000000 00000000 00000000
    CPU: Intel Celeron (Coppermine) stepping 06
    Enabling fast FPU save and restore... done.
    Enabling unmasked SIMD FPU exception support... done.
    Checking 'hlt' instruction... OK.
    POSIX conformance testing by UNIFIX
    enabled ExtINT on CPU#0
    ESR value before enabling vector: 00000040
    ESR value after enabling vector: 00000000
    Using local APIC timer interrupts.
    calibrating APIC timer ...
    ..... CPU clock speed is 801.8281 MHz.
    ..... host bus clock speed is 100.2284 MHz.
    cpu: 0, clocks: 1002284, slice: 501142
    CPU0<T0:1002272,T1:501120,D:10,S:501142,C:1002284>
    mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
    mtrr: detected mtrr type: Intel
    PCI: PCI BIOS revision 2.10 entry at 0xfe34a, last bus=5
    PCI: Using configuration type 1
    PCI: Probing PCI hardware
    Unknown bridge resource 0: assuming transparent
    Unknown bridge resource 2: assuming transparent
    PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
    PCI: Found IRQ 11 for device 00:11.0
    PCI: Found IRQ 11 for device 00:11.1
    isapnp: Scanning for PnP cards...
    isapnp: No Plug & Play device found
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    apm: BIOS version 1.2 Flags 0x02 (Driver version 1.15)
    Starting kswapd
    devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
    devfs: boot_options: 0x0
    pty: 256 Unix98 ptys configured
    Toshiba System Managment Mode driver v1.11 26/9/2001
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
    ttyS00 at 0x03f8 (irq = 4) is a 16550A
    block: 128 slots per queue, batch=32
    RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    ALI15X3: IDE controller on PCI bus 00 dev 20
    PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
    ALI15X3: chipset revision 195
    ALI15X3: not 100% native mode: will probe irqs later
    ALI15X3: simplex device:  DMA disabled
    ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
    ALI15X3: simplex device:  DMA disabled
    ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
    hda: TOSHIBA MK1517GAP, ATA DISK drive
    hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: 29498112 sectors (15103 MB), CHS=1836/255/63
    hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
    Uniform CD-ROM driver Revision: 3.12
    Partition check:
     /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >
    Floppy drive(s): fd0 is 1.44M
    FDC 0 is a post-1991 82077
    Linux agpgart interface v0.99 (c) Jeff Hartmann
    agpgart: Maximum main memory to use for agp memory: 313M
    agpgart: unsupported bridge
    agpgart: no supported devices found.
    orinoco.c 0.08a (David Gibson <hermes@gibson.dropbear.id.au> and others)
    hermes.c: 3 Oct 2001 David Gibson <hermes@gibson.dropbear.id.au>
    usb.c: registered new driver hub
    uhci.c: USB Universal Host Controller Interface driver v1.1
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP
    IP: routing cache hash table of 4096 buckets, 32Kbytes
    TCP: Hash tables configured (established 32768 bind 32768)
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    VFS: Mounted root (ext2 filesystem) readonly.
    Freeing unused kernel memory: 228k freed
    Adding Swap: 128484k swap-space (priority -1)
    PCI: Found IRQ 11 for device 00:02.0
    usb-ohci.c: USB OHCI at membase 0xd801b000, IRQ 11
    usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
    usb.c: new USB bus registered, assigned bus number 1
    hub.c: USB hub found
    hub.c: 2 ports detected
    Real Time Clock Driver v1.10e
    Linux PCMCIA Card Services 3.1.31
      kernel build: 2.4.17 unknown
      options:  [pci] [cardbus] [apm]
    ds: no socket drivers loaded!
    ds: no socket drivers loaded!
    ds: no socket drivers loaded!
    Intel ISA/PCI/CardBus PCIC probe:
    PCI: Found IRQ 11 for device 00:11.0
    PCI: Found IRQ 11 for device 00:11.1
      Toshiba ToPIC100 rev 32 PCI-to-CardBus at slot 00:11, mem 0x17800000
        host opts [0]: [slot 0xf0] [ccr 0x11] [cdr 0x86] [rcr 0xc000000] [pci irq 11] [lat 64/176] [bus 3/3]
        host opts [1]: [slot 0xf0] [ccr 0x21] [cdr 0x86] [rcr 0xc000000] [pci irq 11] [lat 64/176] [bus 4/4]
        PCI irq 11 test failed
        ISA irqs (default) = 3,4,5,7,9,10,12 polling interval = 1000 ms
    cs: socket 0 voltage interrogation timed out

[3.] Keywords (i.e., modules, networking, kernel):
     pci cardbus memory

[4.] Kernel version (from /proc/version):
     Linux version 2.4.17 (root@toshibas) (gcc version 2.95.4 (Debian prerelease)) #1 Sun Jan 13 16:13:18 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
     NA

[6.] A small shell script or example program which triggers the
     problem (if possible)
     NA

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux toshibas 2.4.17 #1 Sun Jan 13 16:13:18 EST 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.25
pcmcia-cs              3.1.31
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         pcnet_cs 8390 ds i82365 pcmcia_core rtc usb-ohci

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 6
cpu MHz		: 801.815
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1599.07


[7.3.] Module information (from /proc/modules):
pcnet_cs               12676   1
8390                    5936   0 [pcnet_cs]
ds                      6688   2 [pcnet_cs]
i82365                 22288   2
pcmcia_core            41408   0 [pcnet_cs ds i82365]
rtc                     5528   0 (autoclean)
usb-ohci               17696   0 (unused)


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
The values below were obtained when
     RAM=384M 
     "Controller Mode"=PCIC
     the PCMCIA card *is* recognized:

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0300-031f : pcnet_cs
0376-0376 : ide1
03c0-03df : vga+
03e0-03e1 : i82365
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
ed00-edff : Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio
ee00-ee3f : Acer Laboratories Inc. [ALi] M7101 PMU
ef00-ef1f : Acer Laboratories Inc. [ALi] M7101 PMU
eff0-efff : Acer Laboratories Inc. [ALi] M5229 IDE

/proc/iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d0fff : card services
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-177effff : System RAM
  00100000-00217367 : Kernel code
  00217368-0026cf97 : Kernel data
f8000000-fbffffff : PCI device 10b9:1632 (Acer Laboratories Inc. [ALi])
fdffe000-fdffefff : Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio
fdfff000-fdffffff : Acer Laboratories Inc. [ALi] M5237 USB
  fdfff000-fdffffff : usb-ohci
fe000000-ff7fffff : PCI Bus #01
  fe000000-fe7fffff : PCI device 1023:8620 (Trident Microsystems)
  fefe0000-feffffff : PCI device 1023:8620 (Trident Microsystems)
  ff000000-ff7fffff : PCI device 1023:8620 (Trident Microsystems)


[7.5.] PCI information ('lspci -vvv' as root)
The values below were obtained when
     RAM=384M 
     "Controller Mode"=PCIC
     the PCMCIA card *is* recognized:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1632 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fe000000-ff7fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if f0)
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at eff0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ed00 [size=256]
	Region 1: Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8620 (rev 5d) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ff000000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at fefe0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

*******************************************************************************
The following data had been gathered when:
     RAM=384M 
     "Controller Mode"=Auto
     the PCMCIA card *is NOT* recognized:

    00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1632 (rev 01)
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
    	Latency: 0
    	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
    	Capabilities: [b0] AGP version 1.0
    		Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
    		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
    	Capabilities: [a4] Power Management version 1
    		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01) (prog-if 00 [Normal decode])
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 0
    	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    	Memory behind bridge: fe000000-ff7fffff
    	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
    
    00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
    	Subsystem: Toshiba America Info Systems: Unknown device 0004
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 64 (20000ns max), cache line size 08
    	Interrupt: pin A routed to IRQ 11
    	Region 0: Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]
    	Capabilities: [60] Power Management version 2
    		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if f0)
    	Subsystem: Toshiba America Info Systems: Unknown device 0004
    	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 64 (500ns min, 1000ns max)
    	Interrupt: pin A routed to IRQ 0
    	Region 4: I/O ports at eff0 [size=16]
    	Capabilities: [60] Power Management version 2
    		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio (rev 01)
    	Subsystem: Toshiba America Info Systems: Unknown device 0001
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
    	Latency: 64 (500ns min, 6000ns max)
    	Interrupt: pin A routed to IRQ 11
    	Region 0: I/O ports at ed00 [size=256]
    	Region 1: Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
    	Capabilities: [dc] Power Management version 2
    		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
    	Subsystem: Toshiba America Info Systems: Unknown device 0004
    	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 0
    	Capabilities: [a0] Power Management version 1
    		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    00:08.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
    	Subsystem: Toshiba America Info Systems: Unknown device 0001
    	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    
    00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
    	Subsystem: Toshiba America Info Systems: Unknown device 0001
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 64
    	Interrupt: pin A routed to IRQ 11
    	Region 0: Memory at 17800000 (32-bit, non-prefetchable) [size=4K]
    	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    	I/O window 0: 00000000-00000003
    	I/O window 1: 00000000-00000003
    	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
    	16-bit legacy interface ports at 0001
    
    00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
    	Subsystem: Toshiba America Info Systems: Unknown device 0001
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 64
    	Interrupt: pin B routed to IRQ 11
    	Region 0: Memory at 17801000 (32-bit, non-prefetchable) [size=4K]
    	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    	I/O window 0: 00000000-00000003
    	I/O window 1: 00000000-00000003
    	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
    	16-bit legacy interface ports at 0001
    
    01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8620 (rev 5d) (prog-if 00 [VGA])
    	Subsystem: Toshiba America Info Systems: Unknown device 0001
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    	Latency: 8
    	Interrupt: pin A routed to IRQ 11
    	Region 0: Memory at ff000000 (32-bit, non-prefetchable) [size=8M]
    	Region 1: Memory at fefe0000 (32-bit, non-prefetchable) [size=128K]
    	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
    	Expansion ROM at <unassigned> [disabled] [size=64K]
    	Capabilities: [80] AGP version 1.0
    		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
    		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
    	Capabilities: [90] Power Management version 1
    		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
       NA

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
     Another probably related problem:  the system hangs on boot when:
     -- the kernel pcmcia modules are used rather than the pcmcia modules,
     -- the system is configured with 384M of ram, and 
     -- the BIOS is set to Controller Mode=PCIC

     Yet another probably related problem:  
     I have not been able to get other 32-bit PCMCIA cards to work on this 
     system, (a Linksys Etherfast and a Netgear FA411) with any configuration 
     of the memory, or with kernel pcmcia modules or standalone pcmcia modules.

[X.] Other notes, patches, fixes, workarounds:

None
