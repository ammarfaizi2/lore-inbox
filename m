Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTIOIdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTIOIdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:33:43 -0400
Received: from dyn-ctb-210-9-244-189.webone.com.au ([210.9.244.189]:64004 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261262AbTIOIdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:33:41 -0400
Message-ID: <3F657931.2050209@cyberone.com.au>
Date: Mon, 15 Sep 2003 18:32:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <200309150831.h8F8Vir6000839@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200309150831.h8F8Vir6000839@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:

>>>That's a non-issue.  300 bytes matters a lot on some systems.  The
>>>fact that there are drivers that are bloated is nothing to do with
>>>it.
>>>
>>Its kind of irrelevant when by saying "Athlon" you've added 128 byte
>>alignment to all the cache friendly structure padding.
>>
>
>My intention is that we won't have done 128 byte alignments just by
>'supporting' Athlons, only if we want to run fast on Athlons.  A
>distribution kernel that is intended to boot on all CPUs needs
>workarounds for Athlon bugs, but it doesn't need 128 byte alignment.
>
>Obviously using such a kernel for anything other than getting a system
>up and running to compile a better kernel is a Bad Thing, but the
>distributions could supply separate Athlon, PIV, and 386 _optimised_
>kernels.
>

Why bother with that complexity? Just use 128 byte lines. This allows
a decent generic kernel. The people who have space requirements would
only compile what they need anyway.

>
>>There are systems
>>where memory matters, but spending a week chasing 300 bytes when you can
>>knock out 50K is a waste of everyones time. Do the 40K problems first
>>
>
>The 'select a single CPU to support and/optimise for' -> 'select a
>bitmap of CPUs to support' work is being done anyway though, so this
>is more or less just one single IFDEF, which is more like a few
>seconds work, rather than a week.
>

While I like Adrian's patch a lot from a functionality and user
simplicity point of view, the key to getting it merged is not to 
increase the complexity of the implementation. The only objections to
the concept came from people who didn't understand it AFAIK.

And too many combinations of ill defined things like this will make 
people (developers) go nuts.


