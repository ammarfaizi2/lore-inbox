Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbUJZHiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbUJZHiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUJZHip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:38:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:5594 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262166AbUJZHfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:35:33 -0400
Subject: USB stopped working on my g5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 17:32:09 +1000
Message-Id: <1098775929.6916.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David !

With today's bk tree, I get an infinite loop of those messages from the USB
stack on the G5. I also added the lspci output. It's a keyboard & mouse setup
plugged into one of the ports of a NEC EHCI/OHCI.

usb 4-2: new full speed USB device using ohci_hcd and address 118
hub 4-2:1.0: USB hub found
hub 4-2:1.0: 3 ports detected
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 121
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 121
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 124
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 124
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 127
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 127
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 4
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 4
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 7
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 7
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 10
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 10
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 13
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 13
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 16
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)
usb 4-2.3: USB disconnect, address 16
usb 4-2: reset full speed USB device using ohci_hcd and address 118
usb 4-2.3: new full speed USB device using ohci_hcd and address 19
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:0b.0-2.3
hub 4-2:1.0: hub_port_status failed (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: cannot reset port 1 (err = -110)
hub 4-2:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: cannot disable port 1 (err = -110)
hub 4-2:1.0: hub_port_status failed (err = -110)

0000:f0:0b.0 Host bridge: Apple Computer Inc.: Unknown device 004b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size: 0x08 (32 bytes)
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans+ 64bit+ FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit+ FW- Rate=<none>

0000:f0:10.0 VGA compatible controller: ATI Technologies Inc RV350 AP [Radeon 9600] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc RV350 AP [Radeon 9600]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=90020000]
	Region 1: I/O ports at fd800400 [size=256]
	Region 2: Memory at 90000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [0041]

0001:00:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]

0001:00:03.0 PCI bridge: Apple Computer Inc.: Unknown device 0045 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: 80000000-800fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [70] #08 [00a3]
	Capabilities: [90] #08 [8000]

0001:00:04.0 PCI bridge: Apple Computer Inc.: Unknown device 0046 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	Memory behind bridge: 80100000-801fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [70] #08 [8824]

0001:00:05.0 PCI bridge: Apple Computer Inc.: Unknown device 0047 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	Memory behind bridge: 80200000-802fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [70] #08 [8824]

0001:00:06.0 PCI bridge: Apple Computer Inc.: Unknown device 0048 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	Memory behind bridge: 80300000-805fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [70] #08 [8824]

0001:00:07.0 PCI bridge: Apple Computer Inc.: Unknown device 0049 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	Memory behind bridge: 80600000-806fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [70] #08 [8824]

0001:01:07.0 Class ff00: Apple Computer Inc.: Unknown device 0041 (rev 20)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, Cache Line Size: 0x10 (64 bytes)
	Region 0: Memory at 80000000 (32-bit, non-prefetchable)

0001:01:08.0 USB Controller: Apple Computer Inc.: Unknown device 0040 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 80081000 (32-bit, non-prefetchable)

0001:01:09.0 USB Controller: Apple Computer Inc.: Unknown device 0040 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 80080000 (32-bit, non-prefetchable)

0001:02:0b.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 63
	Region 0: Memory at 80102000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:02:0b.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 63
	Region 0: Memory at 80101000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:02:0b.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation USB 2.0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (4000ns min, 8500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 63
	Region 0: Memory at 80100000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:03:0d.0 Class ff00: Apple Computer Inc.: Unknown device 0043
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Region 0: Memory at 80204000 (32-bit, non-prefetchable)

0001:03:0e.0 FireWire (IEEE 1394): Apple Computer Inc.: Unknown device 0042 (prog-if 10 [OHCI])
	Subsystem: Apple Computer Inc.: Unknown device 5811
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (3000ns min, 6000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at 80200000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0001:04:0f.0 Ethernet controller: Apple Computer Inc.: Unknown device 004c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16 (16000ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at 80400000 (32-bit, non-prefetchable) [size=80300000]
	Expansion ROM at 00100000 [disabled]

0001:05:0c.0 IDE interface: ServerWorks: Unknown device 0240 (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ServerWorks: Unknown device 0240
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16
	Region 0: I/O ports at <unassigned> [disabled]
	Region 1: I/O ports at <unassigned> [disabled]
	Region 2: I/O ports at <unassigned> [disabled]
	Region 3: I/O ports at <unassigned> [disabled]
	Region 4: I/O ports at <unassigned> [disabled]
	Region 5: Memory at 80600000 (32-bit, non-prefetchable) [size=8K]



