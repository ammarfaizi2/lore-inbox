Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTIOKxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbTIOKxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:53:05 -0400
Received: from dyn-ctb-210-9-244-189.webone.com.au ([210.9.244.189]:39173 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261314AbTIOKxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:53:01 -0400
Message-ID: <3F6599F1.50402@cyberone.com.au>
Date: Mon, 15 Sep 2003 20:52:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <200309151054.h8FAsepr001086@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200309151054.h8FAsepr001086@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:

>>>>>>>That's a non-issue.  300 bytes matters a lot on some systems.  The
>>>>>>>fact that there are drivers that are bloated is nothing to do with
>>>>>>>it.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>Its kind of irrelevant when by saying "Athlon" you've added 128 byte
>>>>>>alignment to all the cache friendly structure padding.
>>>>>>
>>>>>>
>>>>>>
>>>>>My intention is that we won't have done 128 byte alignments just by
>>>>>'supporting' Athlons, only if we want to run fast on Athlons.  A
>>>>>distribution kernel that is intended to boot on all CPUs needs
>>>>>workarounds for Athlon bugs, but it doesn't need 128 byte alignment.
>>>>>
>>>>>Obviously using such a kernel for anything other than getting a system
>>>>>up and running to compile a better kernel is a Bad Thing, but the
>>>>>distributions could supply separate Athlon, PIV, and 386 _optimised_
>>>>>kernels.
>>>>>
>>>>>
>>>>>
>>>>Why bother with that complexity? Just use 128 byte lines. This allows
>>>>a decent generic kernel. The people who have space requirements would
>>>>only compile what they need anyway.
>>>>
>>>>
>>>So, basically, if you compile a kernel for a 386, but think that maybe
>>>one day you might need to run it on an Athlon for debugging purposes,
>>>you use 128 byte padding, because it's not too bad on the 386?  Seems
>>>pretty wasteful to me when the obvious, simple, elegant solution is to
>>>allow independent selection of workaround inclusion and optimisation.
>>>Especially since half of the work has already been done.
>>>
>>>
>>I missed the "simple, elegant" part. Conceptually elegant maybe.
>>
>>If you mean to use the optimise option only to set cache line size, then
>>that might be a bit saner.
>>
>>As far as the case study goes though: if you were worried about being
>>wasteful, why wouldn't you compile just for the 386 and debug from that?
>>
>
>In the model I'm proposing, the 386 kernel would be missing the Athlon
>workarounds.
>

No, debug the kernel while its running on the 386. And what of my other
concerns?

1. It doesn't appear to be simple and elegant.
2. It would drive developers nuts if it was used for anything other than
   a couple of critical functions (cache size would be one).
3. Are there valid situations where you would need it? This isn't a
   rhetorical question. Your example would be fine if somebody really
   needed to do that.



