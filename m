Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWION2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWION2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWION2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:28:34 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52695 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751414AbWION2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:28:33 -0400
Message-ID: <450AAA73.5050106@bull.net>
Date: Fri, 15 Sep 2006 15:28:19 +0200
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [Bug ??] 2.6.18-rc6-mm2 - PCI ethernet board does not seem to
 work
References: <450A7EC5.2090909@bull.net> <20060915125914.GA1201@lists.us.dell.com>
In-Reply-To: <20060915125914.GA1201@lists.us.dell.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/09/2006 15:34:09,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/09/2006 15:34:13,
	Serialize complete at 15/09/2006 15:34:13
Content-Type: multipart/mixed;
 boundary="------------020108010700030802050708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108010700030802050708
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Matt Domsch a écrit :
> 
> Yes, it's expected, but no, I agree it would be nice to not break
> existing setups.
> 
> Care to send me an output of 'lspci -tv' and dmidecode (the first 80
> or so lines)?

Yes, sure, both are joined in the attached files.

> 
> I think I'll redo this patch to keep the 2.6 depth-first sort order as
> default, with command line options "pci=bfsort" and "pci=nobfsort" to
> force it one way or the other, and DMI table entries for Dell's newest
> systems that should default to bfsort.
> 
> Pierre, thank you for you report and your time to do the bisect.  I
> apologize for any inconvenience this caused you.

Not a problem; I was just curious to understand why my network didn't 
work anymore without really showing any kind of problems...
Next time, I will start by changing my cables before looking at 
/var/log/messages ;-)

-- 
Pierre Peiffer

--------------020108010700030802050708
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.2
SMBIOS 2.3 present.
75 structures occupying 2773 bytes.
Table at 0x000F1260.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: NEC Corporation  
		Version: SBR20.86B.0071.P12.0307291340   
		Release Date: 07/29/2003
		Address: 0xF0000
		Runtime Size: 64 kB
		ROM Size: 1024 kB
		Characteristics:
			PCI is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
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
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: NEC                 
		Product Name: Express5800/120Lg [N8100-864E]          
		Version: FR0.1          
		Serial Number: 80003837009    
		UUID: DC6A4BC3-9F35-D811-0080-EFC03FE90700
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: NEC       
		Product Name: SE7501BR2 
		Version: FRU 0.01       
		Serial Number: KRB535200285   
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: NEC Corporation                
		Type: Tower
		Lock: Not Present
		Version: 856-060342-102         
		Serial Number: 05                             
		Asset Tag: Manza                          
		Boot-up State: Unknown
		Power Supply State: Unknown
		Thermal State: Unknown
		Security Status: Unknown
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: CPU 1
		Type: Central Processor
		Family: Xeon
		Manufacturer: Intel Corporation
		ID: 29 0F 00 00 FF FB EB BF
		Signature: Type 0, Family F, Model 2, Stepping 9
		Flags:
			FPU (Floating-point unit on-chip)

--------------020108010700030802050708
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="lspci-tv.txt"
Content-Disposition: inline;
 filename="lspci-tv.txt"

-[0000:00]-+-00.0  Intel Corporation E7501 Memory Controller Hub
           +-00.1  Intel Corporation E7500/E7501 Host RASUM Controller
           +-03.0-[0000:02-04]--+-1c.0  Intel Corporation 82870P2 P64H2 I/OxAPIC
           |                    +-1d.0-[0000:04]----02.0  Intel Corporation 82544EI Gigabit Ethernet Controller (Copper)
           |                    +-1e.0  Intel Corporation 82870P2 P64H2 I/OxAPIC
           |                    \-1f.0-[0000:03]--+-02.0  Intel Corporation 82544EI Gigabit Ethernet Controller (Copper)
           |                                      \-03.0  Adaptec AIC-7901A U320
           +-03.1  Intel Corporation E7500/E7501 Hub Interface C RASUM Controller
           +-1d.0  Intel Corporation 82801CA/CAM USB (Hub #1)
           +-1d.1  Intel Corporation 82801CA/CAM USB (Hub #2)
           +-1e.0-[0000:01]--+-03.0  Intel Corporation 82557/8/9 [Ethernet Pro 100]
           |                 +-04.0  Intel Corporation 82540EM Gigabit Ethernet Controller
           |                 \-0c.0  ATI Technologies Inc Rage XL
           +-1f.0  Intel Corporation 82801CA LPC Interface Controller
           +-1f.1  Intel Corporation 82801CA Ultra ATA Storage Controller
           \-1f.3  Intel Corporation 82801CA/CAM SMBus Controller

--------------020108010700030802050708--
