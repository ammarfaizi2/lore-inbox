Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTI3BMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 21:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTI3BMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 21:12:15 -0400
Received: from dyn-ctb-210-9-243-176.webone.com.au ([210.9.243.176]:29188 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263094AbTI3BMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 21:12:13 -0400
Message-ID: <3F78D866.5070605@cyberone.com.au>
Date: Tue, 30 Sep 2003 11:12:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au> <bl9ul0$348$1@gatekeeper.tmr.com>
In-Reply-To: <bl9ul0$348$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <3F77BB2C.7030402@cyberone.com.au>,
>Nick Piggin  <piggin@cyberone.com.au> wrote:
>
>| AFAIK, Con's scheduler doesn't change the nice implementation at all.
>| Possibly some of his changes amplify its problems, or, more likely they
>| remove most other scheduler problems leaving this one noticable.
>| 
>| If X is running at -20, and xmms at +19, xmms is supposed to still get
>| 5% of the CPU. Should be enough to run fine. Unfortunately this is
>| achieved by giving X very large timeslices, so xmms's scheduling latency
>| becomes large. The interactivity bonuses don't help, either.
>
>Clearly the "some is good, more is better" approach doesn't provide
>stable balance between sound and cpu hogs. It isn't a question of "how
>much" cpu, just "when"which works or not.
>
>This is sort of like the deadline scheduler in that it trades of
>throughput for avoiding jackpot cases. I think that's desired behaviour
>in a CPU schedular too, at least if used by humans.
>

I'm not sure what you mean. There is nothing good to say about Ingo's
nice mechanism though (sorry Ingo, its otherwise a very nice
scheduler!).

In my scheduler, nice -20 processes get small timeslices so scheduling
latency stays low or even gets lower, while nice +19 ones get large
timeslices for lower context switches and better cache efficiency. As
you would like.


