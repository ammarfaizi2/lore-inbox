Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbUBZBw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUBZBw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:52:57 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:45484 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262363AbUBZBwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:52:55 -0500
Message-ID: <403D5174.6050302@cyberone.com.au>
Date: Thu, 26 Feb 2004 12:52:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com>
In-Reply-To: <403D4CBE.9080805@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> That is a much better sounding ratio. Of course that doesn't mean much
>> if performance is worse. Slab might be getting reclaimed a little bit
>> too hard vs pagecache now.
>>
>
> I'll let you know.  My graphs are looking better, except for one 
> instance of Xvnc (for one user -- I'm still tracking that one down) 
> hitting a memory grabbing loop that made me kill it.
>

Try to get /proc/meminfo and a sysrq + T trace if something like
this happens.

>>> See:
>>> http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html 
>>>
>>>
>>> Is there any way I can get the VM patches against 2.6.3?  I'm not 
>>> comfortable with running -mm3 on this production server, especially 
>>> seeing the "sync hang" bug.
>>>
>>
>> Well your server wasn't going too badly with 2.6.3, wasn't it? Might
>> as well just wait for them to get into the the tree.
>
>
> I might as well take out the third 512MB DIMM in that machine then...
>
> Any chance you could post a VM patch roll-up against 2.6.3 for little 
> ole me?
>

It is a bit easier said than done as you might have seen :P And
I'm laz^W^W I happen to not agree with one of Andrew's patches,
so it would go against all my principles ;)

IMO, shrink_slab-for-all-zones.patch and zone-balancing-fix.patch
should be all you need although they won't shrink the slab as
much as mm3. They should be pretty easy to port by hand.

