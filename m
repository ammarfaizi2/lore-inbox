Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbTIPTbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTIPTbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:31:22 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:1034 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S262062AbTIPTbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:31:20 -0400
Message-ID: <3F676502.1000303@bigfoot.com>
Date: Tue, 16 Sep 2003 12:31:14 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-ac3
References: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>	 <3F664FED.4040609@bigfoot.com> <1063718562.10037.5.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063718562.10037.5.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-09-16 at 00:49, Erik Steffl wrote:
> 
>>   does this apply to SATA disks?
> 
> The only SATA devices we support in the core IDE layer are capable of
> doing LBA48 DMA anyway. 
> 
>>   what's the status of support for 137GB+ SATA disks? it required 
>>libata5 patches from Jeff Garzik before (as of 2.4.21-ac4). I see some
> 
> libata is really seperate and for the newer controllers. Its more aimed
> at the latest and upcoming hardware which replaces the SATA controller
> as we know it today (PATA controller hacked up a bit) with stuff that
> looks more like a SCSI controller, with multiple commands, on board
> brains etc. Things like the Promise 2037x are the beginnings of this.

   thanks for the response but I am still confused - I have a disk that 
requires 2.4.21-ac4 + libata5 (from Jeff Garzik), otherwise it does not 
recognize anything above 137GB (it recognizes disk as 250GB but all 
read/write attempts fail).

   2.4.21 vanilla: freezes on boot
   2.4.21-ac4 (SCSI_ATA): read/write above 1376GB fails
   2.4.21-ac4 + libata5: works (libata changes manually merged in)

   is this disk going to work without libata patch?

   MB: intel D865PERL
   Maxtor 250GB SATA disk

   here's what kernel thinks about the disk (from dmesg):

subsystem driver Revision: 1.00
ata_piix version 0.93
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: thread exiting
scsi0 : ata_piix
scsi1 : ata_piix
   Vendor: ATA       Model: Maxtor 6Y250M0    Rev: 0.70
   Type:   Direct-Access                      ANSI SCSI revision: 05
libata version 0.70 loaded.

   TIA,

	erik

