Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTIBXti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTIBXti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:49:38 -0400
Received: from dyn-ctb-210-9-241-57.webone.com.au ([210.9.241.57]:18180 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261316AbTIBXtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:49:36 -0400
Message-ID: <3F552C70.2030109@cyberone.com.au>
Date: Wed, 03 Sep 2003 09:49:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: Con Kolivas <kernel@kolivas.org>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com>	 <200309011707.20135.phillips@arcor.de>	 <1062457396.9959.243.camel@big.pomac.com>	 <200309021023.24763.kernel@kolivas.org>	 <1062498307.5171.267.camel@big.pomac.com>	 <3F547A4B.7060309@cyberone.com.au> <1062523374.5171.321.camel@big.pomac.com>
In-Reply-To: <1062523374.5171.321.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>On Tue, 2003-09-02 at 13:08, Nick Piggin wrote:
>
>>Ian Kumlien wrote:
>>
>>>You could say that the problem the current scheduler has is that it's
>>>not allowed to starve anything, thats why we add stuff to give
>>>interactive bonus. But if it *was* allowed to starve but gave bonus to
>>>the starved processes that would make most of the interactive detection
>>>useless (yes, we still need the "didn't use their timeslice" bit and
>>>with a timeslice that gets smaller the higher the pri we'd automagically
>>>balance most processes).
>>>
>>>(As usual my assumptions might be really wrong...)
>>>
>>First off, no general purpose scheduler should allow starvation depending
>>on your definition. The interactivity stuff, and even dynamic priorities
>>allow short term unfairness.
>>
>
>When you reach a certain load you *have to* allow starvation. Ie, you
>can't work around it... All i say is that if we have a more relaxed
>method we might benefit from it.
>

Depending on your definition. If 1000 processes get 10ms CPU every
10000ms I would not call that being starved. Maybe thats misleading.

>
>>Hmm... what else? The "didn't use their timeslice" thing is not
>>applicable: a new timeslice doesn't get handed out until the previous one
>>is used. The priorities thing is done based on how much sleeping the
>>process does.
>>
>
>And not the amount of cpu consumed by the app / go?
>

Well yeah in a way. Consuming CPU lowers priority, sleeping raises.

>
>>Its funny, everyone seems to have very similar ideas that they are
>>expressing by describing different implementations they have in mind.
>>
>
>Yes =), I'm mailing Con directly now as well, to save some unwanted
>traffic here =). I just hope that we'll reach a agreement somewhere
>about whats sane or not...
>
>Mail me if you're interested as well.
>

OK CC me

