Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317657AbSFLHOL>; Wed, 12 Jun 2002 03:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317659AbSFLHOK>; Wed, 12 Jun 2002 03:14:10 -0400
Received: from eagle.he.net ([216.218.174.2]:28684 "EHLO eagle.he.net")
	by vger.kernel.org with ESMTP id <S317657AbSFLHOI>;
	Wed, 12 Jun 2002 03:14:08 -0400
Date: Wed, 12 Jun 2002 00:14:09 -0700
Message-Id: <200206120714.AAA07894@eagle.he.net>
From: "Anjali Kulkarni" <anjali@indranetworks.com>
To: mingo@elte.hu, Anjali Kulkarni <anjali@indranetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: scheduler problems
X-Mailer: WebMail 1.25
X-IPAddress: 61.11.16.239
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (given that the current 2.2 kernel is 2.2.21, the first thing would 
be to
> test it there too.)
> 

Thanks, I 'll do that.

> > [...] It is due to the fact that the schedule() function does not 
find
> > the 'current' process in the runqueue. [...]
> 
> a crash in line 384 means that the runqueue got corrupted by 
something,
> most likely caused by buggy kernel code outside of the scheduler.

Right, I thought of that, but how is it that it gets corrupt at exactly 
the same offset in task_struct of that process and every time with 
different processes? (I have run it atleast 20-30 times). And it just 
doesnt come if I kill the process in question? (I couldnt kill kupdate, 
and hence it comes anyways). And I have checked the task_struct of that 
process, the next_task & prev_task & other fields are not corrupted. 
Ofcource, it's still possible, like if the memory allocated & freed by 
my code is then used by scheduler for allocating task_struct; and then 
it is accessed again by mistake by my code at the same offset. 
But you feel sure it's a run queue corruption problem, and not anything 
else? If so, is there any particular way to debug this?

> > Can anyone tell me what's happening here? My kernel module is no 
way the
> > cause of any of this. [...]
> 
> does it happen if you do not run your kernel module after bootup, 
ever?

No, it does not:(

Thanks,
Anjali

> 
> 	Ingo
> 
> 


Anjali Kulkarni
Software Engineer
Indra Networks

~Living Well is the best Revenge~
