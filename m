Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVL1MGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVL1MGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 07:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVL1MGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 07:06:04 -0500
Received: from www.sam-net.de ([213.133.118.162]:24264 "EHLO www.sam-net.de")
	by vger.kernel.org with ESMTP id S964797AbVL1MGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 07:06:03 -0500
Message-ID: <43B27F9A.2060807@sam-net.de>
Date: Wed, 28 Dec 2005 13:05:46 +0100
From: Dietmar Kling <dietmar.kling@sam-net.de>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Badness in isar_pump_statev_fax 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during the holidays i tried to reactivate my old fax card,
but i get a kind of oops in the system log. Fax is received, so
is this really something to worry about?
(cpuinfo, lspci is attached)

Kind Regards
Dietmar

Dec 28 12:56:10 baldur FaxGetty[2663]: ANSWER: FAX CONNECTION  DEVICE 
'/dev/ttyI0'
Dec 28 12:56:14 baldur kernel: Badness in isar_pump_statev_fax at 
drivers/isdn/hisax/isar.c:1096 (Not tainted)
Dec 28 12:56:14 baldur kernel:  [<d8b45baa>] 
isar_pump_statev_fax+0x6fa/0x710 [hisax]
Dec 28 12:56:14 baldur kernel:  [<d8b46564>] isar_int_main+0x9a4/0xa10 
[hisax]
Dec 28 12:56:14 baldur kernel:  [<d88d84c6>] 
ohci_urb_enqueue+0x1c6/0x2e0 [ohci_hcd]
Dec 28 12:56:14 baldur kernel:  [<c02848d5>] hcd_submit_urb+0x165/0x240
Dec 28 12:56:14 baldur kernel:  [<c0285623>] usb_submit_urb+0x1b3/0x210
Dec 28 12:56:14 baldur kernel:  [<d88f2e95>] 
hci_usb_rx_complete+0x75/0x670 [hci_usb]
Dec 28 12:56:14 baldur kernel:  [<c0117bb7>] __wake_up_common+0x37/0x60
Dec 28 12:56:14 baldur kernel:  [<c0318be9>] _spin_lock_irqsave+0x9/0x10
Dec 28 12:56:14 baldur kernel:  [<c0243e25>] dma_pool_free+0x45/0xd7
Dec 28 12:56:14 baldur kernel:  [<c0284d1e>] usb_hcd_giveback_urb+0x1e/0x60
Dec 28 12:56:14 baldur kernel:  [<c011788a>] scheduler_tick+0x1a/0x300
Dec 28 12:56:14 baldur kernel:  [<d8b42057>] 
sedlbauer_interrupt_isar+0xa7/0x140 [hisax]
Dec 28 12:56:14 baldur kernel:  [<c013bdd3>] handle_IRQ_event+0x33/0x60
Dec 28 12:56:14 baldur kernel:  [<c013be7c>] __do_IRQ+0x7c/0xd0
Dec 28 12:56:14 baldur kernel:  [<c01047c1>] do_IRQ+0x51/0x90
Dec 28 12:56:14 baldur kernel:  =======================
Dec 28 12:56:15 baldur kernel:  [<c010329a>] common_interrupt+0x1a/0x20
Dec 28 12:56:15 baldur kernel:  [<c020e60d>] acpi_processor_idle+0x10e/0x26f
Dec 28 12:56:15 baldur kernel:  [<c01010ae>] cpu_idle+0xe/0x50
Dec 28 12:56:15 baldur kernel:  [<c03d074c>] start_kernel+0x15c/0x1b0
Dec 28 12:56:54 baldur FaxGetty[2883]: RECV FAX (000000002): from 
WEB.DE, page 1 in 0:42, INF, 3.85 line/mm, 2-D MMR, 14400 bit/s
Dec 28 12:56:54 baldur FaxGetty[2884]: RECV FAX (000000002): 
recvq/fax000000002.tif from WEB.DE, route to <unspecified>, 1 pages in 0:44



/sbin/lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1dfffff
        Prefetchable memory behind bridge: e1f00000-e3ffffff
        Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 
01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 7
        Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at df800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin C routed to IRQ 4
        Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:09.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) 
(prog-if 20 [EHCI])
        Subsystem: ALi Corporation: Unknown device 5272
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Allied Telesyn International AT-2500TX/ACPI
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0b.0 RAID bus controller: 3ware Inc 5xxx/6xxx-series PATA-RAID (rev 12)
        Subsystem: 3ware Inc 5xxx/6xxx-series PATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2250ns min)
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at b800 [size=16]
        [virtual] Expansion ROM at 20000000 [disabled] [size=64K]

00:0c.0 Communication controller: Tiger Jet Network Inc. Tiger100APC 
ISDN chipset
        Subsystem: Unknown device 0054:0001
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA 
TNT2/TNT2 Pro] (rev 11) (prog-if 00 [VGA])
        Subsystem: Elsa AG Erazor III
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e1ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>





