Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264520AbUDVQlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbUDVQlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264552AbUDVQlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:41:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:417 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S264520AbUDVQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:40:08 -0400
Date: Thu, 22 Apr 2004 09:39:58 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Len Brown <len.brown@intel.com>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040422163958.GA1567@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Len Brown <len.brown@intel.com>,
	"Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
	Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
	christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Jamie Lokier <jamie@shareable.org>,
	Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
	a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
References: <200404131117.31306.ross@datscreative.com.au> <200404131703.09572.ross@datscreative.com.au> <1081893978.2251.653.camel@dhcppc4> <200404160110.37573.ross@datscreative.com.au> <1082060255.24425.180.camel@dhcppc4> <1082063090.4814.20.camel@amilo.bradney.info> <1082578957.16334.13.camel@dhcppc4> <4086E76E.3010608@gmx.de> <1082587298.16336.138.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1082587298.16336.138.camel@dhcppc4>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 21, 2004 at 06:41:38PM -0400, Len Brown wrote:
> > Please send me the output from dmidecode, available in /usr/sbin/, or
> 
> I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> product names (1st line of dmidecode entry) are correct,
> these are not from DMI, but are supposed to be human-readable titles.
> 
> I'm interested only in the latest BIOS -- if it is still broken.
> The assumption is that if a fixed BIOS is available, the users
> should upgrade.
> 
> thanks,
> -Len
> 
> ps. latest BIOS on my shuttle has a C1 disconnect enable setting,
> (curiously, it is disabled by default) so I'll try to reproduce the hang
> on it...
> 


On the Shuttle AN35N, the C1 disconnect option default is auto.  If you're
talking about this board, or another board Shuttle seemingly fixed, then I
can tell you that I haven't been able to get my to hang with vanilla kernels.

As for your patch, I get a fast timer, and gain about 1 sec per 5 minutes.
The only patch that seemed to work without a fast timer so far was the one 
removed by Linus in a testing version.  The AN35N has the timer override 
bug.

Attached is the dmidecode for the AN35N.  Note: onboard sound may be disabled.

Jesse


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

# dmidecode 2.4
SMBIOS 2.2 present.
37 structures occupying 937 bytes.
Table at 0x000F0000.
Handle 0x0000
	DMI type 0, 19 bytes.
	BIOS Information
		Vendor: Phoenix Technologies, LTD
		Version: 6.00 PG
		Release Date: 12/05/2003
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
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer:  
		Product Name:  
		Version:  
		Serial Number:  
		UUID: 1297A535-FFFF-FFFF-FFFF-FFFFFFFFFFFF
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Shuttle Inc
		Product Name: AN35 
		Version:  
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
		Family: Duron
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
		External Clock: 166 MHz
		Max Speed: 2000 MHz
		Current Speed: 1916 MHz
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
		Installed Size: 256 MB (Single-bank Connection)
		Enabled Size: 256 MB (Single-bank Connection)
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
		Installed Size: 512 KB
		Maximum Size: 512 KB
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
		External Reference Designator: USB0
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
			PME signal is supported
Handle 0x0015
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI1
		Type: 32-bit PCI
		Current Usage: In Use
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
		Current Usage: Available
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
		Current Usage: Available
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
		Current Usage: In Use
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
	DMI type 17, 21 bytes.
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
Handle 0x001D
	DMI type 17, 21 bytes.
	Memory Device
		Array Handle: 0x001B
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: 256 MB
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
		Size: No Module Installed
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
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
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
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
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

--h31gzZEtNLTqOjlF--
