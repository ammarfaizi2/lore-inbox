Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVCJXZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVCJXZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVCJXXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:23:14 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:29108 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S263360AbVCJXHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:07:39 -0500
Date: Fri, 11 Mar 2005 00:08:09 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
In-Reply-To: <20050304234622.63e8a335.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
References: <20050304234622.63e8a335.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anything new about it?

Can I provide more usefull info?


Thanks,

Grzegorz Kulewski


On Fri, 4 Mar 2005, Andrew Morton wrote:

>
>
> Begin forwarded message:
>
> Date: Fri, 4 Mar 2005 21:40:19 +0100 (CET)
> From: Grzegorz Kulewski <kangur@polcom.net>
> To: linux-kernel@vger.kernel.org
> Subject: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
>
>
> [ I posted it before but nobody anwsered... ]
>
> Hi,
>
> I just installed 2.6.11 and I was hit by the same bug (or feature?) I found in
> -rcs. Basically my USB will work only if acpi=off was passed to the kernel. It
> looks like without acpi=off it will assign IRQ 10 and with acpi=off it will
> assign IRQ9. It worked at least with 2.6.9. I do not know if the USB is
> completly broken but at least my speedtouch modem will not work (the red led
> will be on for some time then completly black).
>
>
> My lspci -vvv (2.6.11 with acpi=off):
> # lspci -vvv
> 0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
> Controller (rev 13)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>  Latency: 32
>  Region 0: Memory at f0000000 (32-bit, prefetchable)
>  Region 1: Memory at f7003000 (32-bit, prefetchable) [size=4K]
>  Region 2: I/O ports at c000 [disabled] [size=4]
>  Capabilities: [a0] AGP version 2.0
>                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
> 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+
> Rate=x4
>
> 0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP
> Bridge (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 32
>  Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>  I/O behind bridge: 0000f000-00000fff
>  Memory behind bridge: f4000000-f5ffffff
>  Prefetchable memory behind bridge: e8000000-efffffff
>  BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
>
> 0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
>  Subsystem: ABIT Computer Corp. KG7-Lite Mainboard
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 0
>  Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc.
> VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 32
>  Region 4: I/O ports at c400 [size=16]
>  Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00
> [UHCI])
>  Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 32, cache line size 08
>  Interrupt: pin D routed to IRQ 9
>  Region 4: I/O ports at c800 [size=32]
>  Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00
> [UHCI])
>  Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 32, cache line size 08
>  Interrupt: pin D routed to IRQ 9
>  Region 4: I/O ports at cc00 [size=32]
>  Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
> 40)
>  Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
>  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Interrupt: pin ? routed to IRQ 11
>  Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video
> Capture (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR+
>  Latency: 32 (4000ns min, 10000ns max)
>  Interrupt: pin A routed to IRQ 5
>  Region 0: Memory at f7000000 (32-bit, prefetchable)
> Capabilities:  [44] Vital Product Data
> Capabilities:  [4c] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
> (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR+
>  Latency: 32 (1000ns min, 63750ns max)
>  Interrupt: pin A routed to IRQ 5
>  Region 0: Memory at f7001000 (32-bit, prefetchable)
> Capabilities:  [44] Vital Product Data
> Capabilities:  [4c] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> 08)
>  Subsystem: Creative Labs SB Live! 5.1 Model SB0100
>  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 32 (500ns min, 5000ns max)
>  Interrupt: pin A routed to IRQ 9
>  Region 0: I/O ports at d000
>  Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
> (rev 08)
>  Subsystem: Creative Labs Gameport Joystick
>  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 32
>  Region 0: I/O ports at d400
>  Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:0d.0 Unknown mass storage controller: CMD Technology Inc Silicon Image
> SiI 3112 SATARaid Controller (rev 02)
>         Subsystem: CMD Technology Inc Silicon Image SiI 3112 SATARaid
> Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR+
>  Latency: 32, cache line size 08
>  Interrupt: pin A routed to IRQ 11
>  Region 0: I/O ports at d800
>  Region 1: I/O ports at dc00 [size=4]
>  Region 2: I/O ports at e000 [size=8]
>  Region 3: I/O ports at e400 [size=4]
>  Region 4: I/O ports at e800 [size=16]
>  Region 5: Memory at f7002000 (32-bit, non-prefetchable) [size=512]
>  Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> 0000:00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>  Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR+
>  Latency: 32 (8000ns min, 16000ns max)
>  Interrupt: pin A routed to IRQ 11
>  Region 0: I/O ports at ec00
>  Region 1: Memory at f7004000 (32-bit, non-prefetchable) [size=256]
>  Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:01:05.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2
> GTS/Pro] (rev a4) (prog-if 00 [VGA])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>  Latency: 248 (1250ns min, 250ns max)
>  Interrupt: pin A routed to IRQ 10
>  Region 0: Memory at f4000000 (32-bit, non-prefetchable)
>  Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
>  Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [44] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
> 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+
> Rate=x4
>
>
> My log (2.6.11 without acpi=off):
> Mar  2 23:36:56 kangur usbcore: registered new driver usbfs
> Mar  2 23:36:56 kangur usbcore: registered new driver hub
> Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> Mar  2 23:36:56 kangur PCI: setting IRQ 10 as level-triggered
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level,
> low) -> IRQ 10
> Mar  2 23:36:56 kangur parport_pc: VIA 686A/8231 detected
> Mar  2 23:36:56 kangur parport_pc: probing current configuration
> Mar  2 23:36:56 kangur parport_pc: Current parallel port base: 0x378
> Mar  2 23:36:56 kangur parport_pc: Strange, can't probe VIA parallel port:
> io=0x378, irq=7, dma=-1
> Mar  2 23:36:56 kangur pnp: the driver 'parport_pc' has been registered
> Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:09' and the
> driver 'parport_pc'
> Mar  2 23:36:56 kangur parport: PnPBIOS parport detected.
> Mar  2 23:36:56 kangur parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
> Mar  2 23:36:56 kangur USB Universal Host Controller Interface driver v2.2
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level,
> low) -> IRQ 10
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: new USB bus registered, assigned
> bus number 1
> Mar  2 23:36:56 kangur hub 1-0:1.0: USB hub found
> Mar  2 23:36:56 kangur hub 1-0:1.0: 2 ports detected
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level,
> low) -> IRQ 10
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: new USB bus registered, assigned
> bus number 2
> Mar  2 23:36:56 kangur hub 2-0:1.0: USB hub found
> Mar  2 23:36:56 kangur hub 2-0:1.0: 2 ports detected
> Mar  2 23:36:56 kangur usb 1-2: new full speed USB device using uhci_hcd and
> address 2
> Mar  2 23:36:56 kangur Linux video capture interface: v1.00
> Mar  2 23:36:56 kangur bttv: driver version 0.9.15 loaded
> Mar  2 23:36:56 kangur bttv: using 32 buffers with 2080k (520 pages) each for
> capture
> Mar  2 23:36:56 kangur bttv: Bt8xx card found (0).
> Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
> Mar  2 23:36:56 kangur PCI: setting IRQ 5 as level-triggered
> Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 (level,
> low) -> IRQ 5
> Mar  2 23:36:56 kangur bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, latency:
> 32, mmio: 0xf7000000
> Mar  2 23:36:56 kangur bttv0: using: Prolink Pixelview PV-BT878P+ (Rev.4C,8E)
> [card=70,insmod option]
> Mar  2 23:36:56 kangur bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff
> [init]
> Mar  2 23:36:56 kangur bttv0: using tuner=25
> Mar  2 23:36:56 kangur bttv0: i2c: checking for MSP34xx @ 0x80... not found
> Mar  2 23:36:56 kangur bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> Mar  2 23:36:56 kangur bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> Mar  2 23:36:56 kangur tvaudio: TV audio decoder + audio/video mux driver
> Mar  2 23:36:56 kangur tvaudio: known chips:
> tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54
> (PV951),ta8874z
> Mar  2 23:36:56 kangur bttv0: i2c: checking for TDA9887 @ 0x86... not found
> Mar  2 23:36:56 kangur tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
> Mar  2 23:36:56 kangur tuner 0-0061: type set to 25 (LG PAL_I+FM (TAPC-I001D))
> Mar  2 23:36:56 kangur bttv0: registered device video0
> Mar  2 23:36:56 kangur bttv0: registered device vbi0
> Mar  2 23:36:56 kangur bttv0: registered device radio0
> Mar  2 23:36:56 kangur bttv0: PLL: 28636363 => 35468950 .. ok
> Mar  2 23:36:56 kangur bttv0: add subdevice "remote0"
> Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: Unlink after no-IRQ? Controller
> is probably using the wrong IRQ.
> Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0in
> Mar  2 23:36:56 kangur gameport: pci0000:00:0b.1 speed 1242 kHz
> Mar  2 23:36:56 kangur Real Time Clock Driver v1.12
> Mar  2 23:36:56 kangur Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ
> sharing disabled
> Mar  2 23:36:56 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Mar  2 23:36:56 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> Mar  2 23:36:56 kangur pnp: the driver 'serial' has been registered
> Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:07' and the
> driver 'serial'
> Mar  2 23:36:56 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:08' and the
> driver 'serial'
> Mar  2 23:36:56 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
> Mar  2 23:36:56 kangur eth0: link down
> Mar  2 23:36:56 kangur eth0: link down
> Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
> Mar  2 23:36:56 kangur usb 1-2: device not accepting address 2, error -110
> Mar  2 23:36:56 kangur usb 1-2: new full speed USB device using uhci_hcd and
> address 3
> Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0in
> Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
> Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
> Mar  2 23:36:56 kangur usb 1-2: device not accepting address 3, error -110
>
>
> My log (2.6.11 with acpi=off):
> Mar  3 01:45:48 kangur usbcore: registered new driver usbfs
> Mar  3 01:45:48 kangur usbcore: registered new driver hub
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:0b.0
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.3
> Mar  3 01:45:48 kangur parport_pc: VIA 686A/8231 detected
> Mar  3 01:45:48 kangur parport_pc: probing current configuration
> Mar  3 01:45:48 kangur parport_pc: Current parallel port base: 0x378
> Mar  3 01:45:48 kangur parport_pc: Strange, can't probe VIA parallel port:
> io=0x378, irq=7, dma=-1
> Mar  3 01:45:48 kangur pnp: the driver 'parport_pc' has been registered
> Mar  3 01:45:48 kangur parport0: PC-style at 0x378 [PCSPP(,...)]
> Mar  3 01:45:48 kangur USB Universal Host Controller Interface driver v2.2
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.3
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: irq 9, io base 0xc800
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: new USB bus registered, assigned
> bus number 1
> Mar  3 01:45:48 kangur hub 1-0:1.0: USB hub found
> Mar  3 01:45:48 kangur hub 1-0:1.0: 2 ports detected
> Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.3
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.2
> Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: irq 9, io base 0xcc00
> Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: new USB bus registered, assigned
> bus number 2
> Mar  3 01:45:48 kangur hub 2-0:1.0: USB hub found
> Mar  3 01:45:48 kangur hub 2-0:1.0: 2 ports detected
> Mar  3 01:45:48 kangur usb 1-2: new full speed USB device using uhci_hcd and
> address 2
>
>
> Could somebody produce fast patch for me?
>
>
> Thanks in advance,
>
> Grzegorz Kulewski
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
