Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUCLJiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUCLJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:38:18 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:20359 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262052AbUCLJiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:38:13 -0500
Message-ID: <405184F7.1050100@cyberone.com.au>
Date: Fri, 12 Mar 2004 20:37:59 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: m.c.p@wolk-project.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       mfedyk@matchmail.com, plate@gmx.tm
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au>	<200403111825.22674@WOLK>	<40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org>
In-Reply-To: <20040312012703.69f2bb9b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>Hmm... I guess it is still smooth because it is swapping out only
>> inactive pages. If the standard VM isn't being pushed very hard it
>> doesn't scan mapped pages at all which is why it isn't swapping.
>>
>> I have a preference for allowing it to scan some mapped pages though.
>>
>
>I haven't looked at the code but if, as I assume, it is always scanning
>mapped pages, although at a reduced rate then the effect will be the same
>as setting swappiness to 100, except it will take longer.
>
>

Yep

>That effect is to cause the whole world to be swapped out when people
>return to their machines in the morning.  Once they're swapped back in the
>first thing they do it send bitchy emails to you know who.
>
>>From a performance perspective it's the right thing to do, but nobody likes
>it.
>
>

Yeah. I wonder if there is a way to be smarter about dropping these
used once pages without putting pressure on more permanent pages...
I guess all heuristics will fall down somewhere or other.

