Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUCQMKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUCQMKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 07:10:43 -0500
Received: from mfifmail.fif.mw.htw-dresden.de ([141.56.22.51]:25619 "EHLO
	mfifmail.fif.mw.htw-dresden.de") by vger.kernel.org with ESMTP
	id S261405AbUCQMKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 07:10:21 -0500
Message-ID: <4058402A.6030407@fif.mw.htw-dresden.de>
Date: Wed, 17 Mar 2004 13:10:18 +0100
From: Uwe Lienig <Uwe.Lienig@fif.mw.htw-dresden.de>
Organization: Forschungsinstitut Fahrzeugtechnik -FiF-
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ASUS A7V8X-X LAN/SOUND randomly freezes under linux-2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first the bits.

[1.] One line summary of the problem:
ASUS A7V8X-X LAN/SOUND at random freezes under linux-2.4.20 totally, no response

[2.] Full description of the problem/report:
I searched the web on this, but couldn't find anything useful. The only hint was 
to add the option mem=nopentium to the bootparams. No differences. Most people 
reported on the sound/lan not found on this board. But the symptom is totally 
different here. The system becomes totally unresponsible in my case. At random 
the system freezes totally. No ping, no keyboard, no Ctrl-Alt-Del (it's not 
commented out). The only possibility is to press pwr on button longer than 4s 
(power down the ATX power supply).
I contacted ASUS but didn't get an answer yet (maybe they'll look into this ?!).
memtest ran for at least 12 hours without any error. All other hardware checks 
have been done (cable, memmodules, cpu seated correctly and so on)

[3.] Keywords (i.e., modules, networking, kernel):
kernel

[4.] Kernel version (from /proc/version):
Linux version 2.4.20-4GB-athlon (root@Athlon.suse.de) (gcc version 3.3 20030226 
(prerelease) (SuSE Linux)) #1 Sat Feb 7 02:00:47 UTC 2004

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
No Oops, nothing is output

[6.] A small shell script or example program which triggers the
      problem (if possible)
not available

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2500+
stepping        : 0
cpu MHz         : 1822.568
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
                   pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3630.69

[7.3.] Module information (from /proc/modules):
lp                      6400   0 (autoclean)
parport_pc             28200   1
parport                25352   1 [lp parport_pc]
usbserial              19580   0 (autoclean) (unused)
videodev                6176   0 (autoclean)
radeon                111392   1
agpgart                38656   3 (autoclean)
isa-pnp                31560   0 (unused)
ipv6                  145108  -1 (autoclean)
keybdev                 2124   0 (unused)
hid                    19428   0 (unused)
mousedev                4372   1
joydev                  5792   0 (unused)
evdev                   4192   0 (unused)
input                   3264   0 [keybdev hid mousedev joydev evdev]
usb-uhci               23664   0 (unused)
ehci-hcd               17612   0 (unused)
usbcore                63116   1 [usbserial hid usb-uhci ehci-hcd]
raw1394                15828   0 (unused)
ieee1394               36496   0 [raw1394]
via-rhine              12912   1
mii                     2528   0 [via-rhine]
lvm-mod                67812   0 (autoclean)
reiserfs              217396   6

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
# cat /proc/ioports
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a400-a4ff : VIA Technologies, Inc. VT6102 [Rhine-II]
   a400-a4ff : via-rhine
a800-a80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
   a800-a807 : ide0
   a808-a80f : ide1
b000-b01f : VIA Technologies, Inc. USB (#3)
   b000-b01f : usb-uhci
b400-b41f : VIA Technologies, Inc. USB (#2)
   b400-b41f : usb-uhci
b800-b81f : VIA Technologies, Inc. USB
   b800-b81f : usb-uhci
d000-dfff : PCI Bus #01
   d800-d8ff : ATI Technologies Inc Radeon R200 QH [Radeon 8500]
e000-e0ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
   00100000-002a8ef1 : Kernel code
   002a8ef2-00338123 : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
ee000000-ee0000ff : VIA Technologies, Inc. VT6102 [Rhine-II]
   ee000000-ee0000ff : via-rhine
ee800000-ee8000ff : VIA Technologies, Inc. USB 2.0
   ee800000-ee8000ff : ehci-hcd
ef000000-efefffff : PCI Bus #01
   ef000000-ef00ffff : ATI Technologies Inc Radeon R200 QH [Radeon 8500]
eff00000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : ATI Technologies Inc Radeon R200 QH [Radeon 8500]
     f0000000-f3ffffff : vesafb
f8000000-fbffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
         Subsystem: Asustek Computer, Inc.: Unknown device 807f
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal 
decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: ef000000-efefffff
         Prefetchable memory behind bridge: eff00000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 4: I/O ports at b800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin B routed to IRQ 10
         Region 4: I/O ports at b400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin C routed to IRQ 10
         Region 4: I/O ports at b000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 10
         Interrupt: pin D routed to IRQ 10
         Region 0: Memory at ee800000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master 
IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 255
         Region 4: I/O ports at a800 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
Controller (rev 50)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 3
         Region 0: I/O ports at e000 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a1
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (750ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at a400 [size=256]
         Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QH [Radeon 
8500] (rev 80) (prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc FireGL 8700 64Mb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Region 1: I/O ports at d800 [size=256]
         Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at effe0000 [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
# cat /proc/scsi/scsi
Attached devices: none

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
I'd like to know what can be done to get closer what happens here. I would like 
to clear things without switching to 2.6. Maybe someone can tell me how to 
improve the logging of the kernel so that there is a log somewhere to see what 
the system was doing prior to the freeze.

Any thoughts are very appreciated.

TIA

-- 
Uwe Lienig  | fon: (+49 351) 462 2780 | mailto:uwe.lienig@fif.mw.htw-dresden.de
             | fax: (+49 351) 462 3476 | http://www.fif.mw.htw-dresden.de
HTW Dresden | parcels: Gutzkowstr. 22 | letters: PF 12 07 01
    -FiF-    |          01069 Dresden  |          01008 Dresden
