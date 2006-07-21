Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWGUOa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWGUOa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 10:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGUOa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 10:30:59 -0400
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]:36671 "EHLO
	snowman.cryosphere.shacknet.nu") by vger.kernel.org with ESMTP
	id S1750741AbWGUOa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 10:30:57 -0400
Message-ID: <44C0E510.7000805@gmx.net>
Date: Fri, 21 Jul 2006 16:30:40 +0200
From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060611)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why does nforce pata controller need ide0=ata66  ?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

recently, i added a ata100 pata drive in my "old" box. Without the
ide0=ata66 option, the disk drive won't work with more than udma2 speed
despite its 80c ribbon. It is configured in master mode and is the only
disk on the first controller. Without that option i'm stuck with udma2
transfer rate which is not really acceptable for an actual disk drive!

What puzzles me is the kernel message: ide_setup: ide0=ata66 -- OBSOLETE
OPTION, WILL BE REMOVED SOON!

So, i guess, if the option will be removed soon, it is no more necessary
to worry about it because PATA drives are "end of life" or the option
will certainly (hopefully) be replaced with a new one ;).
 
My questions are:

Would it be a way in the future to make ata66 drives and over work at
their nominal speed when the chipset capabilities are not well
recognized by the kernel driver ?
Have i simply misconfigured anything ?

Thx for your clarifications

Jj

---------------------------------------------------

box: ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1008
Principal options activated: ACPI, lapic, apic

kernel: sys-kernel/vanilla-sources-2.6.18_rc2

# hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
        Model Number:       ST380021A
        Serial Number:      3HV24MXK
        Firmware Revision:  3.19
Standards:
        Supported: 5 4 3 2
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  156301488
        device size with M = 1024*1024:       76319 MBytes
        device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard
        R/W multiple sector transfer: Max = 16  Current = ?
        Recommended acoustic management value: 128, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
                Device Configuration Overlay feature set
           *    Automatic Acoustic Management feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 1
Checksum: correct

# dmidecode

# dmidecode 2.8
SMBIOS 2.2 present.
48 structures occupying 1418 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 19 bytes
BIOS Information
        Vendor: Phoenix Technologies, LTD
        Version: ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1008
        Release Date: 08/04/2004
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 512 kB
        Characteristics:
                PCI is supported
                PNP is supported
                APM is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/360 KB floppy services are supported (int 13h)
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 KB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
        Manufacturer: ASUSTeK Computer INC.
        Product Name: A7N8X2.0
        Version: REV 1.xx
        Serial Number: xxxxxxxxxxx
        UUID: Not Present
        Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: ASUSTeK Computer INC.
        Product Name: A7N8X2.0
        Version: REV 1.xx
        Serial Number: xxxxxxxxxxx

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
        Manufacturer: Chassis Manufactture
        Type: Desktop
        Lock: Not Present
        Version: Chassis Version
        Serial Number: Chassis serial Number
        Asset Tag: Asset-1234567890
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None

Handle 0x0004, DMI type 4, 32 bytes
Processor Information
        Socket Designation: Socket A
        Type: Central Processor
        Family: Athlon XP
        Manufacturer: AMD
        ID: A0 06 00 00 FF FB 83 03
        Signature: Family 6, Model A, Stepping 0
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                MMX (MMX technology supported)
                FXSR (Fast floating-point save and restore)
                SSE (Streaming SIMD extensions)
        Version: AMD Athlon(tm) XP
        Voltage: 1.6 V
        External Clock: 200 MHz
        Max Speed: 3000 MHz
        Current Speed: 2000 MHz
        Status: Populated, Enabled
        Upgrade: ZIF Socket
        L1 Cache Handle: 0x0009
        L2 Cache Handle: 0x000A
        L3 Cache Handle: No L3 Cache

Handle 0x0005, DMI type 5, 22 bytes
Memory Controller Information
        Error Detecting Method: None
        Error Correcting Capabilities:
                Other
        Supported Interleave: Unknown
        Current Interleave: Unknown
        Maximum Memory Module Size: 1024 MB
        Maximum Total Memory Size: 3072 MB
        Supported Speeds:
                70 ns
                60 ns
                50 ns
        Supported Memory Types:
                DIMM
                SDRAM
        Memory Module Voltage: 3.3 V
        Associated Memory Slots: 3
                0x0006
                0x0007
                0x0008
        Enabled Error Correcting Capabilities:
                None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
        Socket Designation: DDR1
        Bank Connections: None
        Current Speed: Unknown
        Type: DIMM
        Installed Size: Not Installed
        Enabled Size: Not Installed
        Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
        Socket Designation: DDR2
        Bank Connections: 2
        Current Speed: Unknown
        Type: DIMM
        Installed Size: 256 MB (Single-bank Connection)
        Enabled Size: 256 MB (Single-bank Connection)
        Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
        Socket Designation: DDR3
        Bank Connections: 4
        Current Speed: Unknown
        Type: DIMM
        Installed Size: 256 MB (Single-bank Connection)
        Enabled Size: 256 MB (Single-bank Connection)
        Error Status: OK

Handle 0x0009, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L1 Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 128 KB
        Maximum Size: 128 KB
        Supported SRAM Types:
                Pipeline Burst
                Synchronous
        Installed SRAM Type: Pipeline Burst Synchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Data
        Associativity: 4-way Set-associative

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Back
        Location: External
        Installed Size: 512 KB
        Maximum Size: 512 KB
        Supported SRAM Types:
                Pipeline Burst
                Synchronous
        Installed SRAM Type: Pipeline Burst Synchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Data
        Associativity: 4-way Set-associative

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: PRIMARY IDE/HDD
        Internal Connector Type: On Board IDE
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: None

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: SECONDARY IDE/HDD
        Internal Connector Type: On Board IDE
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: None

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: FLOPPY
        Internal Connector Type: On Board Floppy
        External Reference Designator: Not Specified
        External Connector Type: None
        Port Type: None

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Serial Port 1
        Internal Connector Type: None
        External Reference Designator: Serial Port 1
        External Connector Type: DB-9 male
        Port Type: Serial Port 16550 Compatible

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Serial Port 2
        Internal Connector Type: None
        External Reference Designator: Serial Port 2
        External Connector Type: DB-9 male
        Port Type: Serial Port 16550 Compatible

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Parallel Port
        Internal Connector Type: None
        External Reference Designator: Parallel Port
        External Connector Type: DB-25 female
        Port Type: Parallel Port ECP/EPP

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: PS/2 Keyboard
        Internal Connector Type: None
        External Reference Designator: PS/2 Keyboard
        External Connector Type: PS/2
        Port Type: Keyboard Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: PS/2 Mouse
        Internal Connector Type: None
        External Reference Designator: PS/2 Mouse
        External Connector Type: PS/2
        Port Type: Mouse Port

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: USB1
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: USB2
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: USB3
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: USB4
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: USB5
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: USB6
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: ETHERNET
        External Connector Type: RJ-45
        Port Type: Network Port

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: ETHERNET
        External Connector Type: RJ-45
        Port Type: Network Port

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: Joystic Port
        External Connector Type: DB-15 female
        Port Type: Joystick Port

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: MIDI Port
        External Connector Type: DB-15 female
        Port Type: MIDI Port

Handle 0x001D, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI1
        Type: 32-bit PCI
        Current Usage: Available
        Length: Short
        ID: 1
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x001E, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI2
        Type: 32-bit PCI
        Current Usage: Available
        Length: Short
        ID: 2
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x001F, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI3
        Type: 32-bit PCI
        Current Usage: Available
        Length: Short
        ID: 3
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0020, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI4
        Type: 32-bit PCI
        Current Usage: Available
        Length: Short
        ID: 4
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0021, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI5
        Type: 32-bit PCI
        Current Usage: Available
        Length: Short
        ID: 5
        Characteristics:
                5.0 V is provided
                3.3 V is provided
                PME signal is supported

Handle 0x0022, DMI type 9, 13 bytes
System Slot Information
        Designation: AGP
        Type: 32-bit AGP
        Current Usage: In Use
        Length: Short
        ID: 6
        Characteristics:
                3.3 V is provided

Handle 0x0023, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: Onboard 1394
        External Connector Type: IEEE 1394
        Port Type: Firewire (IEEE P1394)

Handle 0x0024, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Specified
        Internal Connector Type: None
        External Reference Designator: Line In Jack Port
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x0025, DMI type 13, 22 bytes
BIOS Language Information
        Installable Languages: 3
                n|US|iso8859-1
                n|US|iso8859-1
                r|CA|iso8859-1
        Currently Installed Language: n|US|iso8859-1

Handle 0x0026, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 1536 MB
        Error Information Handle: Not Provided
        Number Of Devices: 3

Handle 0x0027, DMI type 17, 21 bytes
Memory Device
        Array Handle: 0x0026
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: No Module Installed
        Form Factor: DIMM
        Set: None
        Locator: DDR1
        Bank Locator: Bank0/1
        Type: DRAM
        Type Detail: Synchronous

Handle 0x0028, DMI type 17, 21 bytes
Memory Device
        Array Handle: 0x0026
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 256 MB
        Form Factor: DIMM
        Set: None
        Locator: DDR2
        Bank Locator: Bank2/3
        Type: DRAM
        Type Detail: Synchronous

Handle 0x0029, DMI type 17, 21 bytes
Memory Device
        Array Handle: 0x0026
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 256 MB
        Form Factor: DIMM
        Set: None
        Locator: DDR3
        Bank Locator: Bank4/5
        Type: DRAM
        Type Detail: Synchronous

Handle 0x002A, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 512 MB
        Physical Array Handle: 0x0026
        Partition Width: 0

Handle 0x002B, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x000000003FF
        Range Size: 1 kB
        Physical Device Handle: 0x0027
        Memory Array Mapped Address Handle: 0x002A
        Partition Row Position: 1

Handle 0x002C, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0000FFFFFFF
        Range Size: 256 MB
        Physical Device Handle: 0x0028
        Memory Array Mapped Address Handle: 0x002A
        Partition Row Position: 1

Handle 0x002D, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00010000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 256 MB
        Physical Device Handle: 0x0029
        Memory Array Mapped Address Handle: 0x002A
        Partition Row Position: 1

Handle 0x002E, DMI type 32, 11 bytes
System Boot Information
        Status: No errors detected

Handle 0x002F, DMI type 127, 4 bytes
End Of Table


# lspci -vv


00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [40] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x8
        Capabilities: [60] HyperTransport: Host or Secondary Interface
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=0
                Link Config: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Revision ID: 0.16

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
        Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=1 UnitCnt=15 MastHost- DefDir-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC+ TXO-
<CRCErr=0
                Link Config 0: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO+
<CRCErr=0
                Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
                Revision ID: 0.00

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at dc00 [size=32]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at e6087000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 209
        Region 0: Memory at e6082000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 185
        Region 0: Memory at e6083000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
        Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard onboard nForce2
Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at e6086000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at e000 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio
Processing Unit (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
        Subsystem: ASUSTeK Computer Inc. nForce2 AC97 Audio Controler (MCP)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at e400 [size=256]
        Region 1: I/O ports at d000 [size=128]
        Region 2: Memory at e6080000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: 30000000-300fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if
8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: 30100000-301fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- <SERR- <PERR+
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE
1394) Controller (rev a3) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 809a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at e6084000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e6085000 (32-bit, non-prefetchable) [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e2000000-e3ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. SiI 3112 SATARaid Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9c00 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at e5000000 (32-bit, non-prefetchable) [size=512]
        [virtual] Expansion ROM at 30000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast
Ethernet Controller [Tornado] (rev 40)
        Subsystem: ASUSTeK Computer Inc. A7N8X Deluxe onboard 3C920B-EMB
Integrated Fast Ethernet Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at b000 [size=128]
        Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=128]
        [virtual] Expansion ROM at 30100000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 ND
[Radeon 9700 Pro] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited Unknown device 7c00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e3000000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at e2000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon
9700 Pro] (Secondary)
        Subsystem: PC Partner Limited Unknown device 7c01
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled]
[size=128M]
        Region 1: Memory at e3010000 (32-bit, non-prefetchable)
[disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

