Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUKICqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUKICqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUKICqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:46:35 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:10641 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261359AbUKICqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:46:32 -0500
Message-ID: <41902F83.6060200@cyberone.com.au>
Date: Tue, 09 Nov 2004 13:46:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet>	<20041108162731.GE2336@logos.cnet>	<20041108185546.GA3468@logos.cnet>	<419029D9.90506@cyberone.com.au> <20041108183552.7caccad1.akpm@osdl.org>
In-Reply-To: <20041108183552.7caccad1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>I'm not sure... it could also be just be a fluke
>> due to chaotic effects in the mm, I suppose :|
>>
>
>2.6 scans less than 2.4 before declaring oom.  I looked at the 2.4
>implementation and thought "whoa, that's crazy - let's reduce it and see
>who complains".  My three-year-old memory tells me it was reduced by 2x to
>3x.
>
>We need to find testcases (dammit) and do the analysis.  It could be that
>we're simply not scanning far enough.
>
>
>

Oh yeah, there definitely seems to be OOM problems as well (although
luckily not _too_ many people seem to be complaining).

I thought Marcelo was talking about increased incidents of people
reporting eg. order-0 atomic allocation failures though, after the
recentish code from you and I to fix up alloc_pages.

