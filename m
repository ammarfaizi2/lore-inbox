Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSEBV6u>; Thu, 2 May 2002 17:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315462AbSEBV6t>; Thu, 2 May 2002 17:58:49 -0400
Received: from sandiego.divxnetworks.com ([207.67.92.110]:23475 "HELO
	trinity.divxnetworks.com") by vger.kernel.org with SMTP
	id <S315461AbSEBV6o>; Thu, 2 May 2002 17:58:44 -0400
Date: Thu, 2 May 2002 14:57:48 -0700
From: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
X-Mailer: The Bat! (v1.53d) Personal
Reply-To: Eugene Kuznetsov <ekuznetsov@divxnetworks.com>
Organization: PM
X-Priority: 3 (Normal)
Message-ID: <46328234.20020502145748@divxnetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re[4]: Support of AMD 762?
In-Reply-To: <E173O6Z-0004tr-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Thursday, May 02, 2002, 2:27:11 PM, you wrote:

>> AC> When someone volunteers to test it
>> I do!

AC> --- arch/i386/kernel/pci-irq.c~ Thu May  2 21:00:46 2002
AC> +++ arch/i386/kernel/pci-irq.c  Thu May  2 21:00:46 2002
AC> @@ -489,6 +489,8 @@
AC>           pirq_serverworks_get, pirq_serverworks_set },
AC>         { "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
AC>                 pirq_amd756_get, pirq_amd756_set },
AC> +       { "AMD768", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443,
AC> +               pirq_amd756_get, pirq_amd756_set },
 
AC>         { "default", 0, 0, NULL, NULL }
AC>  };

Doesn't work :(

Linux version 2.4.18 (root@sparky) (gcc version 2.95.3 20010315 (release)) #8 SMP Thu May 2 14:46:52 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f4e70
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 16
Processor #1 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=amd ro root=1602 video=radeon:1024x768-32@100
Initializing CPU#0
Detected 1344.331 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2680.42 BogoMIPS
Memory: 513372k/524208k available (1182k kernel code, 10448k reserved, 369k data, 256k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(TM) XP 1500+ stepping 02
per-CPU timeslice cutoff: 731.14 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2686.97 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(TM) XP 1500+ stepping 02
Total of 2 processors activated (5367.39 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-13, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  1    1    0   1   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  1    1    0   1   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  0    0    0   0   0    1    1    99
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
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1344.3191 MHz.
..... host bus clock speed is 268.8636 MHz.
cpu: 0, clocks: 2688636, slice: 896212
CPU0<T0:2688624,T1:1792400,D:12,S:896212,C:2688636>
cpu: 1, clocks: 2688636, slice: 896212
CPU1<T0:2688624,T1:896192,D:8,S:896212,C:2688636>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
radeonfb: ref_clk=2700, ref_div=12, xclk=23000 from BIOS
fb_find_mode(1024x768-32@100)
Trying specified video mode
Trying mode noname 1024x768-32@100
Console: switching to colour frame buffer device 128x48
radeonfb: ATI Radeon 8500 QL  DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=1022, DID=7441
PCI_IDE: chipset revision 4
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-00CAA0, ATA DISK drive
hdc: WDC WD200BB-75AUA1, ATA DISK drive
hdd: SAMSUNG CDRW/DVD SM-308B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(33)
hdc: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(33)
hdd: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1
 hdc: [PTBL] [2434/255/63] hdc1 hdc2 hdc3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xf0000000
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 256k freed
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.14, Nov 27, 2001  Jeff Garzik, Tjeerd Mulder)
eth0: NatSemi DP8381[56] at 0xe4864000, 00:02:e3:17:ad:a2, IRQ 9.
Creative EMU10K1 PCI Audio Driver, version 0.18, 09:18:48 Apr 16 2002
emu10k1_probe
PCI: Enabling device 00:09.0 (0004 -> 0005)
PCI: No IRQ known for interrupt pin A of device 00:09.0. Probably buggy MP table.
emu10k1: IRQ in use
usb.c: registered new driver hub
mice: PS/2 mouse device common for all mice
usb-uhci.c: $Revision: 1.275 $ time 09:07:58 Apr 17 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
eth0: link up.

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ef800000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e800 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: df000000-dfdfffff
        Prefetchable memory behind bridge: dff00000-ef7fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 04)
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at b400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b000 [disabled] [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: dc800000-deffffff
        Prefetchable memory behind bridge: dfe00000-dfefffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 514c (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 013a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at dffe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: National Semiconductor Corporation: Unknown device 0020
        Subsystem: Netgear: Unknown device f311
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2750ns min, 13000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:06.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 807d:0035
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at dd800000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 807d:0035
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 0
        Region 0: Memory at dd000000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02) (prog-if 20)
        Subsystem: Unknown device 807d:1043
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8500ns max), cache line size 08
        Interrupt: pin C routed to IRQ 0
        Region 0: Memory at dc800000 (32-bit, non-prefetchable) [disabled] [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--
Best regards,
 Eugene                            mailto:ekuznetsov@divxnetworks.com

