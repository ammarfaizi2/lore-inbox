Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUHIUmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUHIUmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbUHIUlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:41:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:16876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266879AbUHIUgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:36:07 -0400
Date: Mon, 9 Aug 2004 13:14:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Henry Molina <henrymolina@cmn-consulting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EDD Support
Message-Id: <20040809131421.61cfa546.rddunlap@osdl.org>
In-Reply-To: <1092082252.2907.123.camel@prometeo>
References: <1092069811.2907.85.camel@prometeo>
	<20040809093545.5a5e1673.rddunlap@osdl.org>
	<1092073482.2907.88.camel@prometeo>
	<1092082252.2907.123.camel@prometeo>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 15:10:52 -0500 Henry Molina wrote:

| Ok Patrick, but /sys/firmware is not created.
| 
| I using now module-init-tools 3.00-pre10
| 
| modprobe -v -s edd
| insmod /lib/modules/2.6.5-1.358/kernel/drivers/firmware/edd.ko

2.6.5 ??  you said 2.6.7 elsewhere.  Please test a current kernel.

| and /proc/kmsg shows:
| <6>BIOS EDD facility v0.15 2004-May-17, 1 devices found

That's better.


| On Mon, 2004-08-09 at 12:44, Henry Molina wrote:
| > No Randy, no messages, I'm using insmod from BusyBox v1.00-pre10, and
| > lsmod shows the module ok.
| > 
| > On Mon, 2004-08-09 at 11:35, Randy.Dunlap wrote:
| > > On Mon, 09 Aug 2004 11:43:31 -0500 Henry Molina wrote:
| > > 
| > > | Hi everyone,
| > > 
| > > Hi Henry,
| > > 
| > > | I'm compiling kernel 2.6.7 with CONFIG_EDD fine, then I proceed to
| > > | install the module but I can't get the /proc/sys/firmware/edd entry.
| > > | 
| > > | Any Suggestion?.
| > > 
| > > Any kernel log messages when you load the module?
| > > Hint:  there should be.
| > > 
| > > | Many Thanks,
| > > | 
| > > | Henry Molina
| > > | 
| > > | PD: I attach the dmidecode output
| > > | 
| > > | # dmidecode 2.2
| > > | SMBIOS 2.3 present.
| > > | 31 structures occupying 1017 bytes.
| > > | Table at 0x000F0630.
| > > | Handle 0x0000
| > > | 	DMI type 0, 20 bytes.
| > > | 	BIOS Information
| > > | 		Vendor: American Megatrends Inc.
| > > | 		Version: 1.02    
| > > | 		Release Date: 05/09/2003
| > > | 		Address: 0xF0000
| > > | 		Runtime Size: 64 kB
| > > | 		ROM Size: 512 kB
| > > | 		Characteristics:
| > > | 			ISA is supported
| > > | 			PCI is supported
| > > | 			PNP is supported
| > > | 			APM is supported
| > > | 			BIOS is upgradeable
| > > | 			BIOS shadowing is allowed
| > > | 			ESCD support is available
| > > | 			Boot from CD is supported
| > > | 			Selectable boot is supported
| > > | 			BIOS ROM is socketed
| > > | 			EDD is supported
| > > | 			5.25"/360 KB floppy services are supported (int 13h)
| > > | 			5.25"/1.2 MB floppy services are supported (int 13h)
| > > | 			3.5"/720 KB floppy services are supported (int 13h)
| > > | 			3.5"/2.88 MB floppy services are supported (int 13h)
| > > | 			Print screen service is supported (int 5h)
| > > | 			8042 keyboard services are supported (int 9h)
| > > | 			Printer services are supported (int 17h)
| > > | 			CGA/mono video services are supported (int 10h)
| > > | 			ACPI is supported
| > > | 			USB legacy is supported
| > > | 			AGP is supported
| > > | 			LS-120 boot is supported
| > > | 			ATAPI Zip drive boot is supported
| > > | 			BIOS boot specification is supported
| > > | Handle 0x0001
| > > | 	DMI type 1, 25 bytes.
| > > | 	System Information
| > > | 		Manufacturer: Hewlett-Packard
| > > | 		Product Name: HP d220 MT (DC526A)
| > > | 		Version:    
| > > | 		Serial Number: MXD33701GQ
| > > | 		UUID: 15F4C490-59EA-D711-851C-517B4801761B
| > > | 		Wake-up Type: Power Switch
| > > | Handle 0x0002
| > > | 	DMI type 2, 8 bytes.
| > > | 	Base Board Information
| > > | 		Manufacturer: Lite-On Tech.
| > > | 		Product Name: 0888h
| > > | 		Version:    
| > > | 		Serial Number: 01234567
| > > | Handle 0x0003
| > > | 	DMI type 3, 17 bytes.
| > > | 	Chassis Information
| > > | 		Manufacturer: Hewlett-Packard
| > > | 		Type: Desktop
| > > | 		Lock: Not Present
| > > | 		Version:  
| > > | 		Serial Number:  
| > > | 		Asset Tag:  
| > > | 		Boot-up State: Safe
| > > | 		Power Supply State: Safe
| > > | 		Thermal State: Safe
| > > | 		Security Status: None
| > > | 		OEM Information: 0x00000000
| > > | Handle 0x0004
| > > | 	DMI type 4, 32 bytes.
| > > | 	Processor Information
| > > | 		Socket Designation: mPGA-478
| > > | 		Type: Central Processor
| > > | 		Family: Pentium 4
| > > | 		Manufacturer: Intel                                           
| > > | 		ID: 29 0F 41 33 FF FB EB BF
| > > | 		Signature: Type 0, Family 34F, Model 12, Stepping 9
| > > | 		Flags:
| > > | 			FPU (Floating-point unit on-chip)
| > > | 			VME (Virtual mode extension)
| > > | 			DE (Debugging extension)
| > > | 			PSE (Page size extension)
| > > | 			TSC (Time stamp counter)
| > > | 			MSR (Model specific registers)
| > > | 			PAE (Physical address extension)
| > > | 			MCE (Machine check exception)
| > > | 			CX8 (CMPXCHG8 instruction supported)
| > > | 			APIC (On-chip APIC hardware supported)
| > > | 			SEP (Fast system call)
| > > | 			MTRR (Memory type range registers)
| > > | 			PGE (Page global enable)
| > > | 			MCA (Machine check architecture)
| > > | 			CMOV (Conditional move instruction supported)
| > > | 			PAT (Page attribute table)
| > > | 			PSE-36 (36-bit page size extension)
| > > | 			CLFSH (CLFLUSH instruction supported)
| > > | 			DS (Debug store)
| > > | 			ACPI (ACPI supported)
| > > | 			MMX (MMX technology supported)
| > > | 			FXSR (Fast floating-point save and restore)
| > > | 			SSE (Streaming SIMD extensions)
| > > | 			SSE2 (Streaming SIMD extensions 2)
| > > | 			SS (Self-snoop)
| > > | 			HTT (Hyper-threading technology)
| > > | 			TM (Thermal monitor supported)
| > > | 			SBF (Signal break on FERR)
| > > | 		Version: PENTIUM 4                                       
| > > | 		Voltage: 2.9 V
| > > | 		External Clock: 133 MHz
| > > | 		Max Speed: 4000 MHz
| > > | 		Current Speed: 2400 MHz
| > > | 		Status: Populated, Enabled
| > > | 		Upgrade: ZIF Socket
| > > | 		L1 Cache Handle: 0x0005
| > > | 		L2 Cache Handle: 0x0006
| > > | 		L3 Cache Handle: Not Provided
| > > | Handle 0x0005
| > > | 	DMI type 7, 19 bytes.
| > > | 	Cache Information
| > > | 		Socket Designation: Internal Cache
| > > | 		Configuration: Enabled, Not Socketed, Level 1
| > > | 		Operational Mode: Write Back
| > > | 		Location: Internal
| > > | 		Installed Size: 8 KB
| > > | 		Maximum Size: 1024 KB
| > > | 		Supported SRAM Types:
| > > | 			Synchronous
| > > | 		Installed SRAM Type: Pipeline Burst Synchronous
| > > | 		Speed: 40 ns
| > > | 		Error Correction Type: Single-bit ECC
| > > | 		System Type: Data
| > > | 		Associativity: 4-way Set-associative
| > > | Handle 0x0006
| > > | 	DMI type 7, 19 bytes.
| > > | 	Cache Information
| > > | 		Socket Designation: Internal Cache
| > > | 		Configuration: Enabled, Not Socketed, Level 2
| > > | 		Operational Mode: Write Back
| > > | 		Location: Internal
| > > | 		Installed Size: 512 KB
| > > | 		Maximum Size: 1024 KB
| > > | 		Supported SRAM Types:
| > > | 			Synchronous
| > > | 		Installed SRAM Type: Synchronous
| > > | 		Speed: 40 ns
| > > | 		Error Correction Type: Parity
| > > | 		System Type: Unified
| > > | 		Associativity: 8-way Set-associative
| > > | Handle 0x0007
| > > | 	DMI type 5, 20 bytes.
| > > | 	Memory Controller Information
| > > | 		Error Detecting Method: None
| > > | 		Error Correcting Capabilities: None
| > > | 		Supported Interleave: One-way Interleave
| > > | 		Current Interleave: One-way Interleave
| > > | 		Maximum Memory Module Size: 1024 MB
| > > | 		Maximum Total Memory Size: 2048 MB
| > > | 		Supported Speeds:
| > > | 			Other
| > > | 		Supported Memory Types:
| > > | 			DIMM
| > > | 			SDRAM
| > > | 		Memory Module Voltage: 3.3 V
| > > | 		Associated Memory Slots: 2
| > > | 			0x0008
| > > | 			0x0009
| > > | 		Enabled Error Correcting Capabilities: None
| > > | Handle 0x0008
| > > | 	DMI type 6, 12 bytes.
| > > | 	Memory Module Information
| > > | 		Socket Designation: DIMM1
| > > | 		Bank Connections: 1 0
| > > | 		Current Speed: Unknown
| > > | 		Type: DIMM SDRAM
| > > | 		Installed Size: 128 MB (Single-bank Connection)
| > > | 		Enabled Size: 128 MB (Single-bank Connection)
| > > | 		Error Status: OK
| > > | Handle 0x0009
| > > | 	DMI type 6, 12 bytes.
| > > | 	Memory Module Information
| > > | 		Socket Designation: DIMM2
| > > | 		Bank Connections: 3 2
| > > | 		Current Speed: Unknown
| > > | 		Type: Unknown
| > > | 		Installed Size: Not Installed (Single-bank Connection)
| > > | 		Enabled Size: Not Installed (Single-bank Connection)
| > > | 		Error Status: OK
| > > | Handle 0x000A
| > > | 	DMI type 9, 13 bytes.
| > > | 	System Slot Information
| > > | 		Designation: PCI1
| > > | 		Type: 32-bit PCI
| > > | 		Current Usage: Available
| > > | 		Length: Long
| > > | 		ID: 1
| > > | 		Characteristics:
| > > | 			3.3 V is provided
| > > | 			Opening is shared
| > > | 			PME signal is supported
| > > | Handle 0x000B
| > > | 	DMI type 9, 13 bytes.
| > > | 	System Slot Information
| > > | 		Designation: PCI2
| > > | 		Type: 32-bit PCI
| > > | 		Current Usage: Available
| > > | 		Length: Long
| > > | 		ID: 2
| > > | 		Characteristics:
| > > | 			3.3 V is provided
| > > | 			Opening is shared
| > > | 			PME signal is supported
| > > | Handle 0x000C
| > > | 	DMI type 9, 13 bytes.
| > > | 	System Slot Information
| > > | 		Designation: PCI3
| > > | 		Type: 32-bit PCI
| > > | 		Current Usage: Available
| > > | 		Length: Long
| > > | 		ID: 3
| > > | 		Characteristics:
| > > | 			3.3 V is provided
| > > | 			Opening is shared
| > > | 			PME signal is supported
| > > | Handle 0x000D
| > > | 	DMI type 9, 13 bytes.
| > > | 	System Slot Information
| > > | 		Designation: AGP
| > > | 		Type: 32-bit PCI
| > > | 		Current Usage: Available
| > > | 		Length: Long
| > > | 		ID: 1
| > > | 		Characteristics:
| > > | 			3.3 V is provided
| > > | 			Opening is shared
| > > | 			PME signal is supported
| > > | Handle 0x000E
| > > | 	DMI type 11, 5 bytes.
| > > | 	OEM Strings
| > > | 		String 1: SMBIOS Support from AMI
| > > | Handle 0x000F
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: USB0
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: USB1
| > > | 		External Connector Type: Access Bus (USB)
| > > | 		Port Type: USB
| > > | Handle 0x0010
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: USB1
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: USB2
| > > | 		External Connector Type: Access Bus (USB)
| > > | 		Port Type: USB
| > > | Handle 0x0011
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: USB2
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: USB3
| > > | 		External Connector Type: Access Bus (USB)
| > > | 		Port Type: USB
| > > | Handle 0x0012
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: USB3
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: USB4
| > > | 		External Connector Type: Access Bus (USB)
| > > | 		Port Type: USB
| > > | Handle 0x0013
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: USB4
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: USB5
| > > | 		External Connector Type: Access Bus (USB)
| > > | 		Port Type: USB
| > > | Handle 0x0014
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: USB5
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: USB6
| > > | 		External Connector Type: Access Bus (USB)
| > > | 		Port Type: USB
| > > | Handle 0x0015
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: COM1
| > > | 		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
| > > | 		External Reference Designator: COM1
| > > | 		External Connector Type: DB-9 male
| > > | 		Port Type: Serial Port 16550A Compatible
| > > | Handle 0x0016
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: LPT
| > > | 		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
| > > | 		External Reference Designator: LPT
| > > | 		External Connector Type: DB-25 male
| > > | 		Port Type: Parallel Port ECP/EPP
| > > | Handle 0x0017
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: KEYBOARD
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: KEYBOARD
| > > | 		External Connector Type: PS/2
| > > | 		Port Type: Keyboard Port
| > > | Handle 0x0018
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: MOUSE
| > > | 		Internal Connector Type: None
| > > | 		External Reference Designator: MOUSE
| > > | 		External Connector Type: PS/2
| > > | 		Port Type: Mouse Port
| > > | Handle 0x0019
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: Floppy
| > > | 		Internal Connector Type: On Board Floppy
| > > | 		External Reference Designator: Floppy
| > > | 		External Connector Type: None
| > > | 		Port Type: None
| > > | Handle 0x001A
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: Primary IDE
| > > | 		Internal Connector Type: On Board IDE
| > > | 		External Reference Designator: IDE-1
| > > | 		External Connector Type: None
| > > | 		Port Type: None
| > > | Handle 0x001B
| > > | 	DMI type 8, 9 bytes.
| > > | 	Port Connector Information
| > > | 		Internal Reference Designator: Secondary IDE
| > > | 		Internal Connector Type: On Board IDE
| > > | 		External Reference Designator: IDE-2
| > > | 		External Connector Type: None
| > > | 		Port Type: None
| > > | Handle 0x001C
| > > | 	DMI type 12, 5 bytes.
| > > | 	System Configuration Options
| > > | 		Option 1: System Management BIOS from Atlanta
| > > | Handle 0x001D
| > > | 	DMI type 13, 22 bytes.
| > > | 	BIOS Language Information
| > > | 		Installable Languages: 4
| > > | 			English
| > > | 			Traditional Chinese
| > > | 			Simplified Chinese
| > > | 			Japanese
| > > | 		Currently Installed Language: English
| > > | Handle 0x001E
| > > | 	DMI type 127, 4 bytes.
| > > | 	End Of Table


--
~Randy
