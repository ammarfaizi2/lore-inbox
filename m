Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270939AbTHKE37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270969AbTHKE37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:29:59 -0400
Received: from web40308.mail.yahoo.com ([66.218.78.87]:61258 "HELO
	web40308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270939AbTHKE3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:29:49 -0400
Message-ID: <20030811042948.11736.qmail@web40308.mail.yahoo.com>
X-RocketYMMF: rkymtguy
Date: Sun, 10 Aug 2003 21:29:48 -0700 (PDT)
From: Zachary Pfeffer <pfefferz@colorado.edu>
Reply-To: pfefferz@colorado.edu
Subject: PROBLEM:  'make' fails CC [M]  drivers/char/riscom8.o ON linux-2.6.0-test3 tree
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] 
'make' fails CC [M]  drivers/char/riscom8.o ON linux-2.6.0-test3 tree

[2.]
When performing a 'make' and including CONFIG_RISCOM8=m

I get 
  CC [M]  drivers/char/riscom8.o
In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:84: field `tqueue' has incomplete type
drivers/char/riscom8.h:85: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.h:99: confused by earlier errors, bailing out
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

[3.]
RISCOM char linux-2.6.0-test3 fails

[4.]
Linux version 2.4.21 (root@test) (gcc version 3.2 20020903 (Red Hat Linux 8.0
3.2-7)) #2 Sun Aug 10 15:48:49 MDT 2003

[5.]

[6.]
CONFIG_RISCOM8=m
make

[7.]

[7.1.]
sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux test 2.4.21 #2 Sun Aug 10 15:48:49 MDT 2003 i686 athlon i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ide-cd cdrom cmpci soundcore autofs eepro100
iptable_filt
er ip_tables ohci1394 ieee1394 ext3 jbd mousedev keybdev input hid usb-uhci
ehci
-hcd usb-ohci usbcore


[7.2.]
bash: /proc/cpuinfo: Permission denied
[root@test Documentation]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP2400+
stepping        : 1
cpu MHz         : 2014.579
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4010.80

[7.3.]
cat /proc/modules
ide-cd                 35424   1 (autoclean)
cdrom                  32576   0 (autoclean) [ide-cd]
cmpci                  35432   0 (autoclean)
soundcore               5988   4 (autoclean) [cmpci]
autofs                 13300   0 (autoclean) (unused)
eepro100               22260   1
mii                     3732   0 [eepro100]
iptable_filter          2412   0 (autoclean) (unused)
ip_tables              15008   1 [iptable_filter]
ohci1394               28776   0 (unused)
ieee1394               60836   0 [ohci1394]
mousedev                5460   1
keybdev                 2912   0 (unused)
input                   5280   0 [mousedev keybdev]
hid                    12344   0 (unused)
usb-uhci               26156   0 (unused)
ehci-hcd               19976   0 (unused)
usb-ohci               21192   0 (unused)
usbcore                75040   1 [hid usb-uhci ehci-hcd usb-ohci]

[7.4.]
cat /proc/ioports
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
0330-0331 : cmpci Midi
0376-0376 : ide1
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-901f : VIA Technologies, Inc. USB (#3)
  9000-901f : usb-uhci
9400-941f : VIA Technologies, Inc. USB (#2)
  9400-941f : usb-uhci
9800-981f : VIA Technologies, Inc. USB
  9800-981f : usb-uhci
a000-a00f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus
Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
a400-a407 : US Robotics/3Com 56K FaxModem Model 5610
  a400-a407 : serial(auto)
a800-a83f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  a800-a83f : eepro100
b000-b03f : Promise Technology, Inc. 20265
  b000-b007 : ide2
  b008-b00f : ide3
  b010-b03f : PDC20265
b400-b403 : Promise Technology, Inc. 20265
b800-b807 : Promise Technology, Inc. 20265
d000-d003 : Promise Technology, Inc. 20265
d400-d407 : Promise Technology, Inc. 20265
d800-d8ff : C-Media Electronics Inc CM8738
  d800-d8ff : cmpci
[root@test Documentation]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-5ffebfff : System RAM
  00100000-0025c742 : Kernel code
  0025c743-002d9a83 : Kernel data
5ffec000-5ffeefff : ACPI Tables
5ffef000-5fffefff : reserved
5ffff000-5fffffff : ACPI Non-volatile Storage
f2000000-f20000ff : NEC Corporation USB 2.0
  f2000000-f20000ff : ehci_hcd
f2800000-f2800fff : NEC Corporation USB (#2)
  f2800000-f2800fff : usb-ohci
f3000000-f3000fff : NEC Corporation USB
  f3000000-f3000fff : usb-ohci
f3800000-f381ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
f4000000-f4000fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f4000000-f4000fff : eepro100
f4800000-f4803fff : Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
f5000000-f50007ff : Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
  f5000000-f50007ff : ohci1394
f5800000-f581ffff : Promise Technology, Inc. 20265
f6000000-f75fffff : PCI Bus #01
  f6000000-f6ffffff : nVidia Corporation NV20 [GeForce3 Ti 200]
f7700000-fbffffff : PCI Bus #01
  f7800000-f787ffff : nVidia Corporation NV20 [GeForce3 Ti 200]
  f8000000-fbffffff : nVidia Corporation NV20 [GeForce3 Ti 200]
fc000000-fdffffff : VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
ffff0000-ffffffff : reserved

[7.5.]
lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: Asustek Computer, Inc. A7V266-E
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP] (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: f6000000-f75fffff
        Prefetchable memory behind bridge: f7700000-fbffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev
02)        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at b400 [size=4]
        Region 4: I/O ports at b000 [size=64]
        Region 5: Memory at f5800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller
(Link) (prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at f4800000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a800 [size=64]
        Region 2: Memory at f3800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01)
(prog-if 02 [16550])
        Subsystem: US Robotics/3Com USR 56k Internal FAX Modem (Model 2977)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a400 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1799:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f3000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1799:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at f2800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Unknown device 1799:0002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: Asustek Computer, Inc.: Unknown device 8052
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
(rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 9800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 9400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 9000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti200]
(rev a3) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 4057
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at f7800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at f77f0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.]
none

[7.7.]
none

[X.]
I just #'d CONFIG_RISCOM8=m out of .config

-Zachary A Pfeffer
pfefferz@colorado.edu

