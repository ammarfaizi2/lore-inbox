Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTKHCj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKHCj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:39:28 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:60872 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261262AbTKHCj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:39:27 -0500
Message-ID: <3FAC575A.5070907@cyberone.com.au>
Date: Sat, 08 Nov 2003 13:39:22 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: Linus Torvalds <torvalds@osdl.org>, bill davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <Pine.LNX.4.44.0311061143300.1842-100000@home.osdl.org> <200311070313.53958.rob@landley.net>
In-Reply-To: <200311070313.53958.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:

>On Thursday 06 November 2003 13:45, Linus Torvalds wrote:
>
>>On 6 Nov 2003, bill davidsen wrote:
>>
>>>I'm not sure what you mean by faster, burning runs at device limited
>>>speed in CPU time in the  less than 1% range if you remember to enable
>>>DMA. The last time I looked DMA didn't work in either kernel if write
>>>size was not a multiple of 1k, (or 2k?) has that changed?
>>>
>>DMA works fine
>>
>>	IF YOU DON'T USE IDE-SCSI
>>
>>Don't use it. Please. There's no point.
>>
>>It's much more readable to do
>>
>>	cdrecord dev=/dev/hdc
>>
>>than it is to do some stupid "scan SCSI devices" + "dev=0,1,0" or similar
>>totally incomprehensible crap that doesn't even work right.
>>
>>
>>>I'm not sure what you meant by faster, so don't think I'm disagreeing
>>>with you.
>>>
>>Faster as in "it uses DMA for everything, so you can actually burn at full
>>speed without having to worry about it or sucking up CPU".
>>
>>		Linus
>>
>
>Note this still doesn't mean you can scroll large X windows for two or three 
>seconds at a time without burning a coaster.
>
>I had high hopes with the new scheduler, but no.  (Maybe if I niced the heck 
>out of cdrecord...)
>

RT processes should work well with the scheduler. renicing if it is not
RT will help a little bit, but it doesn't do much to help maximum latency.


