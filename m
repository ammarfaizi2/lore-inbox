Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSAUBBw>; Sun, 20 Jan 2002 20:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSAUBBm>; Sun, 20 Jan 2002 20:01:42 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58639 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288994AbSAUBB1>; Sun, 20 Jan 2002 20:01:27 -0500
Message-ID: <3C4B6778.7040509@namesys.com>
Date: Mon, 21 Jan 2002 03:57:28 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matt <matt@progsoc.uts.edu.au>
CC: Rik van Riel <riel@conectiva.com.br>, Shawn <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201201936340.32617-100000@imladris.surriel.com> <3C4B3B67.60505@namesys.com> <20020121111005.F12258@ftoomsh.progsoc.uts.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:

>On Mon, Jan 21, 2002 at 12:49:27AM +0300, Hans Reiser wrote:
>
>>Rik van Riel wrote:
>>
>
>[snip snip]
>
>>>On basically any machine we'll have multiple memory zones.
>>>
>
>>>Each of those memory zones has its own free list and each of the
>>>zones can get low on free pages independantly of the other zones.
>>>
>
>>>This means that if the VM asks to get a particular page freed, at
>>>the very minimum you need to make a page from the same zone
>>>freeable.
>>>
>
>>>regards,
>>>
>
>>>Rik
>>>
>
>
>>I'll discuss with Josh tomorrow how we might implement support for that. 
>>  A clean and simple mechanism does not come to my mind immediately.
>>
>
>>Hans
>>
>
>i know this sounds semi-evil, but can't you just drop another non
>dirty page and do a copy if you need the page you have been asked to
>write out? because if you have no non dirty pages around you'd
>probably have to drop the page anyway at some stage..
>
>	matt
>
Yes, but it is seriously suboptimal to do copies if not really needed.
So, if we really must, then yes, but must we?  Would be best if VM told us
if we really must write that page.

Hans

