Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTDGXuz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTDGXa1 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:30:27 -0400
Received: from [217.13.198.2] ([217.13.198.2]:39072 "EHLO
	server2.netdiscount.de") by vger.kernel.org with ESMTP
	id S263896AbTDGXQx (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:16:53 -0400
Date: Tue, 8 Apr 2003 01:28:25 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: [Bug] Second PCI bus doesn't work with 2.5.67 (supermicro chipset)
Message-ID: <20030407232825.GA29910@core.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server2.netdiscount.de-17481-1049757903-0001-2"
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server2.netdiscount.de-17481-1049757903-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

the second PCI bus doesn't work with 2.5.67 (the same with .66), but
with 2.4.20 it works.

I  ppended the lspci -vv output with 2.5.67 and 2.4.20, the kernel
messages and a stripped .config.
(the config should be ok, it worked with the same on a dual xeon with
PCI-X)

Are there other details needed?


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>

--=_server2.netdiscount.de-17481-1049757903-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci_2.5.67"

00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, cache line size 08

00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe9c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at fe9fd000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d400 [size=64]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe700000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 51)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]


--=_server2.netdiscount.de-17481-1049757903-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci_2.4.20"

00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, cache line size 08

00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe9c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at fe9fd000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d400 [size=64]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe700000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 51)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]

01:02.0 Network controller: Unknown device 5255:0000
	Subsystem: Unknown device 0001:0000
	Control: I/O- Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (63750ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 26
	Region 0: Memory at fc500000 (64-bit, prefetchable) [size=1M]
	Capabilities: [40] #07 [0002]
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000


--=_server2.netdiscount.de-17481-1049757903-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg_2.5.67"


 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0359 MHz.
..... host bus clock speed is 133.0247 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 32
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030328
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
 dswload-0552: *** Warning: Type override - [DEB_] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [MLIB] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [IO__] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [DATA] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [SIO_] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [SB__] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [ICNT] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [ACPI] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [OSB4] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [PM__] had invalid type (String) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [BIOS] had invalid type (Integer) for Scope operator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [CMOS] had invalid type (Integer) for Scope operator, changed to (Scope)
Parsing all Control Methods:.................................................................................................................................................................................................
Table [DSDT] - 689 Objects with 44 Devices 193 Methods 24 Regions
ACPI Namespace successfully loaded at root c05706fc
IOAPIC[0]: Set PCI routing entry (4-9 -> 0x71 -> IRQ 9)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 4 registers at 0000000000000514 on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x1F
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L10 as GPE number 0x10
evgpeblk-0262 [07] ev_save_method_info   : Registered GPE method _L0B as GPE number 0x0B
evgpeblk-0731 [06] ev_create_gpe_block   : GPE Block: [_GPE] 4 registers at 0000000000000560 on interrupt 9
evgpeblk-0736 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x20 to GPE 0x3F
Executing all Device _STA and_INI methods:............................................
44 Devices found containing: 44 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.............................................................................
Initialized 21/24 Regions 2/2 Fields 40/40 Buffers 14/14 Packages (689 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
pci_link-0256 [10] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [13] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [16] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [19] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [22] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [25] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [30] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [33] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [36] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [41] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [44] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [47] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
pci_link-0256 [50] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0
pci_link-0349 [50] acpi_pci_link_set     : Link disabled
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0
dsopcode-0515 [61] ds_init_buffer_field  : Field size 72 exceeds Buffer size 48 (bits)
 psparse-1121: *** Error: Method execution failed [\_SB_.LNUS._SRS] (Node c14c22c8), AE_AML_BUFFER_LIMIT
pci_link-0338 [50] acpi_pci_link_set     : Error evaluating _SRS
ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
IOAPIC[1]: Set PCI routing entry (5-0 -> 0xa9 -> IRQ 16)
00:00:01[A] -> 5-0 -> IRQ 16
IOAPIC[1]: Set PCI routing entry (5-1 -> 0xb1 -> IRQ 17)
00:00:01[B] -> 5-1 -> IRQ 17
Pin 5-0 already programmed
Pin 5-1 already programmed
IOAPIC[1]: Set PCI routing entry (5-2 -> 0xb9 -> IRQ 18)
00:00:02[A] -> 5-2 -> IRQ 18
IOAPIC[1]: Set PCI routing entry (5-3 -> 0xc1 -> IRQ 19)
00:00:02[B] -> 5-3 -> IRQ 19
Pin 5-2 already programmed
Pin 5-3 already programmed
IOAPIC[1]: Set PCI routing entry (5-4 -> 0xc9 -> IRQ 20)
00:00:03[A] -> 5-4 -> IRQ 20
IOAPIC[1]: Set PCI routing entry (5-5 -> 0xd1 -> IRQ 21)
00:00:03[B] -> 5-5 -> IRQ 21
Pin 5-4 already programmed
Pin 5-5 already programmed
IOAPIC[1]: Set PCI routing entry (5-6 -> 0xd9 -> IRQ 22)
00:00:04[A] -> 5-6 -> IRQ 22
IOAPIC[1]: Set PCI routing entry (5-7 -> 0xe1 -> IRQ 23)
00:00:04[B] -> 5-7 -> IRQ 23
Pin 5-6 already programmed
Pin 5-7 already programmed
IOAPIC[1]: Set PCI routing entry (5-15 -> 0xe9 -> IRQ 31)
00:00:06[A] -> 5-15 -> IRQ 31
IOAPIC[1]: Set PCI routing entry (5-8 -> 0x32 -> IRQ 24)
00:00:01[A] -> 5-8 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (5-9 -> 0x3a -> IRQ 25)
00:00:01[B] -> 5-9 -> IRQ 25
Pin 5-8 already programmed
Pin 5-9 already programmed
IOAPIC[1]: Set PCI routing entry (5-10 -> 0x42 -> IRQ 26)
00:00:02[A] -> 5-10 -> IRQ 26
IOAPIC[1]: Set PCI routing entry (5-11 -> 0x4a -> IRQ 27)
00:00:02[B] -> 5-11 -> IRQ 27
Pin 5-10 already programmed
Pin 5-11 already programmed
IOAPIC[1]: Set PCI routing entry (5-12 -> 0x52 -> IRQ 28)
00:00:03[A] -> 5-12 -> IRQ 28
pci_link-0502 [51] acpi_pci_link_get_irq : Link disabled
 pci_irq-0256 [50] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0295 [50] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:0f.2
ACPI: No IRQ known for interrupt pin A of device 00:0f.2
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux 2.5.67 with no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
acpi_processor-0962 [54] acpi_processor_get_thr: duty_cycle spans bit 4
ACPI: Processor [CPU0] (supports C1)
acpi_processor-0962 [54] acpi_processor_get_thr: duty_cycle spans bit 4
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Maximum main memory to use for agp memory: 374M
agpgart: unable to determine aperture size.
agpgart: Maximum main memory to use for agp memory: 374M
agpgart: unable to determine aperture size.
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
Freeing alive device c1764800, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Copyright (c) 1999-2003 Intel Corporation.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, (U)DMA
 hda: hda1 hda2 < hda5 hda6 hda7 > hda3
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-25
UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte 32768. Assuming open disc. Skipping validity check
UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block 256, tag 454 != 256
UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
found reiserfs format "3.5" with standard journal
Reiserfs journal params: device ide0(3,6), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 140k freed
Adding 112412k swap on /dev/hda7.  Priority:42 extents:1
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
e100: eth0 NIC Link is Up 100 Mbps Full duplex

--=_server2.netdiscount.de-17481-1049757903-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config_2.5.67_stripped"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_HUGETLB_PAGE=y
CONFIG_SMP=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=32
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_EDD=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_INTEL8X0=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y

--=_server2.netdiscount.de-17481-1049757903-0001-2--
