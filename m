Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266757AbUGLJTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUGLJTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266765AbUGLJTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:19:41 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:18134 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266757AbUGLJTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:19:38 -0400
Message-ID: <40F257A8.10205@blueyonder.co.uk>
Date: Mon, 12 Jul 2004 10:19:36 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Nuno Monteiro <nuno@itsari.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x Scheduler, preemption and responsiveness - puzzlement
References: <40F1BA46.9000207@blueyonder.co.uk> <20040711221818.GA30704@outpost.ds9a.nl> <40F1C568.2070503@blueyonder.co.uk> <20040712000137.GA3854@hobbes.itsari.int> <40F1E409.4040200@blueyonder.co.uk> <cone.1089597462.444239.28499.502@pc.kolivas.org>
In-Reply-To: <cone.1089597462.444239.28499.502@pc.kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jul 2004 09:19:53.0319 (UTC) FILETIME=[63D96F70:01C467F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Sid Boyce writes:
>
>> Nuno Monteiro wrote:
>>
>>>
>>> On 2004.07.11 23:55, Sid Boyce wrote:
>>>
>>>> I've been wondering why this is, I can't remember what the BIOS 
>>>> says  about the hard drives, from memory it looked OK, I think it 
>>>> was set to
>>>
>>>
>>>
>>> <snip snip>
>>>
>>>> PCI           IDE              nVidia Corporation nForce2 IDE (rev a2)
>>>
>>>
>>>
>>> <snip snip>
>>>
>>>> # CONFIG_BLK_DEV_AMD74XX is not set
>>>
>>>
>>>
>>> You don't have the driver for your IDE chipset compiled in. In the 
>>> "ATA/ ATAPI/MFM/RLL support" under "Device Drivers" menu select "AMD 
>>> and nVidia  IDE support". Also, you can disable the "Generic PCI IDE 
>>> Chipset Support"  and the "VIA82CXXX chipset support" you seem to 
>>> have enabled.
>>>
>>> Then you should be able to do DMA, and things will go a lot faster.
>>>
>>>
>>> Hope this helps.
>>>
>>>
>>>
>>>         Nuno
>>
>>
>> Oops!, thanks. The previous motherboard used the VIA chipset, so that 
>> got missed when I changed over.
>> Regards
>> Sid.
>
>
> DMA disabled is perhaps the most common reason for poor performance 
> under I/O loads. I think some cut down configurations that people have 
> used from their 2.4 installations have missed the appropriate IDE driver.
>
> Cheers,
> Con

That fixed the problem. When I checked my P-II 333 box and AMD64 laptop 
(VIA chipset), they were OK. Working on 4 boxes at the same time, I 
guess I got stuck in a VIA mental groove.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
===== LINUX ONLY USED HERE =====

