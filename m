Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUBVEKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 23:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUBVEKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 23:10:22 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:23261 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261667AbUBVEKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 23:10:21 -0500
Message-ID: <40382BAA.1000802@cyberone.com.au>
Date: Sun, 22 Feb 2004 15:10:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au>
In-Reply-To: <4038299E.9030907@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Chris Wedgwood wrote:
>
>> On Sat, Feb 21, 2004 at 07:28:24PM -0800, Linus Torvalds wrote:
>>
>>
>>> What happened to the experiment of having slab pages on the
>>> (in)active lists and letting them be free'd that way? Didn't
>>> somebody already do that? Ed Tomlinson and Craig Kulesa?
>>>
>>
>> Just as a data point:
>>
>> cw@taniwha:~/wk/linux/bk-2.5.x$ grep -E '(LowT|Slab)' /proc/meminfo
>> LowTotal:       898448 kB
>> Slab:           846260 kB
>>
>> So the slab pressure I have right now is simply because there is
>> nowhere else it has to grow...
>>
>>
>
> Can you try the following patch? It is against 2.6.3-mm2.
>

Actually I think the previous shrink_slab formula factors
out to the right thing anyway, so nevermind this patch :P

