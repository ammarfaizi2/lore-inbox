Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292324AbSCDMBg>; Mon, 4 Mar 2002 07:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292326AbSCDMB2>; Mon, 4 Mar 2002 07:01:28 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:46780 "EHLO
	mx02.derobert.net") by vger.kernel.org with ESMTP
	id <S292324AbSCDMBO>; Mon, 4 Mar 2002 07:01:14 -0500
Date: Mon, 4 Mar 2002 07:00:55 -0500
Mime-Version: 1.0 (Apple Message framework v481)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: 2.4.17 USB problems
From: Anthony DeRobertis <derobert+anthony@erols.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7CEBD8B5-2F67-11D6-A7D0-00039355CFA6@erols.com>
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Compaq Presario 5000US here which is having weird USB 
errors. This machine works in Windows, so I think the hardware 
works.

Here is an except from kern.log:

Mar  4 05:32:03 galileo kernel: usb.c: registered new driver usbdevfs
Mar  4 05:32:03 galileo kernel: usb.c: registered new driver hub
Mar  4 05:32:03 galileo kernel: usb.c: registered new driver hiddev
Mar  4 05:32:03 galileo kernel: usb.c: registered new driver hid
Mar  4 05:32:03 galileo kernel: hid-core.c: v1.8 Andreas Gal, 
Vojtech Pavlik <vojtech@suse.cz>
Mar  4 05:32:03 galileo kernel: hid-core.c: USB HID support drivers
Mar  4 05:32:03 galileo kernel: mice: PS/2 mouse device common 
for all mice
Mar  4 05:34:11 galileo kernel: usb-uhci.c: $Revision: 1.268 $ 
time 18:50:42 Dec 22 2001
Mar  4 05:34:11 galileo kernel: usb-uhci.c: High bandwidth mode enabled
Mar  4 05:34:11 galileo kernel: PCI: Assigned IRQ 11 for device 00:14.2
Mar  4 05:34:11 galileo kernel: PCI: Sharing IRQ 11 with 00:14.3
Mar  4 05:34:11 galileo kernel: usb-uhci.c: USB UHCI at I/O 
0x1840, IRQ 11
Mar  4 05:34:11 galileo kernel: usb-uhci.c: Detected 2 ports
Mar  4 05:34:11 galileo kernel: usb.c: new USB bus registered, 
assigned bus number 1
Mar  4 05:34:11 galileo kernel: hub.c: USB hub found
Mar  4 05:34:11 galileo kernel: hub.c: 2 ports detected
Mar  4 05:34:11 galileo kernel: PCI: Found IRQ 11 for device 00:14.3
Mar  4 05:34:11 galileo kernel: PCI: Sharing IRQ 11 with 00:14.2
Mar  4 05:34:11 galileo kernel: usb-uhci.c: USB UHCI at I/O 
0x1860, IRQ 11
Mar  4 05:34:11 galileo kernel: usb-uhci.c: Detected 2 ports
Mar  4 05:34:11 galileo kernel: usb.c: new USB bus registered, 
assigned bus number 2
Mar  4 05:34:11 galileo kernel: hub.c: USB hub found
Mar  4 05:34:11 galileo kernel: hub.c: 2 ports detected
Mar  4 05:34:11 galileo kernel: usb-uhci.c: v1.268:USB Universal 
Host Controller Interface driver
Mar  4 05:34:12 galileo kernel: hub.c: USB new device connect on 
bus2/1, assigned device number 2
Mar  4 05:34:12 galileo kernel: input0: USB HID v1.00 Keyboard 
[Compaq Compaq] on usb2:2.0
Mar  4 05:34:12 galileo kernel: usb-uhci.c: interrupt, status 2, 
frame# 866
Mar  4 05:34:12 galileo kernel: usb-uhci.c: ENXIO 84000280, 
flags 0, urb d1cab820, burb d1cab720
Mar  4 05:34:13 galileo last message repeated 3 times
Mar  4 05:34:15 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:34:18 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:34:19 galileo kernel: usb-uhci.c: ENXIO 84000280, 
flags 0, urb d1cab820, burb d1cab720
Mar  4 05:34:21 galileo last message repeated 7 times
Mar  4 05:34:21 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:34:51 galileo last message repeated 10 times
Mar  4 05:35:00 galileo last message repeated 3 times
Mar  4 05:35:00 galileo kernel: input1,hiddev0: USB HID v1.00 
Pointer [Compaq Compaq] on usb2:2.1
Mar  4 05:35:00 galileo kernel: hub.c: USB new device connect on 
bus2/2, assigned device number 3
Mar  4 05:35:03 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:35:03 galileo kernel: usb.c: USB device not accepting 
new address=3 (error=-110)
Mar  4 05:35:03 galileo kernel: hub.c: USB new device connect on 
bus2/2, assigned device number 4
Mar  4 05:35:06 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:35:06 galileo kernel: usb.c: USB device not accepting 
new address=4 (error=-110)
Mar  4 05:35:35 galileo kernel: usb.c: registered new driver usbscanner
Mar  4 05:35:35 galileo kernel: scanner.c: 0.4.6:USB Scanner Driver
Mar  4 05:35:47 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:36:18 galileo last message repeated 9 times
Mar  4 05:36:24 galileo last message repeated 2 times
Mar  4 05:36:46 galileo kernel: usb.c: deregistering driver usbscanner
Mar  4 05:36:52 galileo kernel: SCSI subsystem driver Revision: 1.00
Mar  4 05:36:52 galileo kernel: usb.c: registered new driver microtekX6
Mar  4 05:36:52 galileo kernel: microtek.c: v0.4.3:Microtek 
Scanmaker X6 USB scanner driver
Mar  4 05:37:05 galileo kernel: usb.c: deregistering driver microtekX6
Mar  4 05:50:17 galileo kernel: parport0: PC-style at 0x378 
(0x778) [PCSPP,TRISTATE]
Mar  4 05:50:17 galileo kernel: parport0: Printer, Lexmark Inkjet 4103
Mar  4 05:50:17 galileo kernel: parport_pc: Via 686A parallel 
port: io=0x378
Mar  4 05:50:17 galileo kernel: lp0: using parport0 (polling).
Mar  4 05:50:17 galileo kernel: lp0: compatibility mode
Mar  4 05:50:20 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:50:29 galileo last message repeated 3 times
Mar  4 05:50:29 galileo kernel: lp0: compatibility mode
Mar  4 05:50:32 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:50:41 galileo last message repeated 3 times
Mar  4 05:50:41 galileo kernel: lp0: compatibility mode
Mar  4 05:50:44 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:50:53 galileo last message repeated 3 times
Mar  4 05:54:44 galileo kernel: lp0: compatibility mode
Mar  4 05:54:47 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:54:56 galileo last message repeated 3 times
Mar  4 05:54:56 galileo kernel: lp0: compatibility mode
Mar  4 05:54:59 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:55:08 galileo last message repeated 3 times
Mar  4 05:55:08 galileo kernel: lp0: compatibility mode
Mar  4 05:55:11 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:55:20 galileo last message repeated 3 times
Mar  4 05:58:34 galileo kernel: lp0: compatibility mode
Mar  4 05:58:37 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:58:46 galileo last message repeated 3 times
Mar  4 05:58:46 galileo kernel: lp0: compatibility mode
Mar  4 05:58:49 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:58:58 galileo last message repeated 3 times
Mar  4 05:58:58 galileo kernel: lp0: compatibility mode
Mar  4 05:59:01 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 05:59:10 galileo last message repeated 3 times
Mar  4 06:04:24 galileo kernel: lp0: compatibility mode
Mar  4 06:04:27 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:04:36 galileo last message repeated 3 times
Mar  4 06:04:36 galileo kernel: lp0: compatibility mode
Mar  4 06:04:39 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:04:48 galileo last message repeated 3 times
Mar  4 06:04:48 galileo kernel: lp0: compatibility mode
Mar  4 06:04:51 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:05:00 galileo last message repeated 3 times
Mar  4 06:06:36 galileo kernel: lp0: compatibility mode
Mar  4 06:06:39 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:06:48 galileo last message repeated 3 times
Mar  4 06:06:48 galileo kernel: lp0: compatibility mode
Mar  4 06:06:51 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:07:00 galileo last message repeated 3 times
Mar  4 06:07:00 galileo kernel: lp0: compatibility mode
Mar  4 06:07:03 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:07:12 galileo last message repeated 3 times
Mar  4 06:08:34 galileo kernel: lp0: compatibility mode
Mar  4 06:08:37 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:08:46 galileo last message repeated 3 times
Mar  4 06:08:46 galileo kernel: lp0: compatibility mode
Mar  4 06:08:49 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:08:58 galileo last message repeated 3 times
Mar  4 06:08:59 galileo kernel: lp0: compatibility mode
Mar  4 06:09:02 galileo kernel: usb_control/bulk_msg: timeout
Mar  4 06:09:11 galileo last message repeated 3 times
Mar  4 06:13:53 galileo kernel: keyboard: Timeout - AT keyboard 
not present?(f4)
Mar  4 06:13:55 galileo kernel: keyboard: Timeout - AT keyboard 
not present?(f4)


And, of course, lspci -vvv
galileo:~# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x 
[Apollo PRO133x] (rev 03)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at 50000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 
[KT133/KM133 AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: 40000000-40ffffff
         Prefetchable memory behind bridge: 42000000-43ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Modem: PCTel Inc HSP MicroModem 56 (rev 02) (prog-if 04 
[Hayes/16750])
         Subsystem: PCTel Inc: Unknown device 0001
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 1800 [size=64]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139 (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 66 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at 1000 [size=256]
         Region 1: Memory at 44000000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo 
Super South] (rev 22)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:14.1 IDE interface: VIA Technologies, Inc. Bus Master IDE 
(rev 10) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at 1880 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) 
(prog-if 00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 66, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at 1840 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) 
(prog-if 00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 66, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at 1860 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
ACPI] (rev 30)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.5 Multimedia audio controller: VIA Technologies, Inc. AC97 
Audio Controller (rev 20)
         Subsystem: Compaq Computer Corporation: Unknown device 003d
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 10
         Region 0: I/O ports at 1400 [size=256]
         Region 1: I/O ports at 1890 [size=4]
         Region 2: I/O ports at 1894 [size=4]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta 
[NV6] (rev 15) (prog-if 00 [VGA])
         Subsystem: nVidia Corporation: Unknown device 001c
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 3
         Region 0: Memory at 40000000 (32-bit, non-prefetchable) 
[size=16M]
         Region 1: Memory at 42000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


And, uname:

galileo:~# uname -a
Linux galileo 2.4.17-k6 #2 Sat Dec 22 22:02:17 EST 2001 i686 unknown

This is a kernel from Debian testing.

I've tried both uhci and usb-uhci. I've tried turning on and off 
'legacy usb keyboard support' in the bios. Any suggestions?

