Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317789AbSFMWnq>; Thu, 13 Jun 2002 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSFMWnp>; Thu, 13 Jun 2002 18:43:45 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:50305 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP
	id <S317789AbSFMWno>; Thu, 13 Jun 2002 18:43:44 -0400
Message-ID: <3D09201A.5060305@avaya.com>
Date: Thu, 13 Jun 2002 16:43:38 -0600
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
Organization: Avaya, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Richard Seaman, Jr." <dick@seaman.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
In-Reply-To: <Pine.LNX.4.44.0206132007010.8525-100000@elte.hu> <3D090B4D.4060104@avaya.com> <20020613171101.A20472@seaman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2002 22:43:55.0843 (UTC) FILETIME=[CCB06930:01C2132B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And my patch *MAKES* it compliant with these definitions. The scheduler 
was *NOT* compliant with these definitions.

You've quoted me out of context below. My statement that you quote 
applies to SCHED_OTHER processes.

Please see my original post with the patch. And thanks for reinforcing 
what I was saying!

- Bhavesh

Richard Seaman, Jr. wrote:
> On Thu, Jun 13, 2002 at 03:14:53PM -0600, Bhavesh P. Davda wrote:
> 
> 
>>I would think that the logical place to add any process to the runqueue 
>>would be the back of the runqueue. If all processes are ALWAYS added to 
>>the back of the runqueue, then every process is GUARANTEED to eventually 
>>be scheduled. No process will be starved indefinitely.
> 
> 
> FYI, from SuSv3:
> 
> "Under the SCHED_FIFO policy, the modification of the definitional
> thread lists is as follows:
> 
> 1. When a running thread becomes a preempted thread, it becomes
> the head of the thread list for its priority.
> 
> 2. When a blocked thread becomes a runnable thread, it becomes
> the tail of the thread list for its priority.
> 
> ....
> 
> 7. If a thread whose policy or priority has been modified other
> than by pthread_setschedprio() is a running thread or is runnable,
> it then becomes the tail of the thread list for its new priority.
> 
> 8. If a thread whose policy or priority has been modified by
> pthread_setschedprio() is a running thread or is runnable, the
> effect on its position in the thread list depends on the direction
> of the modification, as follows:
> 
>    1. If the priority is raised, the thread becomes the tail of
>       the thread list.
>    2. If the priority is unchanged, the thread does not change
>       position in the thread list.
>    3. If the priority is lowered, the thread becomes the head
>       of the thread list.
> 
> 9. When a running thread issues the sched_yield() function, the
> thread becomes the tail of the thread list for its priority.
> 
> ...."
> 
> Also, regarding SCHED_RR:
> 
> "...This policy shall be identical to the SCHED_FIFO policy with the
> additional condition that when the implementation detects that a
> running thread has been executing as a running thread for a time
> period of the length returned by the sched_rr_get_interval() function
> or longer, the thread shall become the tail of its thread list and
> the head of that thread list shall be removed and made a running
> thread......"
> 
> I'm not suggesting Linux HAS to comply with these requirements,
> but its worth consideration.
> 



-- 
Bhavesh P. Davda
Avaya Inc
Room B3-B03                     E-mail : bhavesh@avaya.com
1300 West 120th Avenue          Phone  : (303) 538-4438
Westminster, CO 80234           Fax    : (303) 538-3155

