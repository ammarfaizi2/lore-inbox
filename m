Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVKPIgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVKPIgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKPIgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:36:04 -0500
Received: from smtp8.clb.oleane.net ([213.56.31.28]:52666 "EHLO
	smtp8.clb.oleane.net") by vger.kernel.org with ESMTP
	id S1030228AbVKPIgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:36:01 -0500
Message-ID: <437AEF61.1030704@aie-etudes.com>
Date: Wed, 16 Nov 2005 09:35:45 +0100
From: sej <trash@aie-etudes.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA transfer with kiobuf, kernel 2.4.21
References: <437A1D6E.4060302@aie-etudes.com>	 <1132076986.2822.34.camel@laptopd505.fenrus.org>	 <437A20AA.8020001@aie-etudes.com> <1132077714.2822.36.camel@laptopd505.fenrus.org>
In-Reply-To: <1132077714.2822.36.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
thank you for your help.
I will read the DMA documentation. But I need to make DMA on User memory 
space allocated in user space. Because I don't want the kernel to make 
allocation and deallocation during execution for stability.
Best regards.
Sebastien


Arjan van de Ven wrote :

>On Tue, 2005-11-15 at 18:53 +0100, sej wrote:
>  
>
>>>that sounds the wrong approach.. why don't you make your device driver
>>>export an mmap function.. and let the userspace app use that ?
>>>      
>>>
>>I can't because I need to allocate 128MB of memory per PCI card and if I put for example 4 cards, I'll have 512MB in kernel memory, and I think there will be some problem in kernel.
>>    
>>
>
>no there isn't.. there is no rule that memory you allocate for this as
>to be lowmem... at all.
>
>  
>
>>
>>    
>>
>>>transfer->Descript[i].size        = PAGE_SIZE;
>>>transfer->Descript[i].pciaddr    = (ULONG)
>>>virt_to_phys(page_address(iobuf->maplist[idxIobuf]));
>>> 
>>>
>>>      
>>>
>>>you really need to use the PCI DMA mapping api!
>>>      
>>>
>>I have a plx bridge PCI9656 with a DMA controler. So I have to make a 
>>descriptor table with physical address and size.
>>I work in 32 bits address mode, but I don't know which function to call 
>>to get a 36bits address for my controler.
>>    
>>
>
>see the PCI DMA mapping api. the docs for it are in Documentation/
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

