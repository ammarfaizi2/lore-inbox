Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUJHDVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUJHDVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUJHDQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:16:46 -0400
Received: from mail-12.iinet.net.au ([203.59.3.44]:7385 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267487AbUJHDP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:15:59 -0400
Message-ID: <4166066C.3030008@cyberone.com.au>
Date: Fri, 08 Oct 2004 13:15:56 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: chrisw@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
References: <20041007142019.D2441@build.pdx.osdl.net>	<20041007164044.23bac609.akpm@osdl.org>	<4165E0A7.7080305@yahoo.com.au>	<20041007174242.3dd6facd.akpm@osdl.org>	<20041007184134.S2357@build.pdx.osdl.net>	<20041007185131.T2357@build.pdx.osdl.net>	<20041007185352.60e07b2f.akpm@osdl.org>	<4165FF7B.1070302@cyberone.com.au> <20041007200109.57ce24ae.akpm@osdl.org>
In-Reply-To: <20041007200109.57ce24ae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>>Chris Wright <chrisw@osdl.org> wrote:
>>>
>> >
>> >>(whereas I could get the mainline code, and the
>> >> one-liner to spin right off).  
>> >>
>> >
>> >How?  (up to and including .config please).
>> >
>> >
>> >
>>
>> Ah, free_pages <= pages_high, ie. 0 <= 0, which is true;
>> commence spinning.
>>
>
>Maybe.  It requires that the zonelists be screwy:
>
>

Note that if this *was* the problem, then it would not be the fault of
my recent patch, rather *every* allocation (when memory is lowish)
would cause kswapd to wind through its priority loop then stop.
Probably not using enough CPU for anyone to really notice though.

