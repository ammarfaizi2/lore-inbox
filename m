Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTEZTb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTEZTb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:31:58 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:50023 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262163AbTEZTbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:31:49 -0400
Subject: Re: APIC on Dell Laptops - WAS: Re: [RFC] Fix NMI watchdog
	documentation
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <16082.24332.881881.965677@gargle.gargle.HOWL>
References: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
	 <1053967225.5948.12.camel@slappy>
	 <16082.24332.881881.965677@gargle.gargle.HOWL>
Content-Type: multipart/mixed; boundary="=-wyQ/aEHpEgfBnmFrCp00"
Organization: 
Message-Id: <1053978298.6152.25.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 15:44:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wyQ/aEHpEgfBnmFrCp00
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-05-26 at 14:38, mikpe@csd.uu.se wrote:
> Disconnect writes:
>  > Local APIC disabled by BIOS -- reenabling.
>  > Found and enabled local APIC!
>  > 
>  > And now /proc/cpuinfo and cpuid both show APIC support.
>  > 
>  > Removed/replaced power, triggered lid-switch/battery-status/etc with no
>  > issues.  (The only thing that caused trouble was Fn-F10, the "eject cd"
>  > button.  Never tried it under Linux before, and the cd isn't in it at
>  > the moment anyway, so I'm betting thats unrelated. But it did cause a
>  > lockup that even sysrq couldn't recover.)
> 
> Nice.

>  > Not 100% clear on what the APIC does, but I'm not sure its doing it ;) 
>  > 
>  > PCI: Using ACPI for IRQ routing <-- shouldn't this be missing if the
>  > APIC is in use?
> 
> Nope. local APIC != I/O APIC. Disable ACPI, or enable IO_APIC (and hope it's there).

I'm betting it doesn't have an IO-APIC (its a laptop, no SMP, etc) ..
any way to tell if the APIC is working/enabled?  (For that matter, all
google could tell me about was the IO-APIC, which is handy to know but
not particularly helpful here.)

>  > (Full dmesg attached, for those who are curious - the unknown-scancode
>  > is for the various laptop buttons - bright/dim, vol, media, battery,
>  > etc.  Except for the volume buttons the only ones that work are the ones
>  > that directly hit the hardware, ala bright/dim.)
>  > 
>  > Also, for others with an I8500 who might read the dmesg log, don't get
> 
> dmidecode data would be nice, for the whitelist rules.

Attached (I pulled out the service tag and express service code, both of
which are local to the individual device.)

Also, not sure what (if anything) would be different with the A01 bios;
their changelog seems to focus mostly on fixing a sound bug (which,
unfortunately, I didn't have until -after- the fix... sigh.)

Their changelog is online ( support.dell.com 'small business' ->
'Inspiron 8500' -> 'FlashBIOS updates') but there's not much to it.

-- 
Disconnect <lkml@sigkill.net>

--=-wyQ/aEHpEgfBnmFrCp00
Content-Disposition: inline; filename=dmidecode.txt
Content-Type: text/plain; name=dmidecode.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# dmidecode 1.8
SYSID present.
	Revision: 0
1 structure.
SYSID table at 0x000F8CD1.
SMBIOS 2.3 present.
DMI 2.3 present.
59 structures occupying 2398 bytes.
DMI table at 0x000F8D10.
Handle 0xDA00
	DMI type 218, 101 bytes.
	b2 00 0d 1f 0f 17 40 7d 00 00 00 00 00 7e 00 02 	......@}.....~..
	00 00 00 40 00 04 00 01 00 41 00 04 00 00 00 90 	...@.....A......
	00 05 00 00 00 91 00 05 00 01 00 92 00 05 00 02 	................
	00 00 80 00 80 01 00 00 a0 00 a0 01 00 05 80 05 	................
	80 01 00 01 f0 01 f0 00 00 02 f0 02 f0 00 00 03 	................
	f0 03 f0 00 00 04 f0 04 f0 00 00 ff ff 00 00 00 	................
	00                                              	.               
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: Dell Computer Corporation
		Version: A02
		Release: 04/29/2003
		BIOS base: 0xF0000
		ROM size: 512K
		Capabilities:
			Flags: 0x001700007D019F90
Handle 0x0100
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: Dell Computer Corporation
		Product: Inspiron 8500                   
		Version: 
		Serial Number: [removed svc tag]
Handle 0x0200
	DMI type 2, 9 bytes.
	Board Information Block
		Vendor: Dell Computer Corporation
		Product: 00U838
		Version:    
		Serial Number: .[removed svc tag].[removed express svc code].
Handle 0x0300
	DMI type 3, 13 bytes.
	Chassis Information Block
		Vendor: Dell Computer Corporation
		Chassis Type: Portable
		Version: 
		Serial Number: [removed svc tag]
		Asset Tag: 
Handle 0x0301
	DMI type 126, 13 bytes.
	Inactive
Handle 0x0400
	DMI type 4, 32 bytes.
	Processor
		Socket Designation: Microprocessor
		Processor Type: Central Processor
		Processor Family: 
		Processor Manufacturer: Intel
		Processor Version: 
Handle 0x0700
	DMI type 7, 19 bytes.
	Cache
		Socket: 
		L1 Internal Cache: write-back
		L1 Cache Size: 8K
		L1 Cache Maximum: 8K
		L1 Cache Type: Unknown 
Handle 0x0701
	DMI type 7, 19 bytes.
	Cache
		Socket: 
		L2 Internal Cache: 
		L2 Cache Size: 512K
		L2 Cache Maximum: 512K
		L2 Cache Type: Pipeline burst 
Handle 0x0800
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PARALLEL
		Internal Connector Type: None
		External Designator: 
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port PS/2
Handle 0x0801
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SERIAL1
		Internal Connector Type: None
		External Designator: 
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16550A Compatible
Handle 0x0803
	DMI type 126, 9 bytes.
	Inactive
Handle 0x0804
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: USB
		Internal Connector Type: None
		External Designator: 
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0805
	DMI type 126, 9 bytes.
	Inactive
Handle 0x0806
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: MONITOR
		Internal Connector Type: None
		External Designator: 
		External Connector Type: DB-15 pin female
		Port Type: Video Port
Handle 0x0808
	DMI type 126, 9 bytes.
	Inactive
Handle 0x0809
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: IrDA
		Internal Connector Type: None
		External Designator: 
		External Connector Type: Infrared
		Port Type: Other
Handle 0x080A
	DMI type 126, 9 bytes.
	Inactive
Handle 0x080B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: FireWire
		Internal Connector Type: None
		External Designator: 
		External Connector Type: 1394
		Port Type: FireWire (IEEE P1394)
Handle 0x080C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Modem
		Internal Connector Type: None
		External Designator: 
		External Connector Type: RJ-11
		Port Type: Modem Port
Handle 0x080D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Ethernet
		Internal Connector Type: None
		External Designator: 
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x0900
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCMCIA 0
		Type: 32bit PCMCIA 
		Status: Available.
		Slot Features: 5v 3.3v PCCard16 CardBus Zoom-Video ModemRingResume 
Handle 0x0902
	DMI type 126, 13 bytes.
	Inactive
Handle 0x0904
	DMI type 9, 13 bytes.
	Card Slot
		Slot: MiniPCI
		Type: 32bit 
		Status: Available.
		Slot Features: 5v 3.3v 
Handle 0x0A00
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: ATI Radeon 9000 : Enabled
		Type: Video
Handle 0x0A01
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: Sigmatel 9750 : Enabled
		Type: Sound
Handle 0x0B00
	DMI type 11, 5 bytes.
	OEM Data
		Dell System
		5[0015]
Handle 0x0D00
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			en|US|iso8859-1
		Currently Installed Language: en|US|iso8859-1
Handle 0x1000
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System board or motherboard
		Use: System memory
		Error Correction Type: None
		Maximum Capacity: 1048576 kB
		Error Information Handle: Not Provided
		Number of Devices: 2
Handle 0x1100
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x1000
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 Mbyte
		Form Factor: DIMM
		Locator: DIMM_A
		Bank Locator: 
		Type: DDR
		Type Detail: Synchronous 
		Speed: 266 MHz (3.8 ns)
		Manufacturer: 
		Serial Number: 
		Asset Tag: 
		Part Number:                 
Handle 0x1101
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x1000
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 Mbyte
		Form Factor: DIMM
		Locator: DIMM_B
		Bank Locator: 
		Type: DDR
		Type Detail: Synchronous 
		Speed: 266 MHz (3.8 ns)
		Manufacturer: 
		Serial Number: 
		Asset Tag: 
		Part Number:                 
Handle 0x1300
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x1301
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x1400
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x1401
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x1402
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x1500
	DMI type 21, 7 bytes.
	Built-In Pointing Device
Handle 0x1600
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Sys. Battery Bay
		Manufacturer: Sony Corp.      
		Manufacture Date: 
		Serial Number: 
		Name: DELL 0005P14    
Handle 0x1601
	DMI type 126, 26 bytes.
	Inactive
Handle 0x1602
	DMI type 126, 26 bytes.
	Inactive
Handle 0x1B00
	DMI type 27, 12 bytes.
	Cooling Device
		Device Type: Fan
		Device Status: OK
Handle 0x1C00
	DMI type 28, 20 bytes.
	Temperature Sensor
		Description: CPU Internal Temperature
		Device Location: Processor
		Device Status: OK
		Maximum Value: 127.0
		Minimum Value: 0.0
		Resolution:    100.0
		Tolerance:     0.5
		Accuracy:      Unknown
Handle 0x1F00
	DMI type 31, 28 bytes.
	Boot Integrity Services Entry Point
Handle 0x2000
	DMI type 32, 11 bytes.
	System Boot Information
Handle 0xD000
	DMI type 208, 10 bytes.
	01 04 fe 00 3e 01                               	....>.          
Handle 0xD100
	DMI type 209, 12 bytes.
	00 00 00 03 04 07 80 05                         	........        
Handle 0xD200
	DMI type 210, 12 bytes.
	f8 03 04 03 06 80 04 05                         	........        
Handle 0xD300
	DMI type 211, 13 bytes.
	01 03 02 01 00 00 00 00 02                      	.........       
Handle 0xD800
	DMI type 216, 9 bytes.
	01 03 01 f0 03                                  	.....           
Handle 0xD900
	DMI type 217, 8 bytes.
	01 02 01 03                                     	....            
Handle 0xDB00
	DMI type 219, 8 bytes.
	03 01 02 03                                     	....            
Handle 0xDB80
	DMI type 126, 8 bytes.
	Inactive
Handle 0xDB81
	DMI type 126, 8 bytes.
	Inactive
Handle 0xDC00
	DMI type 220, 22 bytes.
	01 f0 00 00 02 f0 00 00 00 00 03 f0 04 f0 00 00 	................
	00 00                                           	..              
Handle 0xDD00
	DMI type 221, 19 bytes.
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    	............... 
Handle 0xD400
	DMI type 212, 227 bytes.
	70 00 71 00 00 10 2d 2e 5c 00 78 bf 40 5d 00 78 	p.q...-.\.x.@].x
	bf 00 5e 00 23 fe 01 5f 00 23 fe 00 65 00 21 f7 	..^.#.._.#..e.!.
	00 66 00 21 f7 08 f1 00 21 fc 00 f2 00 21 fc 01 	.f.!....!....!..
	f3 00 21 fc 02 0f 00 26 f8 00 11 00 26 f8 01 05 	..!....&....&...
	00 26 f8 02 12 00 26 f8 03 06 00 26 f8 04 31 00 	.&....&....&..1.
	26 8f 00 32 00 26 8f 10 33 00 26 8f 20 34 00 26 	&..2.&..3.&. 4.&
	8f 30 35 00 26 8f 40 07 00 25 f8 00 0b 00 25 f8 	.05.&.@..%....%.
	01 0c 00 25 f8 02 0d 00 25 f8 04 28 00 23 f3 00 	...%....%..(.#..
	29 00 23 f3 04 2a 00 23 f3 08 2b 00 58 00 00 2c 	).#..*.#..+.X..,
	00 59 00 00 e7 00 1d f3 04 e6 00 1d f3 00 0e 01 	.Y..............
	23 fd 00 0f 01 23 fd 02 9b 00 23 ef 10 9c 00 23 	#....#....#....#
	ef 00 87 00 11 fd 02 88 00 11 fd 00 e8 00 23 df 	..............#.
	00 e9 00 23 df 20 12 01 34 fb 04 13 01 34 fb 00 	...#. ..4....4..
	08 00 1d df 00 03 00 1d df 00 ff ff 00 00 00    	............... 
Handle 0xD401
	DMI type 212, 132 bytes.
	70 00 71 00 03 40 49 4a 42 00 48 7f 80 43 00 48 	p.q..@IJB.H..C.H
	7f 00 55 00 47 bf 00 6d 00 47 bf 40 0c 01 46 fb 	..U.G..m.G.@..F.
	04 0d 01 46 fb 00 14 01 46 e7 00 15 01 46 e7 08 	...F....F....F..
	16 01 46 e7 10 0a 01 48 ef 10 0b 01 48 ef 00 2d 	..F....H....H..-
	00 48 df 20 2e 00 48 df 00 a8 00 48 fc 01 a9 00 	.H. ..H....H....
	48 fc 00 b2 00 48 fc 02 11 01 48 bf 00 10 01 48 	H....H....H....H
	bf 40 f0 00 46 3f 20 ed 00 46 3f 00 ea 00 67 f3 	.@..F? ..F?...g.
	00 eb 00 67 f3 04 ec 00 67 f3 08 ff ff 00 00 00 	...g....g.......
Handle 0xDE00
	DMI type 222, 13 bytes.
	01 02 ff ff 00 00 00 00 00                      	.........       
Handle 0x7F00
	DMI type 127, 4 bytes.
	End-of-Table
PCI Interrupt Routing 1.0 present.
	Table Size: 176 bytes
	Router ID: 00:1f.0
	Exclusive IRQs: None
	Compatible Router: 8086:1234
ACPI 1.0 present.
	OEM ID: DELL  
RSD table at 0x1FFF0000.
PNP 1.0 present.
	Event Notification: Polling
	Event Notification Flag Address: 0x000004B4
	Real Mode Code Address: F000:E2F1
	Real Mode Data Address: 0040:0000
	Protected Mode Code Address: 0x000FE2F4
	Protected Mode Data Address: 0x00000040
BIOS32 Service Directory present.
	Calling Interface Address: 0x000FFE90

--=-wyQ/aEHpEgfBnmFrCp00--

