Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVAJTqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVAJTqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVAJToD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:44:03 -0500
Received: from [195.110.122.101] ([195.110.122.101]:39323 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S262484AbVAJTUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:20:20 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Date: Mon, 10 Jan 2005 20:23:43 +0100
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200501080150.44653.pioppo@ferrara.linux.it> <20050108172020.64999e50.khali@linux-fr.org> <200501082023.54881.pioppo@ferrara.linux.it>
In-Reply-To: <200501082023.54881.pioppo@ferrara.linux.it>
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501102023.44847.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 January 2005 20:23, Simone Piunno wrote:

> > BTW, if you don't have the latest version of your motherboard BIOS
> > already, it could be worth upgrading, just in case it helps (I wouldn't
> > put too much hope there though).

I've upgraded to the newest version available (f10), I have new values in 
dmidecode, but nothing changed on the PWM behaviour.
Here is the new dmidecode output

# dmidecode 2.5
SMBIOS 2.3 present.
37 structures occupying 1064 bytes.
Table at 0x000F0100.
Handle 0x0000
 DMI type 0, 20 bytes.
 BIOS Information
  Vendor: Award Software International, Inc.
  Version: F10
  Release Date: 10/22/2004
  Address: 0xE0000
  Runtime Size: 128 kB
  ROM Size: 256 kB
  Characteristics:
   ISA is supported
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
   BIOS boot specification is supported
Handle 0x0001
 DMI type 1, 25 bytes.
 System Information
  Manufacturer:  
  Product Name:  
  Version:  
  Serial Number:  
  UUID: Not Present
  Wake-up Type: Power Switch
Handle 0x0002
 DMI type 2, 8 bytes.
 Base Board Information
  Manufacturer: Gigabyte Technology Co., Ltd.
  Product Name: K8T800-8237
  Version:  
  Serial Number:  
Handle 0x0003
 DMI type 3, 17 bytes.
 Chassis Information
  Manufacturer:  
  Type: Desktop
  Lock: Not Present
  Version:  
  Serial Number:  
  Asset Tag:  
  Boot-up State: Unknown
  Power Supply State: Unknown
  Thermal State: Unknown
  Security Status: Unknown
  OEM Information: 0x00000000
Handle 0x0004
 DMI type 4, 35 bytes.
 Processor Information
  Socket Designation: Socket 754
  Type: Central Processor
  Family: Athlon
  Manufacturer: AMD
  ID: 48 0F 00 00 FF FB 8B 07
  Signature: Extended Family 0, Model 4, Stepping 8
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
   CLFSH (CLFLUSH instruction supported)
   MMX (MMX technology supported)
   FXSR (Fast floating-point save and restore)
   SSE (Streaming SIMD extensions)
   SSE2 (Streaming SIMD extensions 2)
  Version: AMD Athlon(tm) 64 Processor 3200+
  Voltage: 1.5 V
  External Clock: 200 MHz
  Max Speed: 4000 MHz
  Current Speed: 2000 MHz
  Status: Populated, Enabled
  Upgrade: ZIF Socket
  L1 Cache Handle: 0x0009
  L2 Cache Handle: 0x000A
  L3 Cache Handle: Not Provided
  Serial Number:  
  Asset Tag:  
  Part Number:  
Handle 0x0005
 DMI type 5, 22 bytes.
 Memory Controller Information
  Error Detecting Method: 8-bit Parity
  Error Correcting Capabilities:
   None
  Supported Interleave: One-way Interleave
  Current Interleave: One-way Interleave
  Maximum Memory Module Size: 1024 MB
  Maximum Total Memory Size: 3072 MB
  Supported Speeds:
   70 ns
   60 ns
  Supported Memory Types:
   Standard
   EDO
  Memory Module Voltage: 3.3 V
  Associated Memory Slots: 3
   0x0006
   0x0007
   0x0008
  Enabled Error Correcting Capabilities:
   None
Handle 0x0006
 DMI type 6, 12 bytes.
 Memory Module Information
  Socket Designation: A0
  Bank Connections: 1
  Current Speed: Unknown
  Type: Other
  Installed Size: 2048 MB (Double-bank Connection)
  Enabled Size: 2048 MB (Double-bank Connection)
  Error Status: OK
Handle 0x0007
 DMI type 6, 12 bytes.
 Memory Module Information
  Socket Designation: A1
  Bank Connections: 2
  Current Speed: Unknown
  Type: Other
  Installed Size: 2048 MB (Double-bank Connection)
  Enabled Size: 2048 MB (Double-bank Connection)
  Error Status: OK
Handle 0x0008
 DMI type 6, 12 bytes.
 Memory Module Information
  Socket Designation: ..h.
  Bank Connections: 0 9
  Current Speed: Unknown
  Type: Other
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
  Socket Designation: Internal Cache
  Configuration: Enabled, Not Socketed, Level 1
  Operational Mode: Write Back
  Location: Internal
  Installed Size: 128 KB
  Maximum Size: 128 KB
  Supported SRAM Types:
   Synchronous
  Installed SRAM Type: Synchronous
  Speed: Unknown
  Error Correction Type: Unknown
  System Type: Unknown
  Associativity: Unknown
Handle 0x000A
 DMI type 7, 19 bytes.
 Cache Information
  Socket Designation: External Cache
  Configuration: Enabled, Not Socketed, Level 2
  Operational Mode: Write Back
  Location: Internal
  Installed Size: 1024 KB
  Maximum Size: 1024 KB
  Supported SRAM Types:
   Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000B
	DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: PRIMARY IDE
  Internal Connector Type: On Board IDE
  External Reference Designator:  
  External Connector Type: None
  Port Type: Other
Handle 0x000C
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: SECONDARY IDE
  Internal Connector Type: On Board IDE
  External Reference Designator:  
  External Connector Type: None
  Port Type: Other
Handle 0x000D
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: FDD
  Internal Connector Type: On Board Floppy
  External Reference Designator:  
  External Connector Type: None
  Port Type: 8251 FIFO Compatible
Handle 0x000E
 DMI type 8, 9 bytes.
 Port Connector Information
		Internal Reference Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
  External Reference Designator:  
  External Connector Type: DB-9 male
  Port Type: Serial Port 16450 Compatible
Handle 0x000F
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: COM2
  Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
  External Reference Designator:  
  External Connector Type: DB-9 male
  Port Type: Serial Port 16450 Compatible
Handle 0x0010
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: LPT1
  Internal Connector Type: DB-25 female
  External Reference Designator:  
  External Connector Type: DB-25 female
  Port Type: Parallel Port ECP/EPP
Handle 0x0011
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: Keyboard
  Internal Connector Type: Other
  External Reference Designator:  
  External Connector Type: PS/2
  Port Type: Keyboard Port
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Reference Designator: No Detected
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0013
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: USB
  Internal Connector Type: None
  External Reference Designator:  
  External Connector Type: Access Bus (USB)
  Port Type: USB
Handle 0x0014
 DMI type 9, 13 bytes.
 System Slot Information
  Designation: PCI
  Type: 32-bit PCI
  Current Usage: Available
  Length: Long
  ID: 9
  Characteristics:
   5.0 V is provided
   3.3 V is provided
   PME signal is supported
   SMBus signal is supported
Handle 0x0015
 DMI type 9, 13 bytes.
 System Slot Information
  Designation: PCI
  Type: 32-bit PCI
  Current Usage: Available
  Length: Long
  ID: 10
  Characteristics:
   5.0 V is provided
   3.3 V is provided
   PME signal is supported
   SMBus signal is supported
Handle 0x0016
 DMI type 9, 13 bytes.
 System Slot Information
  Designation: PCI
  Type: 32-bit PCI
  Current Usage: Available
  Length: Long
  ID: 11
  Characteristics:
   5.0 V is provided
   3.3 V is provided
   PME signal is supported
   SMBus signal is supported
Handle 0x0017
 DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI
		Type: 32-bit PCI
		Current Usage: Available
  Length: Long
  ID: 12
  Characteristics:
   5.0 V is provided
   3.3 V is provided
   PME signal is supported
   SMBus signal is supported
Handle 0x0018
 DMI type 9, 13 bytes.
 System Slot Information
  Designation: PCI
  Type: 32-bit PCI
  Current Usage: Available
  Length: Long
  ID: 13
  Characteristics:
   5.0 V is provided
   3.3 V is provided
   PME signal is supported
   SMBus signal is supported
Handle 0x0019
 DMI type 9, 13 bytes.
 System Slot Information
  Designation: AGP
  Type: 32-bit AGP
  Current Usage: In Use
  Length: Long
  ID: 8
  Characteristics:
   5.0 V is provided
Handle 0x001A
 DMI type 13, 22 bytes.
 BIOS Language Information
  Installable Languages: 3
   n|US|iso8859-1
   n|US|iso8859-1
   r|CA|iso8859-1
  Currently Installed Language: n|US|iso8859-1
Handle 0x001B
 DMI type 16, 15 bytes.
 Physical Memory Array
  Location: System Board Or Motherboard
  Use: System Memory
  Error Correction Type: None
  Maximum Capacity: 768 MB
  Error Information Handle: Not Provided
  Number Of Devices: 3
Handle 0x001C
 DMI type 17, 27 bytes.
 Memory Device
  Array Handle: 0x001B
  Error Information Handle: Not Provided
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 2048 MB
  Form Factor: DIMM
  Set: None
  Locator: A0
  Bank Locator: Bank0/1
  Type: Unknown
  Type Detail: None
  Speed: 400 MHz (2.5 ns)
  Manufacturer:  
  Serial Number:  
  Asset Tag:  
  Part Number:  
Handle 0x001D
 DMI type 17, 27 bytes.
 Memory Device
  Array Handle: 0x001B
  Error Information Handle: Not Provided
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 2048 MB
  Form Factor: DIMM
  Set: None
  Locator: A1
  Bank Locator: Bank2/3
  Type: Unknown
  Type Detail: None
  Speed: 400 MHz (2.5 ns)
  Manufacturer:  
  Serial Number:  
  Asset Tag:  
  Part Number:  
Handle 0x001E
 DMI type 17, 27 bytes.
 Memory Device
  Array Handle: 0x001B
  Error Information Handle: Not Provided
  Total Width: 64 bits
  Data Width: 64 bits
  Size: No Module Installed
  Form Factor: DIMM
  Set: None
  Locator: ..h.
  Bank Locator: Bank4/5
  Type: Unknown
  Type Detail: None
  Speed: Unknown
  Manufacturer:  
  Serial Number:  
  Asset Tag:  
  Part Number:  
Handle 0x001F
 DMI type 19, 15 bytes.
 Memory Array Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x000FFFFFFFF
  Range Size: 4 GB
  Physical Array Handle: 0x001B
  Partition Width: 32
Handle 0x0020
 DMI type 20, 19 bytes.
 Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x0007FFFFFFF
  Range Size: 2 GB
  Physical Device Handle: 0x001C
  Memory Array Mapped Address Handle: 0x001F
  Partition Row Position: 1
Handle 0x0021
 DMI type 20, 19 bytes.
 Memory Device Mapped Address
  Starting Address: 0x00080000000
  Ending Address: 0x000FFFFFFFF
  Range Size: 2 GB
  Physical Device Handle: 0x001D
  Memory Array Mapped Address Handle: 0x001F
  Partition Row Position: 1
Handle 0x0022
 DMI type 20, 19 bytes.
 Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x000000003FF
  Range Size: 1 kB
  Physical Device Handle: 0x001E
  Memory Array Mapped Address Handle: 0x001F
  Partition Row Position: 1
Handle 0x0023
 DMI type 32, 11 bytes.
 System Boot Information
  Status: No errors detected
Handle 0x0024
 DMI type 127, 4 bytes.
 End Of Table

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
