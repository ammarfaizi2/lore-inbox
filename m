Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSDWX3T>; Tue, 23 Apr 2002 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSDWX3S>; Tue, 23 Apr 2002 19:29:18 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:50088 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S314486AbSDWX3N>; Tue, 23 Apr 2002 19:29:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Michael D. Johnson" <mike@C242326-a.attbi.com>
Reply-To: mikej163@attbi.com
To: "Problems" <linux-kernel@vger.kernel.org>
Subject: PROBLEM:  make xconfig fails on link
Date: Tue, 23 Apr 2002 16:29:00 -0700
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020423232908.33CF556A5A@C242326-a.attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1] make xconfig fails to link active during fresh install/rebuild on 2.5.9  
this worked on 2.5.7 but not here.
[2] see above
[3] Key Word:  xconfig
[4] Version: 2.4.8-34.1mdk #1 Mon Nov 19 12:40:39 MST 2001 i686 unknown
[Duron 700 Mhz]
[5] Error reported :  make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-new/linux-2.5.9/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/isdn/Config.in: 10: incorrect argument
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-new/linux-2.5.9/scripts'
make: *** [xconfig] Error 2
[6] N/A
[7] Gnome desktop Mandrake 8.2 updates, kernel as above.
[7.1] Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         sr_mod r128 agpgart ipchains via82cxxx_audio uart401
ac97_codec sound soundcore lp parport_pc parport af_packet keybdev mousedev
hid usbmouse input usb-uhci usbcore 8139too eepro100 nls_cp437 nls_iso8859-1
nls_cp850 vfat fat ide-scsi scsi_mod rtc
[7.2] [root@C242326-a linux-2.5.9]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 700.040
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36
mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91
[7.3]  cat /proc/modules
sr_mod                 14904   0 (autoclean)
r128                   86392   0
agpgart                26752   1 (autoclean)
ipchains               36168   0
via82cxxx_audio        17120   0
uart401                 6336   0 [via82cxxx_audio]
ac97_codec              9280   0 [via82cxxx_audio]
sound                  58348   0 [via82cxxx_audio uart401]
soundcore               4164   5 [via82cxxx_audio sound]
lp                      5760   0
parport_pc             19940   1
parport                24768   1 [lp parport_pc]
af_packet              12552   1 (autoclean)
keybdev                 1920   0 (unused)
mousedev                4192   1
hid                    18464   0 (unused)
usbmouse                2048   0 (unused)
input                   3648   0 [keybdev mousedev hid usbmouse]
usb-uhci               21252   0 (unused)
usbcore                50688   1 [hid usbmouse usb-uhci]
8139too                12672   1 (autoclean)
eepro100               17104   1 (autoclean)
nls_cp437               4384   2 (autoclean)
nls_iso8859-1           2880   3 (autoclean)
nls_cp850               3616   1 (autoclean)
vfat                    9980   3 (autoclean)
fat                    32152   0 (autoclean) [vfat]
ide-scsi                8096   0
scsi_mod               91080   2 [sr_mod ide-scsi]
rtc                     5592   0 (autoclean)
[7.4]  cat /proc/ioports
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
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage 128 RF
a000-a00f : VIA Technologies, Inc. Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
a400-a41f : VIA Technologies, Inc. UHCI USB
  a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. UHCI USB (#2)
  a800-a81f : usb-uhci
ac00-acff : VIA Technologies, Inc. AC97 Audio Controller
  ac00-acff : via82cxxx_audio
b000-b003 : VIA Technologies, Inc. AC97 Audio Controller
  b000-b003 : via82cxxx_audio
b400-b403 : VIA Technologies, Inc. AC97 Audio Controller
  b400-b403 : via82cxxx_audio
b800-b81f : Intel Corporation 82557 [Ethernet Pro 100]
  b800-b81f : eepro100
bc00-bc07 : Lucent Microelectronics 56k WinModem
c000-c0ff : Lucent Microelectronics 56k WinModem
c400-c4ff : Realtek Semiconductor Co., Ltd. RTL-8139
  c400-c4ff : 8139too
[root@C242326-a linux-2.5.9]# cat /proc/ioports
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
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage 128 RF
a000-a00f : VIA Technologies, Inc. Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
a400-a41f : VIA Technologies, Inc. UHCI USB
  a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. UHCI USB (#2)
  a800-a81f : usb-uhci
ac00-acff : VIA Technologies, Inc. AC97 Audio Controller
  ac00-acff : via82cxxx_audio
b000-b003 : VIA Technologies, Inc. AC97 Audio Controller
  b000-b003 : via82cxxx_audio
b400-b403 : VIA Technologies, Inc. AC97 Audio Controller
  b400-b403 : via82cxxx_audio
b800-b81f : Intel Corporation 82557 [Ethernet Pro 100]
  b800-b81f : eepro100
bc00-bc07 : Lucent Microelectronics 56k WinModem
c000-c0ff : Lucent Microelectronics 56k WinModem
c400-c4ff : Realtek Semiconductor Co., Ltd. RTL-8139
  c400-c4ff : 8139too
[root@C242326-a linux-2.5.9]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-0021178f : Kernel code
  00211790-0027510b : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d7ffffff : PCI Bus #01
  d4000000-d7ffffff : ATI Technologies Inc Rage 128 RF
    d4000000-d5ffffff : vesafb
d8000000-d9ffffff : PCI Bus #01
  d9000000-d9003fff : ATI Technologies Inc Rage 128 RF
db000000-db0fffff : Intel Corporation 82557 [Ethernet Pro 100]
db100000-db100fff : Intel Corporation 82557 [Ethernet Pro 100]
  db100000-db100fff : eepro100
db101000-db1010ff : Lucent Microelectronics 56k WinModem
db102000-db1020ff : Realtek Semiconductor Co., Ltd. RTL-8139
  db102000-db1020ff : 8139too
ffff0000-ffffffff : reserved
[7.5]  lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: d4000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
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
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at a400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
        Subsystem: VIA Technologies, Inc.: Unknown device 4511
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 12
        Region 0: I/O ports at ac00 [size=256]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at b400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 02)
        Subsystem: Intel Corp. EtherExpress PRO/100B (TX)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at db100000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at b800 [size=32]
        Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:12.0 Communication controller: Lucent Microelectronics 56k WinModem (rev
01)
        Subsystem: Lucent Microelectronics LT WinModem 56k Data+Fax+Voice+Dsvd
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0 (63000ns min, 3500ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at db101000 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at bc00 [size=8]
        Region 2: I/O ports at c000 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at db102000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if
00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[root@C242326-a linux-2.5.9]#
[7.6]  cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: CD-RW  CW-7586   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
[root@C242326-a linux-2.5.9]#
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8xe5Aod000q4aikwRAnzSAJ9/kQcF6wwkjIF54yvp6iNoBHyAYACcCzpU
3TZJedyc1CfvXdr25iYgmRM=
=IkeD
-----END PGP SIGNATURE-----
