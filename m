Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUCKASI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbUCKASI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:18:08 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:25023 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262910AbUCKART (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:17:19 -0500
Message-ID: <404FAFFE.9010403@matchmail.com>
Date: Wed, 10 Mar 2004 16:17:02 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>	<40469E50.6090401@matchmail.com> <20040303193025.68a16dc4.akpm@osdl.org> <404ECFE5.7040005@matchmail.com> <404ED388.5050905@cyberone.com.au> <404F651B.1030202@matchmail.com> <404FAA04.1020300@cyberone.com.au>
In-Reply-To: <404FAA04.1020300@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>> Nick Piggin wrote:
>>> Mainline doesn't put enough pressure on slab with highmem systems. This
>>> creates a lot more ZONE_NORMAL pressure and that causes swapping.
>>>
>>
>> Yep, saw that.  Especially with 128MB Highmem (eg, 1G RAM)
>>
>>> Now with the 2.6 VM, you don't do any mapped memory scaning at all
>>
>>
>>
>> You mean 2.6-mm?
>>
> 
> Yes, either mm or linus.
> 

Have there been any VM patches merged into mainline?  Or are you saying 
that the imbalance in mainline would be enough to overcome to lack of 
scanning of mapped pages?

>>> while you only have a small amount of memory pressure. This means that
>>> truely inactive mapped pages never get reclaimed.
>>>
>>
>> If I have enough pressure, they will be eventually?  But my caches 
>> will still be smaller than optimal, right?
>>
> 
> If you get a lot of pressure at one time it should push out your
> inactive mapped pages. Will get most of the really inactive ones,
> but it won't help pages becoming inactive in future.
> 

Ok, I see.  This might be happening, since it is steadily getting more 
into swap.

>>> The patches you are using do not address this. My split active list
>>> patches should do so. Alternatively you can increase
>>> /proc/sys/vm/swappiness, but that isn't a complete solution, and might
>>> make things too swappy. It is a difficult beast to control.
>>
>>
>>
>> Has akpm said that he would be including the active split patch in -mm?
>>
> 
> Hasn't looked at it much. Probably not until some of the more basic
> VM patches can get merged into -linus.

Yes, I wonder if the VM patches helped -mm in the reaim tests...

Let's get the fsfaz (free slab for all zones) into mainline asap! :-D

>> Do you have a patch against -mm (you wrote to ask for your latest...)?
>>
> 
> Yep...

Let me get back to you sometime next week.  So far, the VM is reacting 
ok with this combined workload.

Mike
