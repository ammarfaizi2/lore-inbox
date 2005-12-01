Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVLAJhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVLAJhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 04:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVLAJhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 04:37:54 -0500
Received: from mail.dvmed.net ([216.237.124.58]:16322 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932114AbVLAJhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 04:37:53 -0500
Message-ID: <438EC46D.3060301@pobox.com>
Date: Thu, 01 Dec 2005 04:37:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org> <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com> <438EC346.4000102@aitel.hist.no>
In-Reply-To: <438EC346.4000102@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Helge Hafting wrote: > Jeff Garzik wrote: > >> Helge
	Hafting wrote: >> >>> I tried compiling and booting rc1. The machine is
	remote, and did not >>> come up. So I don't know why it didn't come up,
	but it is likely >>> that it is the same problem. >> >> >> >> Any
	chance at all to get netconsole or serial console output, after >>
	turning on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h ?
	> > > Tricky - no other machines around for serial. Maybe I can look
	into > netconsole, and see if it'll work over an internet connection. >
	> The first try will be turning on that debug stuff and writing down
	what > happens. > > The machine have the following block devices: > *
	floppy drive > * IDE dvd writer > * 3 SCSI disks on a scsi controller >
	* 2 SATA disks on the mainboard sata > * USB card reader with 4 SCSI
	LUNs. > > Dmesg stuff from a normal 2.6.14 startup, in case it may be
	of help: > VP_IDE: chipset revision 6 > VP_IDE: not 100% native mode:
	will probe irqs later > VP_IDE: VIA vt8237 (rev 00) IDE UDMA133
	controller on pci0000:00:0f.1 > Probing IDE interface ide0... > hda:
	PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive > ide0 at
	0x1f0-0x1f7,0x3f6 on irq 14 > Losing some ticks... checking if CPU
	frequency changed. > hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB
	Cache, UDMA(33) > Uniform CD-ROM driver Revision: 3.20 > ACPI: PCI
	Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16 > sym0:
	<895> rev 0x1 at pci 0000:00:05.0 irq 16 > sym0: Tekram NVRAM, ID 7,
	Fast-40, LVD, parity checking > sym0: SCSI BUS has been reset. > scsi0
	: sym-2.2.1 > Vendor: FUJITSU Model: MAS3184NP Rev: 0104 > Type:
	Direct-Access ANSI SCSI revision: 03 > target0:0:0: tagged command
	queuing enabled, command queue depth 4. > target0:0:0: Beginning Domain
	Validation > target0:0:0: asynchronous. > target0:0:0: wide
	asynchronous. > target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns,
	offset 31) > target0:0:0: Ending Domain Validation > target0:0:1:
	FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31) > Vendor: IBM Model:
	DDYS-T09170N Rev [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Jeff Garzik wrote:
> 
>> Helge Hafting wrote:
>>
>>> I tried compiling and booting rc1.  The machine is remote, and did not
>>> come up.  So I don't know why it didn't come up, but it is likely
>>> that it is the same problem.
>>
>>
>>
>> Any chance at all to get netconsole or serial console output, after 
>> turning on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h ?
> 
> 
> Tricky - no other machines around for serial.  Maybe I can look into
> netconsole, and see if it'll work over an internet connection.
> 
> The first try will be turning on that debug stuff and writing down what 
> happens.
> 
> The machine have the following block devices:
> * floppy drive
> * IDE dvd writer
> * 3 SCSI disks on a scsi controller
> * 2 SATA disks on the mainboard sata
> * USB card reader with 4  SCSI LUNs.
> 
> Dmesg stuff from a normal 2.6.14 startup, in case it may be of help:
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
> Probing IDE interface ide0...
> hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Losing some ticks... checking if CPU frequency changed.
> hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
> sym0: <895> rev 0x1 at pci 0000:00:05.0 irq 16
> sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.2.1
>  Vendor: FUJITSU   Model: MAS3184NP         Rev: 0104
>  Type:   Direct-Access                      ANSI SCSI revision: 03
> target0:0:0: tagged command queuing enabled, command queue depth 4.
> target0:0:0: Beginning Domain Validation
> target0:0:0: asynchronous.
> target0:0:0: wide asynchronous.
> target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
> target0:0:0: Ending Domain Validation
> target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
>  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
>  Type:   Direct-Access                      ANSI SCSI revision: 03
> target0:0:1: tagged command queuing enabled, command queue depth 4.
> target0:0:1: Beginning Domain Validation
> target0:0:1: asynchronous.
> target0:0:1: wide asynchronous.
> target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
> target0:0:1: Ending Domain Validation
>  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
>  Type:   Direct-Access                      ANSI SCSI revision: 03
> target0:0:6: tagged command queuing enabled, command queue depth 4.
> target0:0:6: Beginning Domain Validation
> target0:0:6: asynchronous.
> target0:0:6: wide asynchronous.
> target0:0:6: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
> target0:0:6: Ending Domain Validation
> libata version 1.12 loaded.
> sata_via version 1.1
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, 
> low) -> IRQACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 
> (level, low) -> IRQ 17
> PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 1
> sata_via(0000:00:0f.0): routed to hard irq line 1

The VIA irq fixup keeps changing, I wonder if this is a cause...

	Jeff



