Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316977AbSF0Vwh>; Thu, 27 Jun 2002 17:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316986AbSF0Vwg>; Thu, 27 Jun 2002 17:52:36 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:27554 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S316977AbSF0Vwf>; Thu, 27 Jun 2002 17:52:35 -0400
Message-ID: <3D1B8975.7050509@mindspring.com>
Date: Thu, 27 Jun 2002 17:53:57 -0400
From: "John O'Donnell" <johnnyo@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo incomplete for AMD 386DX 40?
References: <200206271942.g5RJgv6F008956@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - Thank you all - I feel better now.  :-)
I tried fooling with the cache to no avail.  still 5.17
But I dont care - Linux humms on this minor beast of a system.
I was just looking for some clarification and I got it.
Now I can put the 386 back in the closet and let it fun a few years more! :-)
Thanks again!
Johnny O

Willy Tarreau wrote:
> Hello!
> 
>>>bogomips        : 5.17
>>
>>bogomips        : 7.93
> 
> I remember having had this last rate on my Am386DX/40 too, when the cache
> was enabled on the mainboard. If I disabled it, it dropped to about 5.2,
> which might explain differences noticed here. So check if you have some
> cache on your motherboard, and if it's enabled in your bios setup.  And
> don't trust these boards with fake plastic chips labelled "write back"
> with no other vendor name, and for which the bios reported "Write Back
> cache ON" instead of a size.
> 
> 
>>>Is there any harm in Linux not identifying stuff like the manufacturer.
>>>I dont know if the i386 supports any extensions that would show up in
>>>the flags field.  Think the bogomips is right?!?
>>
>>The flags field is stuff deduced from doing cpuid calls, so nothing there. 
>>The vendor might be a little difficult and might require depending on 
>>quirks of specific cpu models (i'm not 100% sure) therefore it would be a 
>>waste of memory to do.
> 
> 
> CPUID was introduced in latest Intel's 486, when there was a lot of relabelling
> of cheaper AMDs to Intel equivalents with higher frequencies (eg: Amd486-50 ->
> i486-66). AMD took the step too at the time they were sending their new
> DX4/write-back core, IIRC. But I've never seen a 386 with a CPUID instruction,
> and trust me, I've searched for many ways to differenciate Intel's from AMD's.
> Even the register values after reset were the same as intel's. And they were
> very hard to catch because you had to reset the CPU and bypass the bios to
> get the values, then restore all its context. The only noticeable difference
> I found was that they didn't prefetch instructions the same way, and when you
> disabled the external cache, you could notice a different pipeline stall depending
> on instruction alignment.
> 
> So no reliable means to do what you want without opening the case, IMHO.
> 
> Cheers,
> Willy
> 
> 



-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell               |                                    |
|  (Sr. Systems Engineer,      | http://johnnyo.home.mindspring.com |
|  Net Admin, Webmaster, etc.) |   E-Mail: johnnyo@mindspring.com   |
+==============================+====================================+

