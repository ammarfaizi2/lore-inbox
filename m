Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSE1U4x>; Tue, 28 May 2002 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316938AbSE1U4v>; Tue, 28 May 2002 16:56:51 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:24755 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S316919AbSE1UzS>;
	Tue, 28 May 2002 16:55:18 -0400
Message-ID: <3CF3EE2A.1030605@candelatech.com>
Date: Tue, 28 May 2002 13:52:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
CC: cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: how to get per-socket stats on udp rx buffer overflow?
In-Reply-To: <Pine.LNX.4.33.0205241949360.2424-100000@w-nivedita2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nivedita Singhvi wrote:

>>Is there any way for me to see how many incoming packets 
>>were dropped on a udp socket due to overflowing the input buffer?  
>>I specifically want this information on a per-socket basis.
>>
> 
> The /proc/net/snmp Udp counter InErrors includes the global
> count. It would be expensive and usually unnecessary to keep
> per-socket stats. Is there a real need for seeing the 
> per-socket count?


It would not be that expensive..it's just an extra counter that
is bumped whenever a pkt is dropped.

I have need of similar information, but it's low priority
for me right now, so I probably won't be adding a patch anytime
soon...

 
> If it helps, you can check the current bytes in the recv queue
> in netstat output - you wont know how many bytes have been dropped,
> but at least you know the amnt in the queue waiting to be read..


That is nearly worthless unless you are really killing your machine
and constantly have your buffers full...

Ben


> 
> 
>>Chris
>>
> 
> thanks,
> Nivedita
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


