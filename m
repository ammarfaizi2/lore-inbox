Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161865AbWKIWQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161865AbWKIWQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161866AbWKIWQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:16:15 -0500
Received: from smtpout05-04.prod.mesa1.secureserver.net ([64.202.165.221]:17075
	"HELO smtpout05-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1161865AbWKIWQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:16:15 -0500
Message-ID: <4553A8AC.2090805@seclark.us>
Date: Thu, 09 Nov 2006 17:16:12 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Abysmal PATA IDE performance
References: <20061109202319.GA13940@dreamland.darkstar.lan>	 <4553903B.4010908@seclark.us> <68676e00611091352l16663ff9o86f663a28190c0dc@mail.gmail.com>
In-Reply-To: <68676e00611091352l16663ff9o86f663a28190c0dc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti wrote:

>On 11/9/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
>  
>
>>Luca Tettamanti wrote:
>>
>>    
>>
>>>Stephen Clark <Stephen.Clark@seclark.us> ha scritto:
>>>
>>>
>>>      
>>>
>>>>Looking at the dmesg output I am a little confused, see comments below:
>>>>partial dmesg output follows:
>>>>
>>>>SCSI subsystem initialized
>>>>libata version 2.00 loaded.
>>>>ata_piix 0000:00:1f.2: version 2.00
>>>>ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
>>>>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
>>>>PCI: Setting latency timer of device 0000:00:1f.2 to 64
>>>>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
>>>>scsi0 : ata_piix
>>>>Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
>>>>input: SynPS/2 Synaptics TouchPad as /class/input/input1
>>>>ATA: abnormal status 0x7F on port 0x1F7
>>>>ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
>>>>scsi1 : ata_piix
>>>>ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
>>>>ata2.00: ata2: dev 0 multi count 16
>>>>usb 2-2: new low speed USB device using uhci_hcd and address 3
>>>>ata2.01: ATAPI, max UDMA/33
>>>>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
>>>>===============****
>>>>
>>>>
>>>>        
>>>>
>>>This is your optical (CD/DVD) unit; I doubt that you can saturate that
>>>link, even if your drive can do a sustained 16x transfer with a DVD it
>>>will use only 21MBps. Your HD is using UDMA/100.
>>>      
>>>
>>aren't the ata2.00: messages referring to my hard drive and the
>>ata2.01 messages referring to my optical drive?
>>
>>ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
>>ata2.00: ata2: dev 0 multi count 16
>>
>>ata2.01: ATAPI, max UDMA/33
>>
>>ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
>>    
>>
>
>You're right, I misparsed your log. Probably Arjan is right about the wiring.
>
>Luca
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi Luca,

The specs for the laptop say it supports ide 100MBps (Ultra DMA 5).
Datová propustnost k IDE:   100 MBps (Ultra DMA 5)

Steve


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



