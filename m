Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUADOiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUADOiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:38:46 -0500
Received: from web8203.mail.in.yahoo.com ([203.199.70.117]:46780 "HELO
	web8203.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S265694AbUADOiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:38:00 -0500
Message-ID: <20040104143755.6022.qmail@web8203.mail.in.yahoo.com>
Date: Sun, 4 Jan 2004 14:37:55 +0000 (GMT)
From: =?iso-8859-1?q?Mr=20Amit=20Mehrotra?= <mehrotraamit@yahoo.co.in>
Subject: PROBLEM: PCMCIA in 2.6.0 and 2.4.23 not detecting card inserts.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. PCMCIA in 2.6.0 and 2.4.23 not detecting card
inserts

2. I am using pcmcia-cs-3.2.7. dmesg output (attached
below) suggests that Yenta Sockets is active but when
I insert any card, I hear no beeps, the output of
/var/log/sys.log does
not change and
cardctl status
says
Socket 0:
  no card

3. keywords: PCMCIA module

4. output of /proc/version Linux version 2.6.0
(root@localhost) (gcc version 3.3.2) #6 Sat Jan 3
16:52:54 CST 2004

7.1 output of scripts/ver_linux
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre3
e2fsprogs              1.34
pcmcia-cs              3.2.7
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         snd_intel8x0 snd_ac97_codec
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device sis900 crc32 nvidia ds
yenta_socket pcmcia_core

7.2 output of /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2390.695
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi
mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4718.59

7.3 output of /proc/modules
snd_intel8x0 28164 0 - Live 0xf8a22000
snd_ac97_codec 50948 1 snd_intel8x0, Live 0xf8a61000
snd_pcm 84004 1 snd_intel8x0, Live 0xf8a4b000
snd_timer 20996 1 snd_pcm, Live 0xf8a2a000
snd_page_alloc 9092 2 snd_intel8x0,snd_pcm, Live
0xf8a1e000
snd_mpu401_uart 6144 1 snd_intel8x0, Live 0xf8a09000
snd_rawmidi 20000 1 snd_mpu401_uart, Live 0xf8a13000
snd_seq_device 6536 1 snd_rawmidi, Live 0xf8a01000
sis900 16644 0 - Live 0xf8a0d000
crc32 4096 1 sis900, Live 0xf8a04000
nvidia 2069736 14 - Live 0xf8b2f000
ds 10884 2 - Live 0xf88cb000
yenta_socket 14336 0 - Live 0xf88cf000
pcmcia_core 60768 2 ds,yenta_socket, Live 0xf88db000

7.4.1 output of /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0c00-0c1f : 0000:00:02.1
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
cc00-ccff : 0000:00:04.0
  cc00-ccff : sis900
d000-d07f : 0000:00:02.6
d400-d4ff : 0000:00:02.6
d800-d87f : 0000:00:02.7
  d800-d83f : SiS SI7012 - Controller
dc00-dcff : 0000:00:02.7
  dc00-dcff : SiS SI7012 - AC'97
ff00-ff0f : 0000:00:02.5

7.4.2 output of /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0028d7d6 : Kernel code
  0028d7d7-00340dff : Kernel data
3fff0000-3fff0fff : 0000:00:08.0
  3fff0000-3fff0fff : yenta_socket
40000000-403fffff : PCI CardBus #02
40400000-407fffff : PCI CardBus #02
c5b00000-d5cfffff : PCI Bus #01
  c8000000-cfffffff : 0000:01:00.0
  d5c80000-d5cfffff : 0000:01:00.0
d5e00000-d7efffff : PCI Bus #01
  d6000000-d6ffffff : 0000:01:00.0
dbffa000-dbffafff : 0000:00:04.0
  dbffa000-dbffafff : sis900
dbffb000-dbffbfff : 0000:00:03.0
dbffc000-dbffcfff : 0000:00:03.1
dbffd000-dbffdfff : 0000:00:03.2
dbffe000-dbffefff : 0000:00:03.3
dbfff000-dbffffff : 0000:00:02.3
dc000000-dfffffff : 0000:00:00.0

7.5 output of lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS]
SiS645DX Host & Memory & AGP Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at dc000000 (32-bit,
non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+
ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+
GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Silicon Integrated Systems [SiS]
5591/5592 AGP (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d5e00000-d7efffff
        Prefetchable memory behind bridge:
c5b00000-d5cfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort-
>Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]
SiS962 [MuTIOL Media IO] (rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]:
Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0c00 [size=32]

00:02.3 FireWire (IEEE 1394): Silicon Integrated
Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
        Subsystem: Uniwill Computer Corp: Unknown
device 7007
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 3000ns max)
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at dbfff000 (32-bit,
non-prefetchable) [size=4K]
        Expansion ROM at dbfc0000 [disabled]
[size=128K]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:02.5 IDE interface: Silicon Integrated Systems
[SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Uniwill Computer Corp: Unknown
device 5513
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at ff00 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel
537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
        Subsystem: Uniwill Computer Corp: Unknown
device 4003
        Control: I/O+ Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 18
        Region 0: I/O ports at d400 [size=256]
        Region 1: I/O ports at d000 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:02.7 Multimedia audio controller: Silicon
Integrated Systems [SiS] SiS7012 PCI Audio Accelerator
(rev a0)
        Subsystem: Uniwill Computer Corp: Unknown
device 5101
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 18
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at d800 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:03.0 USB Controller: Silicon Integrated Systems
[SiS] 7001 (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Uniwill Computer Corp: Unknown
device 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at dbffb000 (32-bit,
non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems
[SiS] 7001 (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Uniwill Computer Corp: Unknown
device 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at dbffc000 (32-bit,
non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems
[SiS] 7001 (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Uniwill Computer Corp: Unknown
device 7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at dbffd000 (32-bit,
non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems
[SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
        Subsystem: Uniwill Computer Corp: Unknown
device 7002
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at dbffe000 (32-bit,
non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:04.0 Ethernet controller: Silicon Integrated
Systems [SiS] SiS900 10/100 Ethernet (rev 91)
        Subsystem: Uniwill Computer Corp: Unknown
device 5100
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at dbffa000 (32-bit,
non-prefetchable) [size=4K]
        Expansion ROM at dbfa0000 [disabled]
[size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus
Controller
        Subsystem: Uniwill Computer Corp: Unknown
device 3000
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at 3fff0000 (32-bit,
non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05,
sec-latency=176
        Memory window 0: 40000000-403ff000
(prefetchable)
        Memory window 1: 40400000-407ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort-
>Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: nVidia Corporation
NV17 [GeForce4 440 Go 64M] (rev a3) (prog-if 00 [VGA])
        Subsystem: Uniwill Computer Corp: Unknown
device 2241
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d6000000 (32-bit,
non-prefetchable) [size=16M]
        Region 1: Memory at c8000000 (32-bit,
prefetchable) [size=128M]
        Region 2: Memory at d5c80000 (32-bit,
prefetchable) [size=512K]
        Expansion ROM at d7ee0000 [disabled]
[size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA-
ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+
GART64- 64bit- FW- Rate=x4

7.7 output of dmesg
Linux version 2.6.0 (root@localhost) (gcc version
3.3.2) #6 Sat Jan 3 16:52:54 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000
(usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI
data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI
NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff0ffff
(reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000
(reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003fff0000 (usable)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fba70
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                  
    ) @ 0x000fa160
ACPI: RSDT (v001 AMIINT SiS645XX 0x00000010 MSFT
0x0100000b) @ 0x3fff0000
ACPI: FADT (v002 AMIINT SiS645XX 0x00000011 MSFT
0x0100000b) @ 0x3fff0030
ACPI: MADT (v001 AMIINT SiS645XX 0x00001000 MSFT
0x0100000b) @ 0x3fff00c0
ACPI: DSDT (v001    SiS      645 0x00001000 MSFT
0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000]
global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000,
IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2]
polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9]
polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 ro mem=1048512K
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2390.695 MHz processor.
Console: colour VGA+ 80x25
Memory: 1034492k/1048512k available (1589k kernel
code, 13080k reserved, 717k data, 136k init, 131008k
highmem)
Calibrating delay loop... 4718.59 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7,
524288 bytes)
Inode-cache hash table entries: 65536 (order: 6,
262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
CPU:     After generic identify, caps: bfebfbff
00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff
00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000
00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19,
2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
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
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2389.0911 MHz.
..... host bus clock speed is 132.0772 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last
bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9
Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Embedded Controller [EC0] (gpe 11)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11
12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11
12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *10 11
12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ
16 Mode:1 Active:1)
00:00:01[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ
17 Mode:1 Active:1)
00:00:01[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ
18 Mode:1 Active:1)
00:00:01[C] -> 2-18 -> IRQ 18 
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ
19 Mode:1 Active:1)
00:00:01[D] -> 2-19 -> IRQ 19 
Pin 2-16 already programmed   
Pin 2-17 already programmed   
Pin 2-18 already programmed   
Pin 2-19 already programmed   
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ
20 Mode:1 Active:1)
00:00:03[A] -> 2-20 -> IRQ 20 
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ
21 Mode:1 Active:1)
00:00:03[B] -> 2-21 -> IRQ 21 
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ
22 Mode:1 Active:1)
00:00:03[C] -> 2-22 -> IRQ 22 
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ
23 Mode:1 Active:1)
00:00:03[D] -> 2-23 -> IRQ 23 
Pin 2-19 already programmed   
Pin 2-17 already programmed   
Pin 2-18 already programmed   
Pin 2-17 already programmed   
PCI: Using ACPI for IRQ routing    
PCI: if you experience problems, try using option
'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
highmem bounce pool size: 64 pages 
ACPI: AC Adapter [AC0] (on-line)   
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (75 C)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe --
parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports,
IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 8250
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
hda: TOSHIBA MK4018GAS, ATA DISK drive
hdc: Slimtype COMBO LSC-24081, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63
 hda: hda1 hda3 hda4 < hda5 >
hdc: ATAPI 8X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev
1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
input: PS/2 Synaptics TouchPad on isa0060/serio2
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7
(Thu Sep 25 19:16:36 2003 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind
65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 1534196k swap on /dev/hda3.  Priority:-1
extents:1
EXT3 FS on hda5, internal journal
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
Yenta: CardBus bridge found at 0000:00:08.0
[1584:3000]
Yenta: ISA IRQ list 0000, PCI irq17
Socket status: 4d41b401
cs: IO port probe 0x0c00-0x0cff: excluding 0xc00-0xc1f
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x837
0x840-0x87f 0x898-0x89f
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df
0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
    ACPI-0178: *** Warning: The ACPI AML in your
computer contains errors, please nag the manufacturer
to correct it.
    ACPI-0181: *** Warning: Allowing relaxed access to
fields; turn on CONFIG_ACPI_DEBUG for details.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel
Module  1.0-5328  Wed Dec 17 13:54:51 PST 2003
0: NVRM: AGPGART: unable to retrieve symbol table
sis900.c: v1.08.06 9/24/2002
eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address
1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 31 as default
eth0: SiS 900 PCI Fast Ethernet at 0xcc00, IRQ 19, xx:xx:xx:xx:xx:xx

________________________________________________________________________
Yahoo! India Mobile: Download the latest polyphonic ringtones.
Go to http://in.mobile.yahoo.com
