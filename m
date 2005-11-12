Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVKLUnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVKLUnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVKLUnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:43:41 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:4910 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964792AbVKLUnk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:43:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IWpbPV9prfUNhxj1+vAkjBIFyQM3VMDZ322vPU/smFcf7a5tzmbI8hbRf7ckIkygUYilqJSTd2yAoO165IpMcEc4PurFOwnTLfCAsJRrTfmkvozMRY4inNupT+9kZ93APbzgLoZGIcpos20QskGGsnG1BnkSJt86TKTDI2uPNHU=
Message-ID: <b1952ae90511121243q6c7e4c87x4f7bd99f7d3a86ee@mail.gmail.com>
Date: Sat, 12 Nov 2005 21:43:38 +0100
From: =?ISO-8859-1?Q?Pelle_Lundstr=F6m?= <lunper@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: No initialization of sound card
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Kernel 2.6.14.2 fails to locate and initiate sound card.

2. When loading kernel 2.6.14.2, the kernel fails to locate and
initialize the sound card. This worked fine in kernel 2.6.12.5. The
sound card has not been configured in kernels >2.6.13.

3. kernel, sound card, alsa, oss

4. Linux version 2.6.14.2.

5. Kernel 2.6.12.5.

6. No Oops are received.

7. -

8.1. sh scripts/ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux scofield 2.6.14.2 #1 PREEMPT Sat Nov 12 06:12:48 CET 2005 i686
unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.18
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.6
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   050
Modules Loaded         ohci_hcd ehci_hcd pcspkr snd_page_alloc
soundcore analog ns558 gameport 8250_pnp 8250 serial_core parport_pc
parport intel_agp pci_hotplug via_rhine mii generic uhci_hcd usbcore
i2c_piix4 i2c_core tsdev ide_scsi scsi_mod agpgart apm

8.2. cat /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 300.728
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips        : 602.41

(Yes, it's kind of old...)

8.3.  cat /proc/modules:
ohci_hcd 19716 0 - Live 0xc8cb8000
ehci_hcd 30088 0 - Live 0xc8caf000
pcspkr 3424 0 - Live 0xc887d000
snd_page_alloc 9096 0 - Live 0xc8c7c000
soundcore 7776 0 - Live 0xc8c6e000
analog 10528 0 - Live 0xc8c6a000
ns558 4740 0 - Live 0xc8c67000
gameport 12168 3 analog,ns558, Live 0xc8c46000
8250_pnp 8448 0 - Live 0xc8869000
8250 20388 1 8250_pnp, Live 0xc8c9f000
serial_core 18688 1 8250, Live 0xc8c99000
parport_pc 25412 0 - Live 0xc8c91000
parport 33224 1 parport_pc, Live 0xc8c72000
intel_agp 20380 1 - Live 0xc8c40000
pci_hotplug 26676 0 - Live 0xc8c38000
via_rhine 20228 0 - Live 0xc8c32000
mii 4608 1 via_rhine, Live 0xc8873000
generic 4356 0 [permanent], Live 0xc8870000
uhci_hcd 31376 0 - Live 0xc8c29000
usbcore 111232 4 ohci_hcd,ehci_hcd,uhci_hcd, Live 0xc8c4a000
i2c_piix4 7952 0 - Live 0xc886d000
i2c_core 17936 1 i2c_piix4, Live 0xc885b000
tsdev 6080 0 - Live 0xc8866000
ide_scsi 14596 0 - Live 0xc8861000
scsi_mod 87528 1 ide_scsi, Live 0xc8c12000
agpgart 29768 1 intel_agp, Live 0xc884c000
apm 18664 2 - Live 0xc8855000

8.4: cat /proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0201-0201 : ns558-pnp
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-1fff : PCI Bus #01
  1000-10ff : 0000:01:00.0
2000-201f : 0000:00:14.2
  2000-201f : uhci_hcd
2020-202f : 0000:00:14.1
  2020-2027 : ide0
  2028-202f : ide1
2080-20ff : 0000:00:04.0
  2080-20ff : via-rhine
ee00-ee3f : 0000:00:14.3
ee80-ee9f : 0000:00:14.3

cat /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-003abd21 : Kernel code
  003abd22-0046d6f7 : Kernel data
10000000-100fffff : PCI Bus #01
  10000000-1001ffff : 0000:01:00.0
10100000-1010ffff : 0000:00:04.0
40000000-410fffff : PCI Bus #01
  40000000-40ffffff : 0000:01:00.0
    40000000-403fffff : vesafb
  41000000-41000fff : 0000:01:00.0
41100000-4110007f : 0000:00:04.0
  41100000-4110007f : via-rhine
50000000-53ffffff : 0000:00:00.0
fffe0000-ffffffff : reserved

8.5: lspci -vvx:
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at 50000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
00: 86 80 80 71 06 00 90 22 03 00 00 06 00 40 00 00
10: 08 00 00 50 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 40000000-410fffff
        Prefetchable memory behind bridge: 10000000-100fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 81 71 07 01 a0 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 10 10 a0 22
20: 00 40 00 41 00 10 00 10 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:04.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (29500ns min, 38000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 2080 [size=128]
        Region 1: Memory at 41100000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 10100000 [disabled] [size=64K]
00: 06 11 43 30 07 00 00 02 06 00 00 02 08 40 00 00
10: 81 20 00 00 00 00 10 41 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 76 98

00:14.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 2020 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 2000 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:14.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro
AGP-133 (rev dc) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation Rage 3D LT Pro
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at 41000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 10000000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 42 4c 87 00 90 02 dc 00 00 03 08 42 00 00
10: 00 00 00 40 01 10 00 00 00 00 00 41 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e e8 b0
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

Kernel 2.6.12.5: lspci .vvx:
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at 50000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
00: 86 80 80 71 06 00 90 22 03 00 00 06 00 40 00 00
10: 08 00 00 50 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 40000000-410fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 81 71 07 01 a0 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 10 10 a0 22
20: 00 40 00 41 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:04.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (29500ns min, 38000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 2080 [size=128]
        Region 1: Memory at 41100000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
00: 06 11 43 30 07 00 00 02 06 00 00 02 08 40 00 00
10: 81 20 00 00 00 00 10 41 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 14
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 76 98

00:14.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 2020 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 2000 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:14.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro
AGP-133 (rev dc) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation Rage 3D LT Pro
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at 41000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 42 4c 87 00 90 02 dc 00 00 03 08 42 00 00
10: 00 00 00 40 01 10 00 00 00 00 00 41 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e e8 b0
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

8.6. No scsi devices attached.

8.7. Relevant dmesg output:
Nov 12 08:38:02 scofield modprobe: WARNING: Error inserting snd
(/lib/modules/2.6.14.2/kernel/sound/core/snd.ko): Unknown symbol in
module, or unknown param
eter (see dmesg)
Nov 12 08:38:02 scofield modprobe: WARNING: Error inserting
snd_seq_device (/lib/modules/2.6.14.2/kernel/sound/core/seq/snd-seq-device.ko):
Unknown symbol i
n module, or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_rawmidi (/lib/modules/2.6.14.2/kernel/sound/core/snd-rawmidi.ko):
Unknown symbol in module,
or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_mpu401_uart
(/lib/modules/2.6.14.2/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko):
Unknown
symbol in module, or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd_hwdep
(/lib/modules/2.6.14.2/kernel/sound/core/snd-hwdep.ko): Unknown symbol
in module, or u
nknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd_timer
(/lib/modules/2.6.14.2/kernel/sound/core/snd-timer.ko): Unknown symbol
in module, or u
nknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_opl3_lib (/lib/modules/2.6.14.2/kernel/sound/drivers/opl3/snd-opl3-lib.ko):
Unknown symbol i
n module, or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd_pcm
(/lib/modules/2.6.14.2/kernel/sound/core/snd-pcm.ko): Unknown symbol
in module, or unkno
wn parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: FATAL: Error inserting snd_es18xx
(/lib/modules/2.6.14.2/kernel/sound/isa/snd-es18xx.ko): Unknown symbol
in module, or un
known parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd
(/lib/modules/2.6.14.2/kernel/sound/core/snd.ko): Unknown symbol in
module, or unknown param
eter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_seq_device (/lib/modules/2.6.14.2/kernel/sound/core/seq/snd-seq-device.ko):
Unknown symbol i
n module, or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_rawmidi (/lib/modules/2.6.14.2/kernel/sound/core/snd-rawmidi.ko):
Unknown symbol in module,
or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_mpu401_uart
(/lib/modules/2.6.14.2/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko):
Unknown
symbol in module, or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd_hwdep
(/lib/modules/2.6.14.2/kernel/sound/core/snd-hwdep.ko): Unknown symbol
in module, or u
nknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd_timer
(/lib/modules/2.6.14.2/kernel/sound/core/snd-timer.ko): Unknown symbol
in module, or u
nknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting
snd_opl3_lib (/lib/modules/2.6.14.2/kernel/sound/drivers/opl3/snd-opl3-lib.ko):
Unknown symbol i
n module, or unknown parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: WARNING: Error inserting snd_pcm
(/lib/modules/2.6.14.2/kernel/sound/core/snd-pcm.ko): Unknown symbol
in module, or unkno
wn parameter (see dmesg)
Nov 12 08:38:03 scofield modprobe: FATAL: Error inserting snd_es18xx
(/lib/modules/2.6.14.2/kernel/sound/isa/snd-es18xx.ko): Unknown symbol
in module, or un
known parameter (see dmesg)

I hope this information is sufficient for you wizards to find a
solution to the problem.

Thank you
   //Pelle Lundström
