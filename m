Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTIGFI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTIGFIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:08:25 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:48389
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261921AbTIGFIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:08:24 -0400
Message-ID: <3F5ABD3A.7060709@cyberone.com.au>
Date: Sun, 07 Sep 2003 15:08:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: John Yau <jyau_kernel_dev@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria> <1062878664.3754.12.camel@boobies.awol.org>
In-Reply-To: <1062878664.3754.12.camel@boobies.awol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:

>On Sat, 2003-09-06 at 14:17, John Yau wrote:
>
>
>>Scratch that, I just found Ingo's patch.  My patch does essentially the same
>>thing except it only allows the current active process to be preempted if it
>>got demoted in priority during the effective priority recalculation.  This
>>IMHO is better because it doesn't do unnecessary context switches.  If the
>>process were truly a CPU hog relative other processes on the run queue, then
>>it'd get preempted eventually when it gets demoted rather than always every
>>25 ms.
>>
>
>The rationale behind Ingo's patch is to "break up" the timeslices to
>give better scheduling latency to multiple tasks at the same priority. 
>So it is not "unnecessary context switches," just "extra context
>switches."
>
>It also recalculates the process's effective priority, like yours does,
>so it also has the same advantage as your patch: to more quickly detect
>tasks that have changed in interactivity, and to handle that.
>
>Not sure which approach is better.  Only testing will tell.
>
>
>>How come Ingo's granular timeslice patch didn't get put into 2.6.0-test4?
>>
>
>Interactivity improvements are currently a contentious issue.  The patch
>is back in 2.6-mm, though.
>

Although I think what is less contentious is that Con's stuff is an 
improvement over the 2.6 tree, and the consensus is that _something_
as to be done to it. So it is quite sad that the scheduler in 2.6 is
sitting there doing nothing but waiting to be obsoleted, while Con's
good (and begnin) scheduler patches are waiting around and getting
less than 1% of the testing they need.


