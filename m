Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265392AbSJaWmP>; Thu, 31 Oct 2002 17:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSJaWmP>; Thu, 31 Oct 2002 17:42:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20242 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265392AbSJaWmF>; Thu, 31 Oct 2002 17:42:05 -0500
Message-ID: <3DC1B2FA.8010809@namesys.com>
Date: Fri, 01 Nov 2002 01:47:22 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, please
 apply
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <3DC19F61.5040007@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

>Am Donnerstag, 31. Oktober 2002 22:05 schrieb Jeff Garzik:
>  
>
>>Hans Reiser wrote:
>>
>>    
>>
>>>If you want to talk about 2.6 then you should talk about reiser4 not 
>>>reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 
>>>for 30 copies of the linux kernel source code using modern IDE drives 
>>>and modern processors on a dual-CPU box, so I don't think any amount 
>>>of improved scalability will make ext3 competitive with reiser4 for 
>>>performance usages. 
>>>      
>>>
>>What is the read performance like?
>>    
>>
>
>From his mentioned paper http://www.namesys.com/v4/fast_reiser4.html, it is 
>more then doubled compared to ext3 and ReiserFS v3.
>
>To be fair he should explain if it was compared to the latest ext3 (htree) 
>stuff or not, yet.
>
>It looks truly impressive.
>
>Regards,
>	Dieter
>  
>
Unfortunately that was an older version of reiser4, and we are still 
analyzing why it has higher read performance than what we are shipping 
today.  Give me a week, and I'll have a better answer for you.  What we 
shipped has higher read performance than ext3, but something is not what 
it should be and needs fixing.

Green and Zam and Umka, on Monday please start work on seriously 
analyzing how the block allocation differs between the new and the old 
kernel, now that you can finally reproduce the benchmark on the old kernel.

-- 
Hans


