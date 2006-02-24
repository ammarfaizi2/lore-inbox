Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWBXDSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWBXDSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 22:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBXDSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 22:18:18 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:7677 "EHLO
	areca.com.tw") by vger.kernel.org with ESMTP id S1750738AbWBXDSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 22:18:17 -0500
Message-ID: <006101c638f0$f6583440$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "erich" <erich@areca.com.tw>
Cc: "\"Christoph Hellwig\"" <hch@infradead.org>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <billion.wu@areca.com.tw>,
       <alan@lxorguk.ukuu.org.uk>, <akpm@osdl.org>, <oliver@neukum.org>
Subject: Re: Areca RAID driver remaining items?
Date: Fri, 24 Feb 2006 11:18:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 24 Feb 2006 03:14:06.0531 (UTC) FILETIME=[5F175930:01C638F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arjan van de Ven,
I had  misconstruction with
>> [Exception is that you can say that you are ok with a bigger mask for
>> this type of memory, but just don't do that if you're not]

it should be "pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK)."

Best Regards
Erich Chen

----- Original Message ----- 
From: "erich" <erich@areca.com.tw>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: """"Christoph Hellwig"""" <hch@infradead.org>; 
<linux-scsi@vger.kernel.org>; <linux-kernel@vger.kernel.org>; 
<billion.wu@areca.com.tw>; <alan@lxorguk.ukuu.org.uk>; <akpm@osdl.org>; 
<oliver@neukum.org>
Sent: Friday, February 24, 2006 10:08 AM
Subject: Re: Areca RAID driver remaining items?


> Dear Arjan van de Ven,
>
> I would keep dma_alloc_coherent usage.
>
>> [Exception is that you can say that you are ok with a bigger mask for
>> this type of memory, but just don't do that if you're not]
>
> Should I remove "pci_set_dma_mask(pci_device, DMA_64BIT_MASK)" for this 
> case?
>
> Best Regards
> Erich Chen
>
> ----- Original Message ----- 
> From: "Arjan van de Ven" <arjan@infradead.org>
> To: "erich" <erich@areca.com.tw>
> Cc: """Christoph Hellwig""" <hch@infradead.org>; 
> <linux-scsi@vger.kernel.org>; <linux-kernel@vger.kernel.org>; 
> <billion.wu@areca.com.tw>; <alan@lxorguk.ukuu.org.uk>; <akpm@osdl.org>; 
> <oliver@neukum.org>
> Sent: Thursday, February 23, 2006 8:07 PM
> Subject: Re: Areca RAID driver remaining items?
>
>
>> On Thu, 2006-02-23 at 19:51 +0800, erich wrote:
>>> If Linux can not assurent the contingous memory space allocating of
>>> "dma_alloc_coherent" .
>>
>> coherent memory is guaranteed to be in the "lower" 32 bit of memory!
>> So that is good news, I think you are just fine.
>>
>> [Exception is that you can say that you are ok with a bigger mask for
>> this type of memory, but just don't do that if you're not]
>>
>>
>>> When arcmsr get a physical ccb address from areca's firmware.
>>> Does linux has any functions for converting of  "bus to virtual" ?
>>
>> not without using pools. You would have to search the list of memory you
>> gave it to find that out.
>>
>> (USB has a similar problem, afaik they solved it with pools)
>>
>>
> 

