Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTGGDwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 23:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTGGDwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 23:52:50 -0400
Received: from dyn-ctb-210-9-243-115.webone.com.au ([210.9.243.115]:6160 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264629AbTGGDws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 23:52:48 -0400
Message-ID: <3F08F1D8.4040601@cyberone.com.au>
Date: Mon, 07 Jul 2003 14:06:48 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Status of the IO scheduler fixes for 2.4
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>	 <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva>	 <1057354654.20903.1280.camel@tiny.suse.com>	 <200307060958.36642.m.c.p@wolk-project.de> <1057517497.20904.1322.camel@tiny.suse.com>
In-Reply-To: <1057517497.20904.1322.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>On Sun, 2003-07-06 at 03:58, Marc-Christian Petersen wrote:
>
>>On Friday 04 July 2003 23:37, Chris Mason wrote:
>>
>>Hi Chris,
>>
>>
>>>>If the IO fairness still doesnt
>>>>get somewhat better for general use (well get isolated user reports and
>>>>benchmarks for both the two patches), then I might consider the q->full
>>>>patch (it has throughtput drawbacks and I prefer avoiding a tunable
>>>>there).
>>>>
>>now there is io-stalls-10 in .22-pre3 (lowlat elev. + fixpausing). Could you 
>>please send "q->full patch" as ontop of -pre3? :-)
>>
>
>Attached, this defaults to q->full off and keeps the elvtune changes. 
>So to turn on the q->full low latency fixes, you need to:
>
>

Its a shame to have it default off, seeing as it fixes a real starvation
/ unfairness problem, and nobody is going to turn it on. It would be
nice to turn it on by default and see how many people shout about the
throughput drop, but I guess you can't do that in a stable series :P

I guess it will be useful to be able to ask people to try it if they are
reporting bad behaviour.


