Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUCKAZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbUCKAZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:25:20 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:61128 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262796AbUCKAZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:25:09 -0500
Message-ID: <404FB1DF.3070605@cyberone.com.au>
Date: Thu, 11 Mar 2004 11:25:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>	<40469E50.6090401@matchmail.com> <20040303193025.68a16dc4.akpm@osdl.org> <404ECFE5.7040005@matchmail.com> <404ED388.5050905@cyberone.com.au> <404F651B.1030202@matchmail.com> <404FAA04.1020300@cyberone.com.au> <404FAFFE.9010403@matchmail.com>
In-Reply-To: <404FAFFE.9010403@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> Mike Fedyk wrote:
>>
>>> Nick Piggin wrote:
>>>
>>>> Mainline doesn't put enough pressure on slab with highmem systems. 
>>>> This
>>>> creates a lot more ZONE_NORMAL pressure and that causes swapping.
>>>>
>>>
>>> Yep, saw that.  Especially with 128MB Highmem (eg, 1G RAM)
>>>
>>>> Now with the 2.6 VM, you don't do any mapped memory scaning at all
>>>
>>>
>>>
>>>
>>> You mean 2.6-mm?
>>>
>>
>> Yes, either mm or linus.
>>
>
> Have there been any VM patches merged into mainline?  Or are you 
> saying that the imbalance in mainline would be enough to overcome to 
> lack of scanning of mapped pages?
>

There have been no VM patches merged into mainline. I just mean that
neither mm or mainline does any mapped memory scanning when memory
pressure is low.

>>
>> If you get a lot of pressure at one time it should push out your
>> inactive mapped pages. Will get most of the really inactive ones,
>> but it won't help pages becoming inactive in future.
>>
>
> Ok, I see.  This might be happening, since it is steadily getting more 
> into swap.
>


For the one that is swapping, yes this would be happening.


>>
>> Hasn't looked at it much. Probably not until some of the more basic
>> VM patches can get merged into -linus.
>
>
> Yes, I wonder if the VM patches helped -mm in the reaim tests...
>
> Let's get the fsfaz (free slab for all zones) into mainline asap! :-D
>


Well all the ones in -mm now are probably right to go to 2.6.5
I hope.

