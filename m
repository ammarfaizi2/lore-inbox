Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272001AbTHRPao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272012AbTHRPao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:30:44 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:46342 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272001AbTHRPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:30:40 -0400
Message-ID: <3F40F4DA.5050705@techsource.com>
Date: Mon, 18 Aug 2003 11:46:34 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O16int for interactivity
References: <200308160149.29834.kernel@kolivas.org> <3F3D25D0.7010701@techsource.com> <200308161231.50661.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>>
>>A hardware timer interrupt happens at timeslice granularity.  If the
>>interrupt occurs, but the timeslice is not expired, then NORMALLY, the
>>ISR would just return right back to the running task, but sometimes, it
>>might decided to end the timeslice early and run some other task.
>>
>>Right?
> 
> 
> No, the timeslice granularity is a hard cut off where a task gets rescheduled 
> and put at the back of the queue again. If there is no other task of equal or 
> better priority it will just start again.


Hmmm... I'm still having trouble making sense of this.

So, it seems that you're saying that all tasks, regardless of timeslice 
length, are interrupted every 10ms (at 100hz).  If another task exists 
at a higher priority, then it gets run at that point. However, if there 
is more than one task at a given priority level, then they will not 
round-robin until the current task has used up all of its timeslice 
(some integer multiple of 10ms).

Am I finally correct, or do I still have it wrong?  :)


