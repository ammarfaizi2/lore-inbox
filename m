Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTJNKaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTJNKaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:30:20 -0400
Received: from dyn-ctb-210-9-243-42.webone.com.au ([210.9.243.42]:49156 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262312AbTJNKaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:30:06 -0400
Message-ID: <3F8BCFEB.1010306@cyberone.com.au>
Date: Tue, 14 Oct 2003 20:28:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Piet Delaney <piet@www.piet.net>, George Anzinger <george@mvista.com>,
       Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
References: <20031006161733.24441.qmail@email.com> <3F833C06.7000802@mvista.com> <1066120643.25020.121.camel@www.piet.net> <20031014094655.GC24812@mail.shareable.org> <3F8BCAB3.2070609@cyberone.com.au> <20031014101853.GA28905@mail.shareable.org>
In-Reply-To: <20031014101853.GA28905@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:

>Nick Piggin wrote:
>
>>I don't know anything about it, but I don't see what exactly you'd be
>>trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
>>obviously. Also, "best use of system resources" wrt scheduling is a big
>>ask considering there isn't one ideal scheduling pattern for all but the
>>most trivial loads, even on a single processor computer (fairness, latency,
>>priority, thoughput, etc). Its difficult to even say one pattern is better
>>than another.
>>
>
>Hmm.  Prediction is potentially useful.
>
>Instead of an educated ad-hoc pile of heuristics for _dictating_
>scheduling behaviour, you can systematically analyse just what is it
>you're trying to achieve, and design a behaviour which achieves that
>as closely as possible.
>

Maybe, although as I said, I just don't know what exactly you would
predict and what the goals would be.

And often you'll be left with an ad-hoc pile of heuristics driving
(or being driven by) your ad-hoc analysis / prediction thingy. Analysing
the end result becomes very difficult. See drivers/block/as-iosched.c :P

>
>This is where good predictors come in: you feed all the possible
>scheduling decisions at any point in time into the predictor, and use
>the output to decide which decision gave the most desired result -
>taking into account the likelihood of future behaviours.  Of course
>you have to optimise this calculation.
>
>This is classical control theory.  In practice it comes up with
>something like what we have already :)  But the design path is
>different, and if you're very thoroughly analytical about it, maybe
>there's a chance of avoiding weird corner behaviours that weren't
>intended.
>

You still have an ad-hoc starting point because it is not clear what
scheduling choices are the best.

>
>The down side is that crafted heuristics, like the ones we have, tend
>to run a _lot_ faster.
>

That too

