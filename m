Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWCBSIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWCBSIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCBSID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:08:03 -0500
Received: from wp051.webpack.hosteurope.de ([80.237.132.58]:54253 "EHLO
	wp051.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751652AbWCBSIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:08:01 -0500
Message-ID: <4407347F.1000209@steffenweber.net>
Date: Thu, 02 Mar 2006 19:07:59 +0100
From: Steffen Weber <email@steffenweber.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
References: <44071AF3.1010400@steffenweber.net> <9a8748490603020935h4936ae0eob4bcf107cc75c923@mail.gmail.com> <44073037.2090709@steffenweber.net> <200603021859.29728.jesper.juhl@gmail.com>
In-Reply-To: <200603021859.29728.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Thursday 02 March 2006 18:49, Steffen Weber wrote:
>> Jesper Juhl wrote:
>>> On 3/2/06, Steffen Weber <email@steffenweber.net> wrote:
>>>> Jesper Juhl wrote:
>>>>> On Thursday 02 March 2006 17:18, Steffen Weber wrote:
>>>>>> I´m getting a compile error with 2.6.15.5 on x86_64 using GCC 3.4.4
>>>>>> (does not seem to be related to the NFS one):
>>>>>>
>>>>>>    CC      mm/mempolicy.o
>>>>>> mm/mempolicy.c: In function `get_nodes':
>>>>>> mm/mempolicy.c:527: error: `BITS_PER_BYTE' undeclared (first use in
>>>>>> this function)
>>>>>> mm/mempolicy.c:527: error: (Each undeclared identifier is reported only
>>>>>> once
>>>>>> mm/mempolicy.c:527: error: for each function it appears in.)
>>>>>>
>>>>> Try the following (untested patch).
>>>> Thanks for your reply, but this patch does not solve the problem (same
>>>> error message). I´ve appended my .config in case that might help.
>>>>
>>> Hmm, types.h contains the
>>>
>>> #define BITS_PER_BYTE 8
>>>
>>> that mmpolicy.c needs, so including that header should do the trick... odd..
>>> I'll look at the code a bit more.
>> There is no BITS_PER_BYTE in include/types.h. I´ve grepped through the 
>> kernel source (2.6.15 and 2.6.15.5) and found that BITS_PER_BYTE is 
>> defined only in arch/i386/mach-voyager/voyager_cat.c
>>
> 
> Whoops, I was looking here : http://sosdg.org/~coywolf/lxr/source/include/linux/types.h#L11
> 
> Try this patch instead : 
This patch solves the problem! :-) I have not yet rebooted the machine 
(it´s a busy webserver), but in case I do not reply again within one day 
you can assume that it works fine. Thank you very much!

Steffen
