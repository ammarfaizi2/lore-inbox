Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946686AbWKJOjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946686AbWKJOjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424326AbWKJOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:39:46 -0500
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:51434
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1424399AbWKJOjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:39:45 -0500
Message-ID: <45548F2C.8040700@seclark.us>
Date: Fri, 10 Nov 2006 09:39:40 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jarek Poplawski <jarkao2@o2.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: New laptop - problems with linux
References: <20061109083205.GA976@ff.dom.local> <45533658.7030900@seclark.us> <20061110070818.GA995@ff.dom.local>
In-Reply-To: <20061110070818.GA995@ff.dom.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarek Poplawski wrote:

>On Thu, Nov 09, 2006 at 09:08:24AM -0500, Stephen Clark wrote:
>  
>
>>Jarek Poplawski wrote:
>>
>>    
>>
>>>On 08-11-2006 15:41, Stephen Clark wrote:
>>>
>>>
>>>      
>>>
>>>>Hi list,
>>>>
>>>>I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core 
>>>>2 Duo T560,0 2gb pc5400 memory.
>>>>        
>>>>
>>>>From checking around it appeared all the
>>>      
>>>
>>>>hardware was well supported by linux - but I am having major problems.
>>>>
>>>>
>>>>1. neither the wireless lan Intel pro 3945ABG or built in ethernet 
>>>>RTL-8169C are detected and configured
>>>>2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx 
>>>>mb/sec
>>>> according to hdparm. This same drive in my old laptop an HP n5430 with a
>>>> 850 duron the rate was 12-14 mb/sec.
>>>>  
>>>>
>>>>        
>>>>
>>>... 
>>>
>>>
>>>      
>>>
>>>>Kernel command line: ro root=/dev/VolGroup00/LogVol00 ide1=dma ide1=ata66
>>>>ide_setup: ide1=dma -- OBSOLETE OPTION, WILL BE REMOVED SOON!
>>>>ide_setup: ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
>>>>  
>>>>
>>>>        
>>>>
>>>Could you repeat the reason for this ides in kernel parameters?
>>>Did you try to boot some fresh live-cd distro?
>>>
>>>Jarek P.
>>>
>>>
>>>
>>>      
>>>
>>Yes, I was trying to get dma turned on for my harddrive.
>>    
>>
>
>You can do it with hdparm. But in current kernels it
>should be on by default - if not - there is probably
>lack of some driver or it is disabled by parameters like
>this. So try to get rid of them.
>
>As it was stated in the first reply by Arjan van de Ven
>you definitely should have this disk in sata mode and
>see it as sda, so try check in your kernel config
>Serial ATA... drivers - particulary:
>CONFIG_ATA = y
>CONFIG_ATA_PIIX = y
>and maybe:
>CONFIG_ATA_GENERIC = y
>CONFIG_PATA_MPIIX = y
>
>(if they are "= mi", you should have initrd properly generated).
>
>Probably you can also do CONFIG_IDE = n in ATA/ATAPI
>(it depends on your CD-DVD).
>  
>  
>
>>I have booted knoppix 5.1 but didn't check harddrive transfer rate.
>>    
>>
>
>If you can see it as sda, transfer should be fine.
>
>Regards,
>
>Jarek P. 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi Jarek,

The problem is resolved by using combined_mode=libata and 2.6.19-rc5.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



