Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUHMXl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUHMXl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267771AbUHMXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:41:00 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:55533 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S267753AbUHMXhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:37:43 -0400
Message-ID: <411D50C6.3040707@verizon.net>
Date: Fri, 13 Aug 2004 19:37:42 -0400
From: Mike <turbanator1@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Major problems with USB Mass-Storage device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.202.99.32] at Fri, 13 Aug 2004 18:37:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to mount disks in my HP DVD200E USB/Firewire (connected via 
USB 2.0) writer:

ehci_hcd 0000:00:09.3: devpath 1 ep2in 3strikes
ehci_hcd 0000:00:09.3: devpath 1 ep1out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
ehci_hcd 0000:00:09.3: devpath 1 ep1out 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 8
Buffer I/O error on device sr0, logical block 1
ehci_hcd 0000:00:09.3: devpath 1 ep2in 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 16
Buffer I/O error on device sr0, logical block 2
end_request: I/O error, dev sr0, sector 24
Buffer I/O error on device sr0, logical block 3
Buffer I/O error on device sr0, logical block 4
Buffer I/O error on device sr0, logical block 5
Buffer I/O error on device sr0, logical block 6
Buffer I/O error on device sr0, logical block 7
Buffer I/O error on device sr0, logical block 8
Buffer I/O error on device sr0, logical block 9
Buffer I/O error on device sr0, logical block 10
Buffer I/O error on device sr0, logical block 11
Buffer I/O error on device sr0, logical block 12
Buffer I/O error on device sr0, logical block 13
Buffer I/O error on device sr0, logical block 14
Buffer I/O error on device sr0, logical block 15
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 8
ehci_hcd 0000:00:09.3: devpath 1 ep2in 3strikes
ehci_hcd 0000:00:09.3: devpath 1 ep2in 3strikes
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0

I can confirm that the DVD I am trying to mount works fine in my Samsung 
SD-610 DVD-ROM drive, which is /dev/hdd.

When attempting to read files on any DVD, I get errors similar to:

ehci_hcd 0000:00:09.3: devpath 1 ep2in 3strikes

I am also seeing seek errors when playing MP3s that are stored on this DVD.

This is the output of /sbin/lspci -v -v, just in case it's necessary:

root@opiate:/home/cpio# /sbin/lspci -v -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
        Subsystem: Asustek Computer, Inc.: Unknown device 8018
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x2
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d76fffff
        Prefetchable memory behind bridge: d7700000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 23)
        Subsystem: Asustek Computer, Inc.: Unknown device 8018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 11) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 4
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management 
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) 
(prog-if 20 [EHCI])
        Subsystem: Unknown device 2020:8888
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2090]

00:0a.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX 
(rev 10)
        Subsystem: Hewlett-Packard Company: Unknown device 9207
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d7800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at d77e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2

This is the output of lsusb -v -v, just in case this is needed as well:

Bus 002 Device 003: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x0040 Wheel Mouse Optical
  bcdDevice            3.00
  iManufacturer           1 Microsoft
  iProduct                3 Microsoft 3-Button Mouse with IntelliEye(TM)
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  bytes 4 three times
        bInterval              10
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      72

Bus 002 Device 002: ID 058f:9254 Alcor Micro Corp. Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x058f Alcor Micro Corp.
  idProduct          0x9254 Hub
  bcdDevice            1.00
  iManufacturer           1 ALCOR
  iProduct                2 Generic USB Hub
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  bytes 1 once
        bInterval             255

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.7 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller
  iSerial                 1 0000:00:04.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

Bus 001 Device 002: ID 03f0:0507 Hewlett-Packard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x03f0 Hewlett-Packard
  idProduct          0x0507
  bcdDevice            3.10
  iManufacturer          73 Hewlett-Packard
  iProduct               89 USB Storage Adapter
  iSerial               109
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     2
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  bytes 512 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  bytes 512 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval               9

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.7 ehci_hcd
  iProduct                2 ALi Corporation USB 2.0 Controller
  iSerial                 1 0000:00:09.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval              12
root@opiate:/home/cpio# lsusb -v -v

Bus 002 Device 003: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x0040 Wheel Mouse Optical
  bcdDevice            3.00
  iManufacturer           1 Microsoft
  iProduct                3 Microsoft 3-Button Mouse with IntelliEye(TM)
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  bytes 4 three times
        bInterval              10
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      72

Bus 002 Device 002: ID 058f:9254 Alcor Micro Corp. Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x058f Alcor Micro Corp.
  idProduct          0x9254 Hub
  bcdDevice            1.00
  iManufacturer           1 ALCOR
  iProduct                2 Generic USB Hub
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  bytes 1 once
        bInterval             255

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.7 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller
  iSerial                 1 0000:00:04.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

Bus 001 Device 002: ID 03f0:0507 Hewlett-Packard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x03f0 Hewlett-Packard
  idProduct          0x0507
  bcdDevice            3.10
  iManufacturer          73 Hewlett-Packard
  iProduct               89 USB Storage Adapter
  iSerial               109 0000000000024286
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     2
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  bytes 512 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  bytes 512 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval               9

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.7 ehci_hcd
  iProduct                2 ALi Corporation USB 2.0 Controller
  iSerial                 1 0000:00:09.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval              12

This are my boot messages, just in case:

Linux version 2.6.7 (root@opiate) (gcc version 3.3.4) #2 Fri Aug 13 
18:53:10 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffc000 (usable)
 BIOS-e820: 0000000017ffc000 - 0000000017fff000 (ACPI data)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98300
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94204 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI disabled because your bios is from 2000 and too old
You can enable it with acpi=force
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
CPU 0 irqstacks, hard=c03b4000 soft=c03b3000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 731.486 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 386368k/393200k available (1872k kernel code, 6084k reserved, 
751k data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1441.79 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 731.0338 MHz.
..... host bus clock speed is 132.0970 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0a00, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0596] at 0000:00:04.0
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
udf: registering filesystem
Activating ISA DMA hang workarounds.
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 10 for device 0000:00:0a.0
eth0: RealTek RTL8139 at 0xd880d000, 00:10:b5:58:c8:d7, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 94610U6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: OPTORITECD-RW CW5201, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
PCI: Found IRQ 4 for device 0000:00:09.3
PCI: Sharing IRQ 4 with 0000:00:04.2
ehci_hcd 0000:00:09.3: ALi Corporation USB 2.0 Controller
ehci_hcd 0000:00:09.3: reset hcs_params 0x101216 dbg=1 cc=1 pcc=2 
ordered ports=6
ehci_hcd 0000:00:09.3: reset hcc_params 7002 thresh 0 uframes 256/512/1024
ehci_hcd 0000:00:09.3: capability 0001 at 70
ehci_hcd 0000:00:09.3: irq 4, pci mem d880f000
ehci_hcd 0000:00:09.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:09.3: reset command 080002 (park)=0 ithresh=8 
period=1024 Reset HALT
ehci_hcd 0000:00:09.3: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:09.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:09.3: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: ALi Corporation USB 2.0 Controller
usb usb1: Manufacturer: Linux 2.6.7 ehci_hcd
usb usb1: SerialNumber: 0000:00:09.3
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 4 for device 0000:00:04.2
PCI: Sharing IRQ 4 with 0000:00:09.3
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:04.2: irq 4, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.2: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb2: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb2: SerialNumber: 0000:00:04.2
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/media/usbvideo.c: usbvideo_register: module == NULL!
usbcore: registered new driver ibmcam
drivers/usb/media/usbvideo.c: usbvideo_register: module == NULL!
usbcore: registered new driver ultracam
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
ehci_hcd 0000:00:09.3: GetStatus port 1 status 001803 POWER sig=j  CSC 
CONNECT
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
hub 1-0:1.0: port 1 not reset yet, waiting 50ms
ehci_hcd 0000:00:09.3: port 1 high speed
ehci_hcd 0000:00:09.3: GetStatus port 1 status 001005 POWER sig=se0  PE 
CONNECT
usb 1-1: new high speed USB device using address 2
usb 1-1: new device strings: Mfr=73, Product=89, SerialNumber=109
usb 1-1: default language 0x0409
usb 1-1: Product: USB Storage Adapter
usb 1-1: Manufacturer: Hewlett-Packard
usb 1-1: SerialNumber: 0000000000024286
usb 1-1: hotplug
usb 1-1: adding 1-1:2.0 (config #2, interface 0)
usb 1-1:2.0: hotplug
usb-storage 1-1:2.0: usb_probe_interface
usb-storage 1-1:2.0: usb_probe_interface - got id
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: HP        Model: DVD Writer 200j   Rev: 1.72
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
USB Mass Storage device found at 2
uhci_hcd 0000:00:04.2: port 1 portsc 008a
hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:04.2: port 2 portsc 009b
hub 2-0:1.0: port 2, status 0101, change 0003, 12 Mb/s
uhci_hcd 0000:00:04.2: port 2 portsc 0099
uhci_hcd 0000:00:04.2: port 2 portsc 0099
uhci_hcd 0000:00:04.2: port 2 portsc 0099
uhci_hcd 0000:00:04.2: port 2 portsc 0099
uhci_hcd 0000:00:04.2: port 2 portsc 0099
hub 2-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
usb 2-2: new full speed USB device using address 2
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2: default language 0x0409
usb 2-2: Product: Generic USB Hub
usb 2-2: Manufacturer: ALCOR
usb 2-2: hotplug
usb 2-2: adding 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
hub 2-2:1.0: usb_probe_interface
hub 2-2:1.0: usb_probe_interface - got id
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
hub 2-2:1.0: standalone hub
hub 2-2:1.0: ganged power switching
hub 2-2:1.0: global over-current protection
hub 2-2:1.0: power on to power good time: 44ms
hub 2-2:1.0: local power source is good
hub 2-2:1.0: no over-current condition exists
hub 2-2:1.0: enabling power on all ports
uhci_hcd 0000:00:04.2: port 1 portsc 0088
hub 2-0:1.0: port 1 enable change, status 00000100
hub 2-2:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
hub 2-2:1.0: debounce: port 2: delay 100ms stable 4 status 0x301
usb 2-2.2: new low speed USB device using address 3
usb 2-2.2: skipped 1 descriptor after interface
usb 2-2.2: new device strings: Mfr=1, Product=3, SerialNumber=0
usb 2-2.2: default language 0x0409
usb 2-2.2: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
usb 2-2.2: Manufacturer: Microsoft
usb 2-2.2: hotplug
usb 2-2.2: adding 2-2.2:1.0 (config #1, interface 0)
usb 2-2.2:1.0: hotplug
usbhid 2-2.2:1.0: usb_probe_interface
usbhid 2-2.2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with 
IntelliEye(TM)] on usb-0000:00:04.2-2.2
Adding 1564880k swap on /dev/hda9.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

To use my DVD writer, I have the following options compiled into the kernel:

SCSI CDROM
Enable vendor-specific extensions
Probe all LUNS
USB EHCI
Enforce bus bandwidth allocation
USB UHCI (for the USB controller on my motherboard and for USB 1.1 
compatibility from my USB 2.0 card)
USB Mass-Storage support

ACPI is off.

PnP is off in my BIOS.
USB Legacy support is off in my BIOS.
