Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbTIOJ7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbTIOJ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:59:05 -0400
Received: from dyn-ctb-210-9-244-189.webone.com.au ([210.9.244.189]:13317 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261718AbTIOJ7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:59:02 -0400
Message-ID: <3F658D4F.1020409@cyberone.com.au>
Date: Mon, 15 Sep 2003 19:58:39 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <200309150939.h8F9d13D000943@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200309150939.h8F9d13D000943@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:

>>>>>That's a non-issue.  300 bytes matters a lot on some systems.  The
>>>>>fact that there are drivers that are bloated is nothing to do with
>>>>>it.
>>>>>
>>>>>
>>>>Its kind of irrelevant when by saying "Athlon" you've added 128 byte
>>>>alignment to all the cache friendly structure padding.
>>>>
>>>>
>>>My intention is that we won't have done 128 byte alignments just by
>>>'supporting' Athlons, only if we want to run fast on Athlons.  A
>>>distribution kernel that is intended to boot on all CPUs needs
>>>workarounds for Athlon bugs, but it doesn't need 128 byte alignment.
>>>
>>>Obviously using such a kernel for anything other than getting a system
>>>up and running to compile a better kernel is a Bad Thing, but the
>>>distributions could supply separate Athlon, PIV, and 386 _optimised_
>>>kernels.
>>>
>>>
>>Why bother with that complexity? Just use 128 byte lines. This allows
>>a decent generic kernel. The people who have space requirements would
>>only compile what they need anyway.
>>
>
>So, basically, if you compile a kernel for a 386, but think that maybe
>one day you might need to run it on an Athlon for debugging purposes,
>you use 128 byte padding, because it's not too bad on the 386?  Seems
>pretty wasteful to me when the obvious, simple, elegant solution is to
>allow independent selection of workaround inclusion and optimisation.
>Especially since half of the work has already been done.
>

I missed the "simple, elegant" part. Conceptually elegant maybe.

If you mean to use the optimise option only to set cache line size, then
that might be a bit saner.

As far as the case study goes though: if you were worried about being
wasteful, why wouldn't you compile just for the 386 and debug from that?


