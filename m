Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTIWVXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTIWVXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:23:00 -0400
Received: from host-208-46-192-132.sierradesign.com ([208.46.192.132]:14854
	"HELO mailsrv1.sierradesign.com") by vger.kernel.org with SMTP
	id S263435AbTIWVWs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:22:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steve Snyder <ssnyder@sierradesign.com>
Organization: Sierra Design Group
To: LKML <linux-kernel@vger.kernel.org>
Subject: 23-pre5: "No IRQ known for interrupt pin A..."
Date: Tue, 23 Sep 2003 14:22:23 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200309231422.23666.ssnyder@sierradesign.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am in the process of configuring the kernel for use on my new notebook, 
a Compaq Presario 2570us.  I am running RedHat v9 on this machine, with 
all RH-released updates applied and kernel v2.4.23-pre5.  (I am using the 
very latest kernel code available because Red Hat's latest release, a 
patched v2.4.20, doesn't support all the devices on this machine.)

As the subject says, I am getting this error:

  PCI: No IRQ known for interrupt pin A of device 00:10.0

Below is the output of "lspci -vv" and "dmesg".  Sorry about so much text, 
but with all the ACPI and PCI entries, I'm not certain about what is 
relevant and what isn't.  Device 00:10.0 is shown as being the IDE 
controller, but my IDE hard disk is working fine, and does in fact have 
an IRQ assigned to it.

Can anyone shed some light as to what problem is being reported and what 
can be done about it?

Thanks.

--------------

# cat /proc/interrupts
           CPU0
  0:     444420          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:        622          XT-PIC  acpi
 10:       1785          XT-PIC  ohci1394, usb-uhci, usb-uhci, eth0
 11:          5          XT-PIC  OZ6912 Cardbus Controller, ehci_hcd
 12:          2          XT-PIC  PS/2 Mouse
 14:       3838          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0
ERR:          0

--------------

Linux version 2.4.23-pre5 (root@earth.snydernet.lan) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #5 Tue Sep 23 12:30:01 PDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bf70000 (usable)
 BIOS-e820: 000000001bf70000 - 000000001bf7f000 (ACPI data)
 BIOS-e820: 000000001bf7f000 - 000000001bf80000 (ACPI NVS)
 BIOS-e820: 000000001bf80000 - 000000001c000000 (reserved)
 BIOS-e820: 000000002bf80000 - 000000002c000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
447MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 114544
zone(0): 4096 pages.
zone(1): 110448 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6c80
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bf783e5
ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x1bf7ef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1bf7efd8
ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
Kernel command line: ro root=/dev/hda2 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2392.424 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 450544k/458176k available (1491k kernel code, 7244k reserved, 520k 
data, 76k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030916
PCI: PCI BIOS revision 2.10 entry at 0xfd89b, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs *10)
ACPI: PCI Interrupt Link [LNK3] (IRQs *10)
ACPI: PCI Interrupt Link [LNK4] (IRQs 10)
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 10)
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 10)
ACPI: Embedded Controller [EC0] (gpe 24)
schedule_task(): keventd has not started
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
PCI: No IRQ known for interrupt pin A of device 00:10.0
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (44 C)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Enabling device 00:08.0 (0000 -> 0003)
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (10b9,5457,103c,0850)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
eth0: NatSemi DP8381[56] at 0xdc80e000, 00:0b:cd:a9:a0:b4, IRQ 10.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 380M
agpgart: Unsupported ATI chipset (device id: cbb2), you might want to try 
agp_try_unsupported=1.
agpgart: no supported devices found.
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ALI15X3: IDE controller at PCI slot 00:10.0
PCI: No IRQ known for interrupt pin A of device 00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:pio, hdd:pio
hda: HTS726060M9AT00, ATA DISK drive
blk: queue c0332420, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/7877KiB Cache, CHS=7296/255/63, 
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
SCSI subsystem driver Revision: 1.00
ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 00:0c.0 (0010 -> 0012)
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0005800-d0005fff]  Max 
Packet=[2048]
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:0a.0 (0005 -> 0007)
Intel PCIC probe: not found.
usb.c: registered new driver hub
Yenta IRQ list 00b8, PCI irq11
Socket status: 30000007
PCI: Enabling device 00:0b.2 (0010 -> 0012)
ehci_hcd 00:0b.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:0b.2: irq 11, pci mem dc814000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:0b.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 4 ports detected
host/usb-uhci.c: $Revision: 1.275 $ time 12:33:22 Sep 23 2003
host/usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:0b.0 (0010 -> 0011)
host/usb-uhci.c: USB UHCI at I/O 0x2000, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 00:0b.1 (0010 -> 0011)
host/usb-uhci.c: USB UHCI at I/O 0x2020, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000bcd71a0a96987]
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 76k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 506036k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2312  Rev: 1905
  Type:   CD-ROM                             ANSI SCSI revision: 02
eth0: link up.

--------------

00:00.0 Host bridge: ATI Technologies Inc: Unknown device cbb2 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d0007000 (32-bit, prefetchable) [size=4K]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 7010 (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at d0000000 (32-bit, non-prefetchable) [disabled] 
[size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if 00 
[Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1400 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Network controller: Broadcom Corporation: Unknown device 4320 (rev 
02)
	Subsystem: Compaq Computer Corporation: Unknown device 00e7
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0002000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0004000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: d0200000-d02ff000 (prefetchable)
	Memory window 1: d0100000-d01ff000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 2000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 2020 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 
20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 20
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at d0005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 
Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0005800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0008000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 2040 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at d0006000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M 
(prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d0300000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--------------

end of output




