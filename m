Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTHWAWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 20:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHWAWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 20:22:20 -0400
Received: from dyn-ctb-210-9-245-87.webone.com.au ([210.9.245.87]:55049 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263460AbTHWAWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 20:22:18 -0400
Message-ID: <3F46B3A8.3070101@cyberone.com.au>
Date: Sat, 23 Aug 2003 10:22:00 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
References: <3F4182FD.3040900@cyberone.com.au> <20030822085508.GA10215@k3.hellgate.ch> <3F4615D8.9030200@cyberone.com.au> <20030822151150.GA27508@k3.hellgate.ch>
In-Reply-To: <20030822151150.GA27508@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roger Luethi wrote:

>On Fri, 22 Aug 2003 23:08:40 +1000, Nick Piggin wrote:
>
>>>I timed a pathological benchmark from hell I've been playing with lately.
>>>Three consecutive runs following a fresh boot. Time is in seconds:
>>>
>>>2.4.21			821	21	25
>>>2.6.0-test3-mm1		724	946	896
>>>2.6.0-test3-mm1-nick	905	987	997
>>>
>>>Runtime with ideal scheduling: < 2 seconds (we're thrashing).
>>>
>>>
>>Cool. Can you post the benchmark source please?
>>
>
>http://hellgate.ch/code/ploc/thrash.c
>
>A parallel kernel build can generate some decent thrashing, too, but I
>wanted a short and simple test case that conveniently provides the
>information I need for both logging daemon and post processing tool.
>
>Note: The benchmark could trivially be made more evil which would prevent
>2.4.21 from finishing over 30 times faster (as it often does). I
>intentionally left it they way it is.
>
>While everybody seems to be working on interactivity, I am currently
>looking at this corner case. This should be pretty much orthogonal to your
>own work.
>

Yes, improvements for this problem are usually in the form of a
secondary scheduler of sorts somewhere in the VM. Hard problem.


