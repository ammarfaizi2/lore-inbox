Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTKJTcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTKJTcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:32:48 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:26386 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264092AbTKJTco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:32:44 -0500
Message-ID: <3FAFE8D5.4020102@kolumbus.fi>
Date: Mon, 10 Nov 2003 21:36:53 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com> <20031110165654.GS10144@redhat.com> <3FAFC831.4090108@colorfullife.com> <20031110180551.GA20168@vana.vc.cvut.cz> <3FAFDFFF.70100@colorfullife.com>
In-Reply-To: <3FAFDFFF.70100@colorfullife.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 10.11.2003 21:34:33,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 10.11.2003 21:33:49,
	Serialize complete at 10.11.2003 21:33:49
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Manfred Spraul wrote:

> Petr Vandrovec wrote:
>
>> On Mon, Nov 10, 2003 at 06:17:37PM +0100, Manfred Spraul wrote:
>>  
>>
>>> DEBUG_PAGEALLOC unmaps pages on kmem_cache_free and __free_pages(). 
>>> The pages are mapped again during get_free_pages and kmem_cache_alloc.
>>>
>>> 0x86000 looks like a normal page - what guarantees that it's not 
>>> used by the kernel?
>>>   
>>
>>
>> With DEBUG_PAGEALLOC there is no problem with page if it is USED by 
>> the kernel.
>> Problem is if page is NOT USED - in this case kernel does not have it 
>> in its
>> mapping, and bad thing happen.
>>  
>>
> If the page is used by AGP, then it won't have a mapping either.
>
afaics, agp uses change_apge_attr() to turn on NOCACHE bit, and doesn't 
remove the mapping.

--Mika




