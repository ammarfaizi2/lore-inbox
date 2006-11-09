Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161832AbWKIUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161832AbWKIUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965737AbWKIUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:31:58 -0500
Received: from smtpauth02.prod.mesa1.secureserver.net ([64.202.165.182]:59885
	"HELO smtpauth02.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965546AbWKIUb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:31:57 -0500
Message-ID: <4553903B.4010908@seclark.us>
Date: Thu, 09 Nov 2006 15:31:55 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Abysmal PATA IDE performance
References: <20061109202319.GA13940@dreamland.darkstar.lan>
In-Reply-To: <20061109202319.GA13940@dreamland.darkstar.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti wrote:

>Stephen Clark <Stephen.Clark@seclark.us> ha scritto:
>  
>
>>Looking at the dmesg output I am a little confused, see comments below:
>>partial dmesg output follows:
>>
>>SCSI subsystem initialized
>>libata version 2.00 loaded.
>>ata_piix 0000:00:1f.2: version 2.00
>>ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
>>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
>>PCI: Setting latency timer of device 0000:00:1f.2 to 64
>>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
>>scsi0 : ata_piix
>>Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
>>input: SynPS/2 Synaptics TouchPad as /class/input/input1
>>ATA: abnormal status 0x7F on port 0x1F7
>>ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
>>scsi1 : ata_piix
>>ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
>>ata2.00: ata2: dev 0 multi count 16
>>usb 2-2: new low speed USB device using uhci_hcd and address 3
>>ata2.01: ATAPI, max UDMA/33
>>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
>>===============****
>>    
>>
>
>This is your optical (CD/DVD) unit; I doubt that you can saturate that
>link, even if your drive can do a sustained 16x transfer with a DVD it
>will use only 21MBps. Your HD is using UDMA/100.
>
>Forcing the interface to a higher speed may lead to CRC errors when
>using the drive.
>
>Luca
>  
>
Hi Luca,

aren't the ata2.00: messages referring to my hard drive and the
ata2.01 messages referring to my optical drive?

ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16

ata2.01: ATAPI, max UDMA/33

ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



