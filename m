Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWC2S6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWC2S6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWC2S6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 13:58:22 -0500
Received: from natsluvver.rzone.de ([81.169.145.176]:30892 "EHLO
	natsluvver.rzone.de") by vger.kernel.org with ESMTP
	id S1750792AbWC2S6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 13:58:21 -0500
From: Stefan Rompf <stefan@loplof.de>
To: mitr@volny.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] wistron_btns: Add support for Amilo 7400M
Date: Wed, 29 Mar 2006 20:57:06 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CitKEo+XdRvYlg4"
Message-Id: <200603292057.06364.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_CitKEo+XdRvYlg4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the Amilo 7400M is mostly identical in construction to the Amilo Pro 2000,
so it can be supported by the wistron driver.

Stefan
--- linux-2.6.16/drivers/input/misc/wistron_btns.c.orig	2006-03-23 09:17:56.000000000 +0100
+++ linux-2.6.16/drivers/input/misc/wistron_btns.c	2006-03-23 17:44:08.000000000 +0100
@@ -323,6 +323,15 @@ static struct dmi_system_id dmi_ids[] = 
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Fujitsu-Siemens Amilo M7400",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO M        "),
+		},
+		.driver_data = keymap_fs_amilo_pro_v2000
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Acer Aspire 1500",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),

--Boundary-00=_CitKEo+XdRvYlg4
Content-Type: text/plain;
  charset="us-ascii";
  name="wistron-7400.dmi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wistron-7400.dmi"

# dmidecode 2.6
SMBIOS 2.31 present.
37 structures occupying 1196 bytes.
Table at 0x000D8010.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix Technologies LTD
		Version: R01-S0T   
		Release Date: 05/14/04  
		Address: 0xE2A40
		Runtime Size: 120256 bytes
		ROM Size: 64 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			USB legacy is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: FUJITSU SIEMENS
		Product Name: AMILO M        
		Version: -1             
		Serial Number: 9142DZ101741500A2BKS00        
		UUID: 3DCB0600-8CD5-11D8-B8C2-E9BCE5C7CC97
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: FUJITSU SIEMENS
		Product Name: AMILO M        
		Version: Rev.A          
		Serial Number: 9142DZ101741500A2BKS00        
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: FUJITSU SIEMENS
		Type: Other
		Lock: Not Present
		Version: N/A            
		Serial Number: None           
		Asset Tag:                                 
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: U1
		Type: Central Processor
		Family: Pentium M
		Manufacturer: Intel
		ID: 95 06 00 00 BF F9 E9 A7
		Signature: Type 0, Family 6, Model 9, Stepping 5
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			TM (Thermal monitor supported)
			PBE (Pending break enabled)
		Version: Intel(R) Pentium(R) M processor 1
		Voltage: 3.3 V
		External Clock: Unknown
		Max Speed: 1700 MHz
		Current Speed: 1500 MHz
		Status: Populated, Enabled
		Upgrade: Slot 1
		L1 Cache Handle: 0x0008
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 256 MB
		Maximum Total Memory Size: 512 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types:
			FPM
			EDO
			DIMM
			SDRAM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0006
			0x0007
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: M1
		Bank Connections: 0 1
		Current Speed: Unknown
		Type: DIMM SDRAM
		Installed Size: Not Installed
		Enabled Size: Not Installed
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: M2
		Bank Connections: 2 3
		Current Speed: Unknown
		Type: DIMM SDRAM
		Installed Size: 512 MB (Double-bank Connection)
		Enabled Size: 512 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Asynchronous
		Speed: Unknown
		Error Correction Type: None
		System Type: Other
		Associativity: Other
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 1024 KB
		Maximum Size: 2048 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Single-bit ECC
		System Type: Unified
		Associativity: Other
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J19
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: COM 1
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J23
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J11
		Internal Connector Type: None
		External Reference Designator: Keyboard
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J12
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000E
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot J11
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
Handle 0x000F
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot J12
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
Handle 0x0010
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot J13
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
Handle 0x0011
	DMI type 10, 6 bytes.
	On Board Device Information
		Type: Sound
		Status: Disabled
		Description: ADI
Handle 0x0012
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: This is the Intel Montara
		String 2: System CR Platform
Handle 0x0013
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: Jumper settings can be described here.
Handle 0x0014
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x0015
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0014
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: SODIMM
		Set: 1
		Locator: M1
		Bank Locator: Bank 0
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0016
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0014
		Error Information Handle: No Error
		Total Width: 32 bits
		Data Width: 32 bits
		Size: 512 MB
		Form Factor: SODIMM
		Set: 1
		Locator: M2
		Bank Locator: Bank 1
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0017
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0014
		Partition Width: 0
Handle 0x0018
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x0015
		Memory Array Mapped Address Handle: 0x0017
		Partition Row Position: 1
Handle 0x0019
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x0016
		Memory Array Mapped Address Handle: 0x0017
		Partition Row Position: 1
Handle 0x001A
	DMI type 23, 13 bytes.
	System Reset
		Status: Enabled
		Watchdog Timer: Present
		Boot Option: Do Not Reboot
		Boot Option On Limit: Do Not Reboot
		Reset Count: Unknown
		Reset Limit: Unknown
		Timer Interval: Unknown
		Timeout: Unknown
Handle 0x001B
	DMI type 24, 5 bytes.
	Hardware Security
		Power-On Password Status: Enabled
		Keyboard Password Status: Unknown
		Administrator Password Status: Not Implemented
		Front Panel Reset Status: Unknown
Handle 0x001C
	DMI type 25, 9 bytes.
	System Power Controls
		Next Scheduled Power-on: 12-31 23:59:59
Handle 0x001D
	DMI type 26, 20 bytes.
	Voltage Probe
		Description: Voltage Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x001E
	DMI type 27, 12 bytes.
	Cooling Device
		Temperature Probe Handle: 0x001F
		Type: Fan
		Status: OK
		OEM-specific Information: 0x00000000
Handle 0x001F
	DMI type 28, 20 bytes.
	Temperature Probe
		Description: Temperature Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x0020
	DMI type 29, 20 bytes.
	Electrical Current Probe
		Description: Electrical Current Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x0021
	DMI type 30, 6 bytes.
	Out-of-band Remote Access
		Manufacturer Name: Intel
		Inbound Connection: Enabled
		Outbound Connection: Disabled
Handle 0x0022
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0023
	DMI type 126, 4 bytes.
	Inactive
Handle 0x0024
	DMI type 127, 4 bytes.
	End Of Table

--Boundary-00=_CitKEo+XdRvYlg4--
