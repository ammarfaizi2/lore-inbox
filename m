Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130083AbQJ1Qrd>; Sat, 28 Oct 2000 12:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQJ1QrY>; Sat, 28 Oct 2000 12:47:24 -0400
Received: from janus.hosting4u.net ([209.15.2.37]:40968 "HELO
	janus.hosting4u.net") by vger.kernel.org with SMTP
	id <S130083AbQJ1QrD>; Sat, 28 Oct 2000 12:47:03 -0400
Message-ID: <39FB024B.220A025C@a2zis.com>
Date: Sat, 28 Oct 2000 18:43:55 +0200
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No IRQ known for interrupt pin A of device 00:0f.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just saw this warning when booting:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try
using pci=biosirq.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later

Booting with pci=biosirq doesn't help.
Both test10-pre5 and test10-pre6 give this warning. test9 didn't.

Should I just ignore it or is it really a problem?
(My system seems to work ok)


lspci -vv:
00:00.0 Host bridge: Acer Laboratories Inc. M1541 (rev 04)
        Subsystem: Unknown device 10b9:1541
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)
        Capabilities: [b0] AGP version 1.0
                Status: RQ=28 SBA+ 64bit- FW- Rate=21
                Command: RQ=28 SBA+ AGP- 64bit- FW- Rate=21

00:01.0 PCI bridge: Acer Laboratories Inc. M5243 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: df800000-dfffffff
        Prefetchable memory behind bridge: e6f00000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. M5237 (rev 03) (prog-if
10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 max, 0 set
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at df000000 (32-bit, non-prefetchable)

00:03.0 Bridge: Acer Laboratories Inc. M7101
        Subsystem: Unknown device 10b9:7101
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. M1533 (rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0 set

00:09.0 Multimedia audio controller: Creative Labs SB Live! (rev 04)
        Subsystem: Unknown device 1102:0020
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 20 max, 32 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! Daughterboard
(rev 01)
        Subsystem: Unknown device 1102:0020
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 0: I/O ports at d400
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1) (prog-if
fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 4 max, 32 set
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at d000

01:00.0 VGA compatible controller: Intel Corporation i740 (rev 21)
        Subsystem: Unknown device 10b0:0100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e7000000 (32-bit, prefetchable)
        Region 1: Memory at df800000 (32-bit, non-prefetchable)
        Capabilities: [d0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=31 SBA+ AGP- 64bit- FW- Rate=21
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 0
cpu MHz         : 350.000808
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mmx 3dnow
bogomips        : 699.60


/proc/interrupts:
           CPU0       
  0:      88116          XT-PIC  timer
  1:       3128          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       1454          XT-PIC  serial
  6:         19          XT-PIC  floppy
  8:          1          XT-PIC  rtc
 10:          0          XT-PIC  EMU10K1
 13:          0          XT-PIC  fpu
 14:         17          XT-PIC  ide0
 15:       7477          XT-PIC  ide1
NMI:          0 
ERR:          0

-- 
Linux 2.4.0-test10-pre6 #1 Sat Oct 28 14:15:54 CEST 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
