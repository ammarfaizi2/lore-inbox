Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUGJUGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUGJUGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUGJUGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:06:25 -0400
Received: from pop.gmx.net ([213.165.64.20]:22723 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266376AbUGJUFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:05:17 -0400
X-Authenticated: #14867975
From: dkey <dk.dbox2@gmx.net>
Subject: usb bulk timeout on ep1out
Date: Sat, 10 Jul 2004 22:05:51 +0200
User-Agent: KMail/1.6.2
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102205.51147.dk.dbox2@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as I didn't get any response on the usb-users ml, maybe
somebody could help me here, cause I don't know if it
is a kernel bug, or something else.
thanks in advance for any help!

greets

----------  Forwarded Message  ----------

Subject: bulk timeout on ep1out
Date: Saturday 10 July 2004 16:51
From: dkey <dk.dbox2@gmx.net>
To: linux-usb-users@lists.sourceforge.net

hi list!

i'm using a Fritz!Card USB v2.1, but it does not work under linux. i 
downloaded drivers for the device from 
http://webgw.avm.de:8080/download/Download.jsp?lang=de&os=linux&product=FRITZ!Card%
20USB%
20v2.x&category=fritz&from=http://www.avm.de/de/Download/index.inhalt.php3&cssurl=http://www.avm.de/de/Download/download_css.css&imgbase=http://www.avm.de/de/Download/images/

now my problem:
my linux machine runs kernel 2.6.7, when i connect the device i get following 
messages:
usb 2-2.2: new full speed USB device using address 6
usb 2-2.2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2.2: default language 0x0409
usb 2-2.2: Product: FRITZ!Card USB v2.1
usb 2-2.2: Manufacturer: AVM Berlin
usb 2-2.2: hotplug
usb 2-2.2: configuration #1 chosen from 2 choices
usb 2-2.2: adding 2-2.2:1.0 (config #1, interface 0)
usb 2-2.2:1.0: hotplug

after starting capiinit
CAPI Subsystem Rev 1.1.2.8
capifs: Rev 1.1.2.3
capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
fcusb2: module license 'Proprietary' taints kernel.
fcusb2: AVM FRITZ!Card USB v2 driver, revision 0.5.2
fcusb2: (fcusb2 built on Jul  9 2004 at 23:11:20)
fcusb2: Loading...
fcusb2 2-2.2:1.0: usb_probe_interface
fcusb2 2-2.2:1.0: usb_probe_interface - got id
fcusb2: Driver 'fcusb2' attached to stack. (152)
kcapi: Controller 1: fcusb2-0006 attached
usbcore: registered new driver fcusb2
fcusb2: Loaded.
usb 2-2.2: bulk timeout on ep1out
fcusb2: USB I/O error, code -110!
fcusb2: Firmware does not respond!
kcapi: card 1 down.


lcpci output:
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS 645xx
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=3 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x8

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI 
bridge (AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media 
IO] (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 10c0 [size=32]

0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire 
Controller (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 701d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 3000ns max)
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at e2427000 (32-bit, non-prefetchable)
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(prog-if 80 [Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 11
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
Sound Controller (rev a0)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at d400
        Region 1: I/O ports at d800 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e2420000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at e2421000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at e2422000 (32-bit, non-prefetchable)

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at e2423000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI 
Fast Ethernet (rev 91)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0900
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at dc00
        Region 1: Memory at e2424000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e000
        Region 1: Memory at e2425000 (32-bit, non-prefetchable) [size=256]

0000:00:08.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
        Subsystem: Creatix Polymedia GmbH: Unknown device 0003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 8000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at e2426000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:00:0a.0 Communication controller: Intel Corp. 536EP Data Fax Modem
        Subsystem: Creatix Polymedia GmbH V.9X DSP Data Fax Modem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e2000000 (32-bit, non-prefetchable)
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=375mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0431
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x8


please cc me, as i'm not subscribed on this list!

greets

