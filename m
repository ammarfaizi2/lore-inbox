Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVCXLDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVCXLDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVCXLDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:03:39 -0500
Received: from web53308.mail.yahoo.com ([206.190.39.237]:1467 "HELO
	web53308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262442AbVCXLDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:03:22 -0500
Message-ID: <20050324110321.83788.qmail@web53308.mail.yahoo.com>
Date: Thu, 24 Mar 2005 11:03:21 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: Re: sched.c  function
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Tasks do not change their state without holding a
> lock. (There is an exception,
> but it is justified.)
list after that..
> 
> So you want to record task state changes? That is
> better done at the right
> places in the kernel rather than traversing the task
> list repeatedly (the
> latter is not that performant).

So you want to say that only one task could be running
at a single time 

but how to know which one 
is there any way without traversing the task list
previously i thought of for_each_process(p)
                        if(p->state==running)

but without this how to find which process is
currently running and other are sleeping 
may it is through "current"

since the current->pid is only running
but i have to run this repeatedly to get the
information of currently running process(since this
may be for a fraction of a second and i can miss that
process if my loop is longer) 
how to do that 
fast timer 
or any other way 
i am little bit confused
                        

> I would be interested in the background: what do you
> need to know the task
> states for?


i want to develop a task manager for threads.
the application reads properly the process information
and the thread information but not able to refresh the
thread information as i am building my own proc file
where only threads are there 
i am distinguishing between process and thread at
fork.c
with clone_vm set..

therefore i need to know which thread is currently
running or not 


there is another problem i am discusing with you 

i want to distinguish between thread and process and
after distinguishing between user thread and kernel
thread 
but i am unable to find any condition which will be
true for kernel level thread during creation and false
for user level thread 
can you help me in this also
thanks 
sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
