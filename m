Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275258AbTHGKHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275257AbTHGKHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:07:04 -0400
Received: from dyn-ctb-203-221-72-79.webone.com.au ([203.221.72.79]:35338 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275286AbTHGKFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:05:30 -0400
Message-ID: <3F322463.6030708@cyberone.com.au>
Date: Thu, 07 Aug 2003 20:05:23 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
References: <200308061910.h76JAYw16323@mail.osdl.org> <200308071541.06091.kernel@kolivas.org> <3F320D15.7020403@cyberone.com.au> <200308072001.13740.kernel@kolivas.org>
In-Reply-To: <200308072001.13740.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Thu, 7 Aug 2003 18:25, Nick Piggin wrote:
>
>>>The more frequently you round robin the lower the scheduler latency
>>>between SCHED_OTHER tasks of the same priority. However, the longer the
>>>timeslice the more benefit you get from cpu cache. Where is the sweet
>>>spot? Depends on the hardware and your usage requirements of course, but
>>>Ingo has empirically chosen 25ms after 50ms seemed too long. Basically
>>>cache trashing becomes a real problem with timeslices below ~7ms on
>>>modern hardware in my limited testing. A minor quirk in Ingo's original
>>>code means _occasionally_ a task will be requeued with <3ms to go. It
>>>will be interesting to see if fixing this (which O12.2+ does) makes a big
>>>difference or whether we need to reconsider how frequently (if at all) we
>>>round robin tasks.
>>>
>>Why not have it dynamic? CPU hogs get longer timeslices (but of course
>>can be preempted by higher priorities).
>>
>
>Funny you should say that. Before Ingo merged his A3 changes, that's what my 
>version of them did.
>
>

Between you and me, I think this would be the right way to go if it
could be done right. I don't think wli, mjb and the rest of their
clique appreciate the 25ms reschedule!


