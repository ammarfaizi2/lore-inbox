Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbSLRM5X>; Wed, 18 Dec 2002 07:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbSLRM5X>; Wed, 18 Dec 2002 07:57:23 -0500
Received: from [216.179.95.39] ([216.179.95.39]:45837 "EHLO mail.srealm.net.au")
	by vger.kernel.org with ESMTP id <S267233AbSLRM5Q>;
	Wed, 18 Dec 2002 07:57:16 -0500
From: "Preston A. Elder" <prez@goth.net>
Organization: Gothic Networks
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Keyboard not found, but it exists!
Date: Wed, 18 Dec 2002 08:05:06 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212180805.08049.prez@goth.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] One line summary of the problem:
Keyboard not found, but it exists!

[2.] Full description of the problem/report:
The PS/2 keyboard fails during the kernel boot (before init), saying:
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)

The keyboard does indeed exist, and I am able to use it in BIOS, in the boot 
manager, and booting to DOS.  The above errors, however disable the keyboard 
after the kenel boot, and so I am unable to use it in the running system.

Thats not the full extent of the problem though. I also have problems running 
"hwclock" without the --directisa option, it will just block (and I can't 
abort it with no keyboard).  I've added the --directisa option to 
startup/shutdown for now.

I've also experienced some problems with the system time just jumping ahead by 
35 minutes, and then back again.  The back again part could be because I'm 
running NTP to keep the system in sync, but I'm getting weird behavior with 
time on this system, which is causing havoc on applications.

[3.] Keywords (i.e., modules, networking, kernel):
2.4.19 keyboard ps2

[4.] Kernel version (from /proc/version):
Linux version 2.4.19-crypto-r7 (root@sanctuary) (gcc version 3.1.1) #3 SMP Thu 
Aug 29 14:34:19 EDT 2002


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
Linux sanctuary 2.4.19-crypto-r7 #3 SMP Thu Aug 29 14:34:19 EDT 2002 i686 
Pentium III (Coppermine) GenuineIntel GNU/Linux

Gnu C                  gcc (GCC) 3.1.1 Copyright (C) 2002 Free Software 
Foundation, Inc. This is free software; see the source for copying 
conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR 
A PARTICULAR PURPOSE.
Gnu make               3.80
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.29
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      4.0.0
Procps                 2.0.10
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         sd_mod usb-storage scsi_mod uhci via686a eeprom 
i2c-proc i2c-isa i2c-viapro i2c-core 8139too mii usbcore

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 798.539
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1564.67

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 798.539
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1593.34

[7.3.] Module information (from /proc/modules):
sd_mod                 11584   0
usb-storage            23868   0
scsi_mod               89248   2 [sd_mod usb-storage]
uhci                   27432   0 (unused)
via686a                 8388   0
eeprom                  3584   0
i2c-proc                7264   0 [via686a eeprom]
i2c-isa                 1220   0 (unused)
i2c-viapro              4040   0 (unused)
i2c-core               14336   0 [via686a eeprom i2c-proc i2c-isa i2c-viapro]
8139too                16160   1
mii                     1296   0 [8139too]
usbcore                64704   1 [usb-storage uhci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  0400-0407 : viapro-smbus
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  0c00-0c7f : via686a-sensors
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  ac00-acff : 3Dfx Interactive, Inc. Voodoo Banshee
d000-d01f : VIA Technologies, Inc. UHCI USB
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB (#2)
  d400-d41f : usb-uhci
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d800-d8ff : 8139too
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002ef0af : Kernel code
  002ef0b0-0036f7bf : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
40000000-400000ff : Platform Technologies, Inc. AGOGO sound chip (aka ESS 
Maestro 1)
d7c00000-dbcfffff : PCI Bus #01
  d8000000-d9ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
dbe00000-dfefffff : PCI Bus #01
  dc000000-ddffffff : 3Dfx Interactive, Inc. Voodoo Banshee
dfffff00-dfffffff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  dfffff00-dfffffff : 8139too
e0000000-e3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: dbe00000-dfefffff
        Prefetchable memory behind bridge: d7c00000-dbcfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Platform Technologies, Inc. AGOGO sound 
chip (aka ESS Maestro 1) (rev 10)
        Subsystem: Platform Technologies, Inc.: Unknown device ffff
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 40000000 [disabled] [size=256]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 
03) (prog-if 00 [VGA])
        Subsystem: Creative Labs 3D Blaster Banshee VE
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at ac00 [size=256]
        Expansion ROM at dfef0000 [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: 02.U
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/proc/driver/rtc:
rtc_time        : 00:00:00
rtc_date        : 2000-00-00
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : no
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay

[X.] Other notes, patches, fixes, workarounds:
N/A

- -- 
PreZ
Systems Administrator
GOTH.NET

Goth Code '98:   tSKeba5qaSabsaaaGbaa75KAASWGuajmsvbieqcL4BaaLb3F4
                 nId5mefqmDjmmgm#haxthgzpj4GiysNkycSRGHabiabOkauNSW

GOTH.NET - http://www.goth.net
Free online resource for the gothic community.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+AHKCuULtzKdGMboRAqM3AJ0YDEE1zeYGCU8ZoznaXdH8BEvPrgCgob9E
2SbUFYdyJ4cXvfWxqIdigDc=
=b+2r
-----END PGP SIGNATURE-----

