Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272528AbRIPQvs>; Sun, 16 Sep 2001 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272537AbRIPQvk>; Sun, 16 Sep 2001 12:51:40 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:39438 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S272528AbRIPQve>;
	Sun, 16 Sep 2001 12:51:34 -0400
Date: Sun, 16 Sep 2001 13:52:36 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <E15icMH-0005H3-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0109161350370.20722-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Alan Cox wrote:

> > > to 0x89 and it happilly lives... So maybe some BIOS vendors
> > > used KT133 instead of KT133A BIOS image?
> > 
> > Same here ...
> 
> One way to test this hypthesis maybe to run dmidecode on the machines and
> see if they report KT133 or KT133A. Its also possible some BIOS code does
> blindly program bit 7 even tho its reserved and should have been kept
> unchanged.

I'm not sure if this is the output you are talking about (I see no KT133
strings on it) but here it goes (this motherboard uses KT133A and
exhibits the bug):

SMBIOS 2.3 present.
DMI 2.3 present.
40 structures occupying 1181 bytes.
DMI table at 0x000F0800.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: Award Software International, Inc.
		Version: 6.00 PG
		Release: 07/05/2001
		BIOS base: 0xE0000
		ROM size: 192K
		Capabilities:
			Flags: 0x000000007FCBDE90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: VIA Technologies, Inc.
		Product: VT8363
		Version:  
		Serial Number:  
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor:  <http://www.abit.com.tw>
		Product: 8363-686A(KT7,KT7A,KT7A-RAID,KT7E)
		Version:  
		Serial Number:  
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor:  
		Chassis Type: Desktop
		Version:  
		Serial Number:  
		Asset Tag:  
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor
		Socket Designation: Socket A
		Processor Type: Central Processor
		Processor Family: M1
		Processor Manufacturer: AMD
		Processor Version: AMD Duron(tm)
		Serial Number:  
		Asset Tag:  
		Vendor Part Number:  
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_0
		Banks: 0 1
		Speed: 60nS
		Type: 
		Installed Size: 64Mbyte
		Enabled Size: 64Mbyte
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_1
		Banks: 2 3
		Speed: 60nS
		Type: 
		Installed Size: 64Mbyte
		Enabled Size: 64Mbyte
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: BANK_2
		Banks: 4 5
		Speed: 60nS
		Type: UNKNOWN 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000A
	DMI type 7, 19 bytes.
	Cache
		Socket: Internal Cache
		L1 Internal Cache: write-back
		L1 Cache Size: 128K
		L1 Cache Maximum: 128K
		L1 Cache Type: Synchronous 
Handle 0x000B
	DMI type 7, 19 bytes.
	Cache
		Socket: External Cache
		L2 External Cache: write-back
		L2 Cache Size: 64K
		L2 Cache Maximum: 64K
		L2 Cache Type: Synchronous 
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Designator:  
		External Connector Type: None
		Port Type: Other
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Designator:  
		External Connector Type: None
		Port Type: Other
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: FDD
		Internal Connector Type: On Board Floppy
		External Designator:  
		External Connector Type: None
		Port Type: „(­û
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator:  
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16450 Compatible
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator:  
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16450 Compatible
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: LPT1
		Internal Connector Type: DB-25 pin female
		External Designator:  
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port ECP/EPP
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Keyboard
		Internal Connector Type: Other
		External Designator:  
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Designator: No Detected
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0014
	DMI type 9, 13 bytes.
	Card Slot
		Slot: ISA
		Type: 16bit ISA 
		Slot Features: 5v 
Handle 0x0015
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x0016
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x0017
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x0018
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x0019
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 5v 
Handle 0x001A
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 5v 
Handle 0x001B
	DMI type 10, 8 bytes.
	On Board Devices Information
		Description:   : Enabled
		Type: 
		Description:   : Enabled
		Type: 
Handle 0x001C
	DMI type 9, 13 bytes.
	Card Slot
		Slot: AGP
		Type: 32bit AGP 2x 
		Status: Available.
		Slot Features: 5v 
Handle 0x001D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: USB
		Internal Connector Type: None
		External Designator:  
		External Connector Type: Other
		Port Type: USB
Handle 0x001E
	DMI type 13, 22 bytes.
	BIOS Language Information
Handle 0x001F
	DMI type 16, 15 bytes.
	Physical Memory Array
Handle 0x0020
	DMI type 17, 27 bytes.
	Memory Device
Handle 0x0403
	DMI type 0, 0 bytes.
	BIOS Information Block
		Vendor: NoneNoneNoneNone
		Version: "
		Release: 
		BIOS base: 0x41420
		ROM size: 4800K
		Capabilities:
			Flags: 0x326B6E614200315F
Handle 0x0605
	DMI type 3, 4 bytes.
	Chassis Information Block
		Vendor: 
		Chassis Type: 
		Version: 
		Serial Number: 
		Asset Tag: 
Handle 0x0201
	DMI type 9, 0 bytes.
	Card Slot
		Slot: 
		Type: 
		Slot Features: 3.3v 
Handle 0x0403
	DMI type 0, 0 bytes.
	BIOS Information Block
		Vendor: NoneNoneNoneNone
		Version: $
		Release: 
		BIOS base: 0x41420
		ROM size: 4800K
		Capabilities:
			Flags: 0x346B6E614200325F
Handle 0x0605
	DMI type 3, 4 bytes.
	Chassis Information Block
		Vendor: 
		Chassis Type: 
		Version: 
		Serial Number: 
		Asset Tag: 
Handle 0xFF00
	DMI type 0, 0 bytes.
	BIOS Information Block
		Vendor: 
		Version: 
		Release: 
		BIOS base: 0x1F000
		ROM size: 64K
		Capabilities:
			Flags: 0x0000251314000020
Handle 0x01FF
	DMI type 0, 255 bytes.
	BIOS Information Block
		Vendor: 
		Version: 
		Release: 
		BIOS base: 0x01000
		ROM size: 0K
		Capabilities:
			Flags: 0x0000000025131400
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information Block
		Vendor: 
		Version: 
		Release: 
		BIOS base: 0x00000
		ROM size: 0K
		Capabilities:
			Flags: 0x0000000000000000
Handle 0x0000
	DMI type 0, 0 bytes.
	BIOS Information Block
		Vendor: 
		Version: 
		Release: 
		BIOS base: 0x00000
		ROM size: 0K
		Capabilities:
			Flags: 0x0000000000000000

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

