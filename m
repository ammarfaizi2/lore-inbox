Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTJIVje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTJIVjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:39:33 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:15115 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262593AbTJIVj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:39:29 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <1065735556.794.9.camel@iguana.domsch.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Subject: IBM Thinkpad A21 BIOS - EDD information wrong
Date: Thu, 9 Oct 2003 16:39:11 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 139B0A0C9851283-01-01
Content-Type: text/plain; 
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone here know the IBM Thinkpad A21 BIOS developers?  Their EDD data
is wrong.  They're reporting the disk controller is at PCI device
00:1f.7 when it's really at 00:1f.1, which would confuse any Linux tool
trying to make use of it.

Relevant portions of EDD device data, lspci, and dmidecode appended.  If
you can point me at the proper folks within IBM, I'd appreciate it.
-Matt



/sys/firmware/edd/int13_dev80/raw_data
int13 fn48 returned data:

4a 00 01 00 ff 3f 00 00 10 00 00 00 3f 00 00 00         J...ÿ?......?...
00 53 a8 04 00 00 00 00 00 02 c6 00 40 00 dd be         .Sš.......Æ.@.ÝŸ
2c 00 00 00 50 43 49 20 41 54 41 20 20 20 20 20         ,...PCI ATA     
00 1f 07 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
00 00 00 00 00 00 00 00 00 a1                           .........¡      

Error: BIOS says this is a PCI device, but the OS doesn't know
  about a PCI device at 00:1f.7



00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]



dmidecode:
        BIOS Information
                Vendor: IBM
                Version: 1GET36WW (1.08 )
                Release Date: 07/08/2003
                Address: 0xDC000
                Runtime Size: 144 kB
                ROM Size: 1024 kB
                Characteristics:
                        PCI is supported
                        PC Card (PCMCIA) is supported
                        PNP is supported
                        APM is supported
                        BIOS is upgradeable
                        BIOS shadowing is allowed
                        ESCD support is available
                        Boot from CD is supported
                        Selectable boot is supported
                        Boot from PC Card (PCMCIA) is supported
                        EDD is supported
                        3.5"/720 KB floppy services are supported (int 13h)
                        Print screen service is supported (int 5h)
                        8042 keyboard services are supported (int 9h)
                        Serial services are supported (int 14h)
                        Printer services are supported (int 17h)
                        CGA/mono video services are supported (int 10h)
                        ACPI is supported
                        AGP is supported
                        LS-120 boot is supported
                        BIOS boot specification is supported
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: IBM
                Product Name: 2652D6G
                Version: Not Available
                Serial Number: (removed from customer report)
                UUID: (removed from customer report)
                Wake-up Type: Power Switch
Handle 0x0002
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer: IBM
                Product Name: 2652D6G
                Version: Not Available
                Serial Number: (removed from customer report)


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

