Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265750AbUF2Mvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUF2Mvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 08:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUF2Mvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 08:51:50 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:23193 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S265750AbUF2Mvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 08:51:46 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F42FA3@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'andrebalsa@altern.org'" <andrebalsa@altern.org>,
       "'Richard E. Gooch'" <rgooch@atnf.csiro.au>,
       "'Ingo Molnar'" <mingo@elte.hu>, "'rml@tech9.net'" <rml@tech9.net>,
       "'akpm@osdl.org'" <akpm@osdl.org>
Subject: Linux scheduler (scheduling)  questions
Date: Tue, 29 Jun 2004 08:51:07 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

I  have "general"  Linux  OS scheduling  questions, especially with regards
as those apply to the (latest) Linux  2.6  scheduler features (would really
appreciate if whether/when/while answering those questions listed  below,
you could pinpoint differences between Linux 2.6 and Linux 2.4 !): 

0.  I was told that the Linux kernel could be configured with one of the 3
(? ) different scheduling policies - could someone describe       
     those to me in details ?

1.   How rescheduling is "induced" in above scheduling policies ?
      Does at least one of above mentioned scheduling policies uses "clock
tick" as a scheduling event ?
     Also, releasing mutex lock (semaphore) in Linux application/user-space
task - is it considered (by the sched) as a
     "rescheduling event" ? - (in addition to "clock tick" event) - this is
true for PSOS / VxWorks RTOSes.
     
2.  Linux 2.6 (I was told it is the same for Linux 2.4.21-15) has priorities
0-99 for RT priorities and 100-139 for normal   (SCHED_NORMAL)   tasks.

> I presume that priorities 0-99 are "recommended" (or enforced ?) for
> Linux kernel "native" tasks ... and "out or reach" for application
> tasks (unless one dares to merge application into the Linux kernel,
> masquerading it as a "system level command" - did anyone tried this ? -
> I presume it is not recommended ...  )  ?
> 
Under what priority the OS system calls are executed ?

3.  Is  priority inversion and its prevention (priority inheritance or
priority ceilings) applicable to Linux ) for application/user-space tasks (
with priorities in the range 100-139) ?
> Similar question for the situation when the "application" process
> executes "OS system call" in the kernel address space ?
> Similar question for the RT tasks (which I presume are Linux kernel
> "native" tasks, always executing in the kernel address space ? ) ?
> 
4. What about scheduling threads ? - as I have understood (from the FAQ on
http://www.tux.org/lkml/ ), threads in Linux are implemented in the kernel
space - is this information up to date, i.e. - is it applicable to Linux 2.6
? and what it actually means 
(does it mean that threads are always running in the kernel space ? - that
sounds a bit strange ...).
With what  priorities threads are running ? - do those priorities depend on
the priority of the application/user space process from which the  clone
system call was made  ?). 
5. Deviating from the scheduling line of questions (but staying with threads
issues): is there an option in clone(2)  to make threads 
   not to run in the same  address space but rather act as independent
process(es).

> Thanks,
> Best Regards,
> Alex Povolotsky
-----Original Message-----
From: Ingo Molnar [mailto:mingo@elte.hu]
Sent: Monday, June 28, 2004 10:40 AM
To: Povolotsky, Alexander
Subject: Re: Any differences (between 2.4 and 2.6) in Linux kernel
scheduling

Alexander,

you might want to post your questions to linux-kernel@vger.kernel.org
(or some other, RT related mailing list). The scheduler is described in
a rudimentary way in Documentation/sched-design.txt, sched-coding.txt,
with no focus on RT though.

	Ingo

>  
> 
> 
