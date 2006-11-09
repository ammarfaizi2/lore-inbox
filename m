Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423801AbWKIDxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423801AbWKIDxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 22:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423854AbWKIDxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 22:53:30 -0500
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:14220
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1423801AbWKIDxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 22:53:30 -0500
Message-ID: <4552A638.4010207@seclark.us>
Date: Wed, 08 Nov 2006 22:53:28 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca> <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>
In-Reply-To: <20061109020758.GA21537@atjola.homenet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:

>On 2006.11.08 19:35:45 -0500, Stephen Clark wrote:
>  
>
>>Mark Lord wrote:
>>
>>    
>>
>>>Remove the drivers/ide stuff from you system and let libata (ata_piix)
>>>manage the ICH7.  That should speed things up quite a bit.
>>>
>>>-ml
>>>
>>>
>>>
>>>      
>>>
>>Isn't already enabled?
>>
>>ata_piix 0000:00:1f.2: version 2.00
>>ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
>>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
>>ata: 0x170 IDE port busy
>>PCI: Setting latency timer of device 0000:00:1f.2 to 64
>>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
>>scsi0 : ata_piix
>>
>>    
>>
>
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>ide0: I/O resource 0x1F0-0x1F7 not free.
>ide0: ports already in use, skipping probe
>Probing IDE interface ide1...
>hdc: HTS721060G9AT00, ATA DISK drive
>
>Appears first and that's where the other driver has taken control of the
>drives. I had the same issue on my thinkpad, getting rid of the whole
>IDE stuff solved the problem (because the other drivers does no longer
>grab the drive).
>
>This ThinkWiki entry should apply to your laptop just as well, just
>replace /dev/hda with /dev/hdc.
>http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux#No_DMA_on_system_hard_disk
>
>  
>
>>also this laptop has nothing on ide0 - both the harddrive and dvdrom are 
>>on ide1.
>>is this confusing things?
>>    
>>
>
>Probably ide0 is pure SATA, while ide1 has the PATA adapters (just a
>guess).
>
>Björn
>
>  
>
Thank Bjorn,

I tried this and the kernel couldn't find the root volumegroup - so i 
got a kernel panic.
I am not sure on how to tell the system the volumegroup is now on sd? 
This is a
fc6 installation.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



