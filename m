Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUDVHu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUDVHu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUDVHt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:49:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:1448 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263799AbUDVH0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:26:52 -0400
X-Authenticated: #4512188
Message-ID: <408773B6.4000306@gmx.de>
Date: Thu, 22 Apr 2004 09:26:46 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <200404131117.31306.ross@datscreative.com.au>	 <200404131703.09572.ross@datscreative.com.au>	 <1081893978.2251.653.camel@dhcppc4>	 <200404160110.37573.ross@datscreative.com.au>	 <1082060255.24425.180.camel@dhcppc4>	 <1082063090.4814.20.camel@amilo.bradney.info>	 <1082578957.16334.13.camel@dhcppc4>  <4086E76E.3010608@gmx.de> <1082587298.16336.138.camel@dhcppc4>
In-Reply-To: <1082587298.16336.138.camel@dhcppc4>
Content-Type: multipart/mixed;
 boundary="------------070500070406090407090906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070500070406090407090906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Len Brown wrote:
>>Please send me the output from dmidecode, available in /usr/sbin/, or
>>
>>>here:
>>>http://www.nongnu.org/dmidecode/
>>>or
>>>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> 
> 
> On Wed, 2004-04-21 at 17:28, Prakash K. Cheemplavam wrote:
> 
> 
>>this is the output for Abit NF7-S Rev20 using bios d23. I have NOT 
>>activated APIC for this. Is it needed?
> 
> 
> Yes, you need to enable ACPI and IOAPIC.  The goal of this patch
> is to address the XT-PIC timer issue in IOAPIC mode.

Ok, I recompiled using your (former) patch and Ross' apic tack patch. I 
attached the new dmidecode Text.

> I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> product names (1st line of dmidecode entry) are correct,
> these are not from DMI, but are supposed to be human-readable titles.

Are you referring to (as the first line doesn't say much):

Product Name: NF7-S/NF7,NF7-V (nVidia-nForce2)
Version: 2.X,1.0

Seems pretty much OK, though I don't understand, why 1.0 is in the 
Version string. Durthermore I don't understand, why "Phoenix" appears as 
bios vendor. It should be Award, AFAIK.

> I'm interested only in the latest BIOS -- if it is still broken.

It is the latest (d23). And I guess it is broken, as without your patch 
the timer gets connected to XT-PIC.

> The assumption is that if a fixed BIOS is available, the users
> should upgrade.

Well, I posted in Abit's Forum, but I don't know whether it will have an 
effect.

bye,

Prakash

--------------070500070406090407090906
Content-Type: text/plain;
 name="dmiabitnf7sv2d23apic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmiabitnf7sv2d23apic.txt"

# dmidecode 2.3
SMBIOS 2.2 present.
37 structures occupying 981 bytes.
Table at 0x000F0800.
Handle 0x0000
	DMI type 0, 19 bytes.
	BIOS Information
		Vendor: Phoenix Technologies, LTD
		Version: 6.00 PG
		Release Date: 03/24/2004
		Address: 0xE0000
		Runtime Size: 128 kB
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
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
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer:  
		Product Name:  
		Version:  
		Serial Number:  
		UUID: 00000000-0000-0000-0000-00508DF1FBE3
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: http://www.abit.com.tw/
		Product Name: NF7-S/NF7,NF7-V (nVidia-nForce2)
		Version: 2.X,1.0
		Serial Number:  
Handle 0x0003
	DMI type 3, 13 bytes.
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
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor Information
		Socket Designation: Socket A
		Type: Central Processor
		Family: Athlon
		Manufacturer: AMD
		ID: 81 06 00 00 FF FB 83 03
		Signature: Type 0, Family 6, Model 8, Stepping 1
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
		Current Speed: 2100 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0009
		L2 Cache Handle: 0x000A
		L3 Cache Handle: No L3 Cache
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
			Other
		Supported Memory Types:
			Other
			DIMM
			SDRAM
		Memory Module Voltage: 2.9 V
		Associated Memory Slots: 3
			0x0006
			0x0007
			0x0008
		Enabled Error Correcting Capabilities: None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A0
		Bank Connections: 0 1
		Current Speed: 10 ns
		Type: Other DIMM SDRAM
		Installed Size: 512 MB (Double-bank Connection)
		Enabled Size: 512 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A1
		Bank Connections: None
		Current Speed: 10 ns
		Type: Other DIMM SDRAM
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A2
		Bank Connections: 4 5
		Current Speed: 10 ns
		Type: Other DIMM SDRAM
		Installed Size: 512 MB (Double-bank Connection)
		Enabled Size: 512 MB (Double-bank Connection)
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
		Current Usage: In Use
		Length: Long
		ID: 1
		Characteristics:
			5.0 V is provided
			3.3 V is provided
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
			3.3 V is provided
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
			3.3 V is provided
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
			3.3 V is provided
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
			3.3 V is provided
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
			3.3 V is provided
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
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: A0
		Bank Locator: Bank0/1
		Type: Unknown
		Type Detail: None
Handle 0x001D
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: A1
		Bank Locator: Bank2/3
		Type: Unknown
		Type Detail: None
Handle 0x001E
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: A2
		Bank Locator: Bank4/5
		Type: Unknown
		Type Detail: None
Handle 0x001F
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0003FFFFFFF
		Range Size: 1 GB
		Physical Array Handle: 0x001B
		Partition Width: 0
Handle 0x0020
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x001C
		Memory Array Mapped Address Handle: 0x001F
		Partition Row Position: 1
Handle 0x0021
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x001D
		Memory Array Mapped Address Handle: 0x001F
		Partition Row Position: 1
Handle 0x0022
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00020000000
		Ending Address: 0x0003FFFFFFF
		Range Size: 512 MB
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

--------------070500070406090407090906--
