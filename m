Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbTIQFTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbTIQFTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:19:23 -0400
Received: from dyn-ctb-203-221-73-208.webone.com.au ([203.221.73.208]:16645
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262468AbTIQFTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:19:20 -0400
Message-ID: <3F67EED0.5060103@cyberone.com.au>
Date: Wed, 17 Sep 2003 15:19:12 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
References: <20030917022256.GA17624@wotan.suse.de>	<20030916194446.030d8e70.akpm@osdl.org>	<3F67E8D4.6010707@cyberone.com.au> <20030916220843.31533480.akpm@osdl.org>
In-Reply-To: <20030916220843.31533480.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>What is intriguing to me is the "Its only a 2% slowdown of the page
>> fault for every cpu other than K[78] for this single workaround. There
>> is no point to conditional compilation" attitude some people have.
>> Of course, its only 2% on a pagefault, not anywhere near 2% of kernel
>> performance as a whole, so maybe that is justified.
>>
>
>Absolutely.  But it's a bit of a pain finding a config option which says
>"this CPU might need the fixup".
>

Right. It obviously can't be done using the current system.

>
>> Just repeating though, that is a seperate issue and I think Andi's patch
>> is needed.
>>
>
>It is unquestionably needed - the kernel _has_ to perform the fixup for this
>CPU erratum.
>
>
>But I would like to see some evidence that prefetch ever provides any
>performance gain in-kernel.  I spent some time fiddling a while back and
>was unable to demonstrate any difference.
>
>
>

OK. I just liked this patch because apparently it fixes userspace as
well. Disabling prefetch for the kernel doesn't.


