Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272318AbTHELD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272644AbTHELD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:03:59 -0400
Received: from dyn-ctb-203-221-74-83.webone.com.au ([203.221.74.83]:41478 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272318AbTHELDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:03:51 -0400
Message-ID: <3F2F8F0E.5060108@cyberone.com.au>
Date: Tue, 05 Aug 2003 21:03:42 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308052045.39476.kernel@kolivas.org> <3F2F8B77.4020107@cyberone.com.au> <200308052056.38861.kernel@kolivas.org>
In-Reply-To: <200308052056.38861.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 5 Aug 2003 20:48, Nick Piggin wrote:
>
>>Con Kolivas wrote:
>>
>>>On Tue, 5 Aug 2003 20:32, Nick Piggin wrote:
>>>
>>>>What you are doing is restricting some range so it can adapt more quickly
>>>>right? So you still have the problem in the cases where you are not
>>>>restricting this range.
>>>>
>>>Avoiding it becoming interactive in the first place is the answer.
>>>Anything more rapid and X dies dead as soon as you start moving a window
>>>for example, and new apps are seen as cpu hogs during startup and will
>>>take _forever_ to start under load. It's a tricky juggling act and I keep
>>>throwing more balls at it.
>>>
>>Well, what if you give less boost for sleeping?
>>
>
>Then it takes longer to become interactive. Take 2.6.0-test2 vanilla - audio 
>apps can take up to a minute to be seen as fully interactive; whether this is 
>a problem for your hardware or not is another matter but clearly they are 
>interactive using <1% cpu time on the whole.
>

I think this is a big problem, a minute is much too long. I guess its
taking this long to build up because X needs a great deal of inertia
so that it can stay in a highly interactive state right?

If so then it seems the interactivity estimator does not have enough
information to work properly for X. In which case maybe X needs to be
reniced, or backboosted, or have _something_ done to help out.


