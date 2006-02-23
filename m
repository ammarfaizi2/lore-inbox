Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWBWKZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWBWKZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWBWKZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:25:06 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:12701 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751715AbWBWKZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:25:05 -0500
In-Reply-To: <1140654241.8672.25.camel@localhost.localdomain>
References: <B7FF9C61-95ED-4495-971F-D55AAAA2F0F5@bootc.net> <1140654241.8672.25.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2AC65F8C-034E-40FB-98B8-9978A9AE690B@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: PANIC: sata_sil on 2.6.16-rc4-ide1
Date: Thu, 23 Feb 2006 10:24:58 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Feb 2006, at 00:24, Alan Cox wrote:

> On Mer, 2006-02-22 at 23:53 +0000, Chris Boot wrote:
>> Hi all,
>>
>> I upgraded from 2.6.16-rc2-ide2 to 2.6.16-rc4-ide1 and suffered the
>> panic pasted below. Needless to say this all worked fine with the
>> previous kernel (and some). I have two Seagate 250GB drives connected
>> to the controller (a PCI Adaptec 1205SA). I'm testing -ide so I don't
>> have the whole IDE layer just for my rarely used DVD-RW on my VIA  
>> PATA.
>
> Do you see the same crash on 2.6.16-rc4 without the IDE diff ?

Nope, works fine there, except obviously the PATA doesn't! :-)

[4294672.259000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294672.265000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294672.271000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,  
IRQ sharing disabled
[4294672.280000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294672.288000] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294672.295000] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294672.302000] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294672.308000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18  
(level, low) -> IRQ 169
[4294672.317000] ata1: SATA max UDMA/100 cmd 0xF8802080 ctl  
0xF880208A bmdma 0xF8802000 irq 169
[4294672.327000] ata2: SATA max UDMA/100 cmd 0xF88020C0 ctl  
0xF88020CA bmdma 0xF8802008 irq 169
[4294672.538000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[4294672.698000] ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors:  
LBA48
[4294672.705000] ata1: dev 0 configured for UDMA/100
[4294672.711000] scsi0 : sata_sil
[4294672.915000] ata2: SATA link up 1.5 Gbps (SStatus 113)
[4294673.075000] ata2: dev 0 ATA-7, max UDMA/133, 488397168 sectors:  
LBA48
[4294673.082000] ata2: dev 0 configured for UDMA/100
[4294673.088000] scsi1 : sata_sil
[4294673.091000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294673.100000]   Type:   Direct-Access                      ANSI  
SCSI revision: 05
[4294673.109000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294673.118000]   Type:   Direct-Access                      ANSI  
SCSI revision: 05
[4294673.127000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ  
11, using IRQ 20
[4294673.135000] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
[4294673.142000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] - 
 > GSI 20 (level, low) -> IRQ 177
[4294673.153000] PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 1
[4294673.159000] sata_via 0000:00:0f.0: routed to hard irq line 1
[4294673.201000] ata3: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma  
0xC800 irq 177
[4294673.244000] ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma  
0xC808 irq 177
[4294673.488000] ata3: SATA link up 1.5 Gbps (SStatus 113)
[4294673.682000] ata3: dev 0 ATA-7, max UDMA/133, 488397168 sectors:  
LBA48
[4294673.724000] ata3: dev 0 configured for UDMA/133
[4294673.765000] scsi2 : sata_via
[4294674.004000] ata4: SATA link up 1.5 Gbps (SStatus 113)
[4294674.198000] ata4: dev 0 ATA-7, max UDMA/133, 488397168 sectors:  
LBA48
[4294674.240000] ata4: dev 0 configured for UDMA/133
[4294674.281000] scsi3 : sata_via
[4294674.319000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294674.362000]   Type:   Direct-Access                      ANSI  
SCSI revision: 05
[4294674.406000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294674.450000]   Type:   Direct-Access                      ANSI  
SCSI revision: 05

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


