Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265375AbSJaVpz>; Thu, 31 Oct 2002 16:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJaVpz>; Thu, 31 Oct 2002 16:45:55 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:8715 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S265375AbSJaVpx>;
	Thu, 31 Oct 2002 16:45:53 -0500
Message-ID: <3DC1A5D5.8000901@namesys.com>
Date: Fri, 01 Nov 2002 00:51:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: "David C. Hansen" <haveblue@us.ibm.com>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reiser vs EXT3
References: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to talk about 2.6 then you should talk about reiser4 not 
reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 for 
30 copies of the linux kernel source code using modern IDE drives and 
modern processors on a dual-CPU box, so I don't think any amount of 
improved scalability will make ext3 competitive with reiser4 for 
performance usages.  

We haven't had anyone test performance using RAID yet for reiser4, that 
could be fun.

Best,

Hans


David Lang wrote:

>note that breaking up this locking bottleneckhas been done in the 2.5
>kernel series so when 2.6 is released this should be much less significant
>(Q2 2003 is the current thought, but don't count on it until it's out)
>
>David Lang
>
>On 31 Oct 2002, David C. Hansen wrote:
>
>  
>
>>Date: 31 Oct 2002 11:02:49 -0800
>>From: David C. Hansen <haveblue@us.ibm.com>
>>To: Robert L. Harris <Robert.L.Harris@rdlg.net>
>>Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
>>Subject: Re: Reiser vs EXT3
>>
>>On Thu, 2002-10-31 at 06:19, Robert L. Harris wrote:
>>    
>>
>>>  Still working on that replacement mail server and a new rumor has hit
>>>the mix.  It follows that reiserfs is much faster than ext3 (made ext3,
>>>not converted from ext2 if it matters) and this is causing some
>>>problems.  On a 200Gig filesystem is this truely an issue?
>>>      
>>>
>>ext3 has some SMP scalability problems.  The BKL is used to protect many
>>journal operations, and we see huge amounts of CPU spent spinning on it
>>on 4/8/16 proc machines.  So much CPU, that it masks anything else we're
>>doing on the system.  But, on a single-proc or just a 2-way, you
>>probably won't see much of this to be significant.
>>
>>We haven't tested reiser extensively here, but from what I've seen it
>>scales much, much better than ext3 (as does jfs and probably xfs too).
>>--
>>Dave Hansen
>>haveblue@us.ibm.com
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml
>
>
>  
>


-- 
Hans


