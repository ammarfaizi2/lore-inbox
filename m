Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264056AbUDVNwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbUDVNwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUDVNv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:51:59 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:57238 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S264060AbUDVNvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:51:39 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Thu, 22 Apr 2004 15:53:51 +0200
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, Jamie Lokier <jamie@shareable.org>,
       Allen Martin <AMartin@nvidia.com>, ross@datscreative.com.au,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com> <1082606439.16333.188.camel@dhcppc4> <Pine.LNX.4.55.0404221414470.16448@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0404221414470.16448@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v58hAoMdEDzEEYZ"
Message-Id: <200404221553.51585.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_v58hAoMdEDzEEYZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

since its becoming fancy to post dmidecode output, here is mine. my bios 
vendor is MSI (K7N2-Delta) and it has released many BIOS updates for this 
board, but none of them fixes the timer-issue. i only got the timer issue, 
(related with it the already discussed obscure hi-load) no hang with c1 
disconnect enabled. another thing i recently noticed (running 2.6.6-rc2-mm1 
now) is that the last XT-PIC interrupt is gone now. i had cascade on irq2 
routed as XT-PIC before, now cascade (whatever it is) doesnt exist 
anymore ;).

/proc/interrupts now:

  0:   32184529    IO-APIC-edge  timer
  1:       1741    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       9229    IO-APIC-edge  i8042
 14:     107111    IO-APIC-edge  ide0
 15:         92    IO-APIC-edge  ide1
 16:       3138   IO-APIC-level  ide2, saa7134[0]
 17:        153   IO-APIC-level  CMI8738
 19:    2732391   IO-APIC-level  nvidia
 20:    4315754   IO-APIC-level  ohci_hcd, eth0
 21: 1167427697   IO-APIC-level  ehci_hcd
 22:         79   IO-APIC-level  ohci_hcd

another thing that bugs me a little (a little offtopic here maybe), is the 
irq21 of ehci_hcd seems to get hit about twice as often as the timer irq 
although im not at all using USB...   any suggestions? maybe i start a second 
thread on this one...

attached: dmidecode output.

greets, christian.

pls CC on replies.

--Boundary-00=_v58hAoMdEDzEEYZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.txt"

# dmidecode 2.4
SMBIOS 2.3 present.
37 structures occupying 1049 bytes.
Table at 0x000F0000.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix Technologies, LTD
		Version: 6.00 PG
		Release Date: 03/29/2004
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
			Function key-initiated network boot is supported
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
		Manufacturer: MICRO-STAR INTERNATIONAL CO., LTD
		Product Name: MS-6570
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
		Socket Designation: Socket A
		Type: Central Processor
		Family: Duron
		Manufacturer: AMD
		ID: 42 06 00 00 FF FB 83 01
		Signature: Family 6, Model 4, Stepping 2
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
		Version: AMD Athlon(tm)
		Voltage: 1.7 V
		External Clock: 133 MHz
		Max Speed: 2200 MHz
		Current Speed: 1200 MHz
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
		Maximum Memory Module Size: 32 MB
		Maximum Total Memory Size: 96 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types:
			Standard
			EDO
		Memory Module Voltage: 5.0 V
		Associated Memory Slots: 3
			0x0006
			0x0007
			0x0008
		Enabled Error Correcting Capabilities: None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A0
		Bank Connections: None
		Current Speed: 10 ns
		Type: Other
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A1
		Bank Connections: 2
		Current Speed: 10 ns
		Type: Other
		Installed Size: 512 MB (Single-bank Connection)
		Enabled Size: 512 MB (Single-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A2
		Bank Connections: None
		Current Speed: 10 ns
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
		Location: External
		Installed Size: 256 KB
		Maximum Size: 256 KB
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
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FDD
		Internal Connector Type: On Board Floppy
		External Reference Designator: Not Specified
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
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB
		External Connector Type: Other
		Port Type: USB
Handle 0x0014
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI0
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 1
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0015
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI1
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 2
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0016
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI2
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 3
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0017
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI3
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 4
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0018
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI4
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 5
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0019
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: AGP
		Type: 32-bit AGP
		Current Usage: Available
		Length: Long
		ID: 240
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
		Maximum Capacity: 1536 MB
		Error Information Handle: Not Provided
		Number Of Devices: 3
Handle 0x001C
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: A0
		Bank Locator: Bank0/1
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x001D
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: A1
		Bank Locator: Bank2/3
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x001E
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: A2
		Bank Locator: Bank4/5
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x001F
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x001B
		Partition Width: 0
Handle 0x0020
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x001C
		Memory Array Mapped Address Handle: 0x001F
		Partition Row Position: 1
Handle 0x0021
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
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

--Boundary-00=_v58hAoMdEDzEEYZ--
