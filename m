Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278110AbRJKFpn>; Thu, 11 Oct 2001 01:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278112AbRJKFpg>; Thu, 11 Oct 2001 01:45:36 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:32462 "EHLO
	rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S278110AbRJKFpZ>; Thu, 11 Oct 2001 01:45:25 -0400
Date: Thu, 11 Oct 2001 00:45:37 -0500
From: Stephen Crowley <sc462@swbell.net>
Subject: usb problems in 2.4.11
To: linux-kernel@vger.kernel.org
Message-id: <20011011004537.A692@intolerance>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_II+IhaTIpc5XpqWBKCS5Bg)"
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_II+IhaTIpc5XpqWBKCS5Bg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

I'm having some odd usb "raced timeout" problems that just showed up in
2.4.11, it takes considerably longer to initialize the usb controller..
about 15 seconds as opposed to 1-2 seconds in 2.4.10. Everything appears to
function normally once the driver is loaded.

I have provided the dmesg, lsusb and lspci outputs.

-- 
Stephen

--Boundary_(ID_II+IhaTIpc5XpqWBKCS5Bg)
Content-type: text/plain; charset=us-ascii; NAME=lspci.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=lspci.txt

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] (rev 81)
	Subsystem: Asustek Computer, Inc.: Unknown device 802c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f4800000-f5dfffff
	Prefetchable memory behind bridge: f5f00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc.: Unknown device 802c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at f3800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b400 [size=32]

00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs: Unknown device 8061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a800 [disabled] [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f5000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f4800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at f5ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


--Boundary_(ID_II+IhaTIpc5XpqWBKCS5Bg)
Content-type: text/plain; charset=us-ascii; NAME=lsusb.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=lsusb.txt


Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI-alt Root Hub
  iSerial                 1 d000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI-alt Root Hub
  iSerial                 1 d400
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 002: ID 04cc:1122 Philips Semiconductors 
  Language IDs: none (cannot get min. string descriptor; got len=-1, error=32:Broken pipe)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x04cc Philips Semiconductors
  idProduct          0x1122 
  bcdDevice            1.10
  iManufacturer           0 
  iProduct                0 
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
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          1
        bInterval             255
  Language IDs: none (cannot get min. string descriptor; got len=-1, error=32:Broken pipe)

Bus 001 Device 003: ID 046d:c00b Logitech Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech Inc.
  idProduct          0xc00b 
  bcdDevice            6.10
  iManufacturer           1 Logitech
  iProduct                2 USB Mouse
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
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      68
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 004: ID 0403:8401 Future Technology Devices 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0403 Future Technology Devices
  idProduct          0x8401 
  bcdDevice            1.00
  iManufacturer           1 FTDI
  iProduct                2  PS/2 Keyboard And Mouse I/F
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          2
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               90mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              2  PS/2 Keyboard And Mouse I/F
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      63
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     105
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

--Boundary_(ID_II+IhaTIpc5XpqWBKCS5Bg)
Content-type: text/plain; charset=us-ascii; NAME=dmesg.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=dmesg.txt

Linux version 2.4.11-xfs (root@intolerance) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Wed Oct 10 19:34:44 CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=803
Initializing CPU#0
Detected 803.413 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1602.35 BogoMIPS
Memory: 512968k/524208k available (1777k kernel code, 10852k reserved, 411k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf08f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 9 for device 00:0e.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd
devfs: v0.117 (20010927) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with ACLs, EAs, DMAPI, realtime, no debug enabled
parport_pc: Via 686A parallel port disabled in BIOS
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: CR-2801TE, ATAPI CD/DVD-ROM drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: Maxtor 53073U6, ATA DISK drive
hdd: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63
ide-floppy driver 0.97.sv
hdb: 98304kB, 196608 blocks, 512 sector size
hdb: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [14888/64/63] p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Enabling device 00:0e.0 (0000 -> 0001)
PCI: Found IRQ 9 for device 00:0e.0
eth0: RealTek RTL-8029 found at 0xb400, IRQ 9, 00:00:21:48:78:A6.
Linux video capture interface: v1.00
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x3 on pci bus 0 device 13 function 0 irq 11
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MITSUMI   Model: CR-2801TE         Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1212  Rev: 1L10
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym53c875-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100.0 ns, offset 15)
SCSI device sda: 8386733 512-byte hdwr sectors (4294 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 8x/8x writer xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 10 for device 00:04.2
PCI: Sharing IRQ 10 with 00:04.3
uhci.c: USB UHCI at I/O 0xd400, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
usb: raced timeout, pipe 0x80000000 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
hub.c: USB hub found
usb: raced timeout, pipe 0x80000180 status 0 time left 0
hub.c: 2 ports detected
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
PCI: Found IRQ 10 for device 00:04.3
PCI: Sharing IRQ 10 with 00:04.2
uhci.c: USB UHCI at I/O 0xd000, IRQ 10
usb.c: new USB bus registered, assigned bus number 2
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000000 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
hub.c: USB new device connect on bus1/2, assigned device number 2
hub.c: USB hub found
hub.c: 5 ports detected
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
hub.c: USB new device connect on bus1/2/1, assigned device number 3
usb.c: USB device 3 (vend/prod 0x46d/0xc00b) is not claimed by any active driver.
hub.c: USB new device connect on bus1/2/5, assigned device number 4
usb.c: USB device 4 (vend/prod 0x403/0x8401) is not claimed by any active driver.
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
hub.c: USB hub found
usb: raced timeout, pipe 0x80000180 status 0 time left 0
hub.c: 2 ports detected
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
LVM version 0.9.1_beta6  by Heinz Mauelshagen  (12/03/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (4095 buckets, 32760 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
NET4: Linux IPX 0.47 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
Adding Swap: 61840k swap-space (priority -1)
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Trying generic Via routines for device id: 0605
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 0.99 on VIA @ 0xf8000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
Creative EMU10K1 PCI Audio Driver, version 0.16, 19:42:30 Oct 10 2001
PCI: Enabling device 00:10.0 (0004 -> 0005)
PCI: Assigned IRQ 5 for device 00:10.0
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xb000-0xb01f, IRQ 5
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
input1: USB HID v1.00 Keyboard [FTDI  PS/2 Keyboard And Mouse I/F] on usb1:4.0
input2: USB HID v1.00 Mouse [FTDI  PS/2 Keyboard And Mouse I/F] on usb1:4.1
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
mice: PS/2 mouse device common for all mice
usb: raced timeout, pipe 0x80000100 status 0 time left 0
XFS mounting filesystem sd(8,1)
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
eth0: no IPv6 routers present

--Boundary_(ID_II+IhaTIpc5XpqWBKCS5Bg)--
