Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSLPOtJ>; Mon, 16 Dec 2002 09:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbSLPOtJ>; Mon, 16 Dec 2002 09:49:09 -0500
Received: from [213.171.53.133] ([213.171.53.133]:17678 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S266228AbSLPOtA>;
	Mon, 16 Dec 2002 09:49:00 -0500
Date: Mon, 16 Dec 2002 17:57:50 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <75339285737.20021216175750@wr.miee.ru>
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: [Oops 2.5.51] PnPBIOS: cat /proc/bus/pnp/escd
In-Reply-To: <20021216135813.GD11616@suse.de>
References: <20021215230344.GE1432@squish.home.loc>
 <20021216135813.GD11616@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DJ>  >      'cat /proc/bus/pnp/escd' consistantly produces this:
DJ>  > EIP:    0088:[<00007b74>]    Not tainted

DJ> You blew up in BIOS code. Your BIOS has a crap PNPBIOS implementation.
DJ> Send the output of dmidecode[1] and it can get added to the blacklist.
DJ> [1] http://people.redhat.com/arjanv/dmidecode.c
DJ>                 Dave

Have we got any chance to solve this problem with BIOS update?

Here is results of DMI decode:

SMBIOS 2.3 present.
DMI 2.3 present.
29 structures occupying 978 bytes.
DMI table at 0x000F04F0.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information Block
                Vendor: American Megatrends Inc.
                Version: 62710
                Release: 06/01/2000
                BIOS base: 0xF0000
                ROM size: 192K
                Capabilities:
                        Flags: 0x000000007FCBDE90
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: Gigabyte Technology Co.
                Product: 7IXE4
                Version: 0000000
                Serial Number: 00000000
Handle 0x0002
        DMI type 2, 8 bytes.
        Board Information Block
                Vendor: Gigabyte Technology Co., Ltd.
                Product: 7IXE4
                Version: 1.1
                Serial Number: 00000000
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information Block
                Vendor:                                 
                Chassis Type: Desktop
                Version: 1.0
                Serial Number: 0000000
                Asset Tag:                                 
Handle 0x0004
        DMI type 4, 32 bytes.
        Processor
                Socket Designation: Socket-A
                Processor Type: Central Processor
                Processor Family: K5
                Processor Manufacturer: AMD                             
                Processor Version: Duron(tm)                       
Handle 0x0005
        DMI type 7, 19 bytes.
        Cache
                Socket: Internal
                L1 Internal Cache: write-back
                L1 Cache Size: 128K
                L1 Cache Maximum: 128K
                L1 Cache Type: Synchronous 
Handle 0x0006
        DMI type 7, 19 bytes.
        Cache
                Socket: Internal
                L2 Internal Cache: disabled
                L2 Cache Size: 512K
                L2 Cache Maximum: 64K
                L2 Cache Type: Synchronous 
Handle 0x0007
        DMI type 5, 22 bytes.
        Memory Controller
Handle 0x0008
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM3
                Banks: 0 1
                Type: UNKNOWN 
                Installed Size: Not Installed
                Enabled Size: Not Installed
Handle 0x0009
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM2
                Banks: 2 3
                Type: UNKNOWN 
                Installed Size: Not Installed
                Enabled Size: Not Installed
Handle 0x000A
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM1
                Banks: 4 5
                Speed: 15nS
                Type: DIMM SDRAM 
                Installed Size: 64Mbyte
                Enabled Size: 64Mbyte
Handle 0x000B
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI1
                Type: 32bit PCI 
                Status: In use.
                Slot Features: 3.3v Shared 
Handle 0x000C
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI2
                Type: 32bit PCI 
                Status: Available.
                Slot Features: 3.3v Shared 
Handle 0x000D
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI3
                Type: 32bit PCI 
                Status: Available.
                Slot Features: 3.3v Shared 
Handle 0x000E
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI4
                Type: 32bit PCI 
                Status: In use.
                Slot Features: 3.3v Shared 
Handle 0x000F
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI5
                Type: 32bit PCI 
                Status: Available.
                Slot Features: 3.3v Shared 
Handle 0x0010
        DMI type 9, 13 bytes.
        Card Slot
                Slot: ISA1
                Type: 16bit ISA 
                Slot Features: 3.3v Shared 
Handle 0x0011
        DMI type 9, 13 bytes.
        Card Slot
                Slot: ISA2
                Type: 16bit ISA 
                Slot Features: 3.3v Shared 
Handle 0x0012
        DMI type 9, 13 bytes.
        Card Slot
                Slot: AGP
                Type: 32bit AGP 4x 
                Slot Features: 3.3v Shared 
Handle 0x0013
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: COM Port
                Internal Connector Type: None
                External Designator: Serial Port A
                External Connector Type: DB-9 pin male
                Port Type: Serial Port 16650A Compatible
Handle 0x0014
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: COM Port
                Internal Connector Type: None
                External Designator: Serial Port B
                External Connector Type: DB-9 pin male
                Port Type: Serial Port 16650A Compatible
Handle 0x0015
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: LPT Port
                Internal Connector Type: None
                External Designator: Parallel Port
                External Connector Type: DB-25 pin female
                Port Type: Parallel Port ECP/EPP
Handle 0x0016
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: Keyboard
                Internal Connector Type: None
                External Designator: Keyboard
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x0017
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: Mouse
                Internal Connector Type: None
                External Designator: PS/2 Mouse
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x0018
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: Floppy
                Internal Connector Type: On Board Floppy
                External Designator: Floppy
                External Connector Type: None
                Port Type: None
Handle 0x0019
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: Primary IDE
                Internal Connector Type: On Board IDE
                External Designator: IDE-1
                External Connector Type: None
                Port Type: None
Handle 0x001A
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: Secondary IDE
                Internal Connector Type: On Board IDE
                External Designator: IDE-2
                External Connector Type: None
                Port Type: None
Handle 0x001B
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: USB Port
                Internal Connector Type: None
                External Designator: USB
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x001C
        DMI type 13, 22 bytes.
        BIOS Language Information
Best regards.
             Ruslan.

