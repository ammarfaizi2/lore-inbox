Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSIXOPB>; Tue, 24 Sep 2002 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbSIXOPA>; Tue, 24 Sep 2002 10:15:00 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:27579 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S261690AbSIXOO7>;
	Tue, 24 Sep 2002 10:14:59 -0400
Message-ID: <3D90749D.50609@wgate.com>
Date: Tue, 24 Sep 2002 10:20:13 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Svensson <petersv@psv.nu>
CC: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.4.44.0209241537340.2383-100000@cheetah.psv.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Svensson wrote:
> On Tue, 24 Sep 2002, Michael Sinz wrote:
> 
> 
>>The problem was very quickly noticed as other students quickly learned
>>how to make use of such "solutions" to their performance wants.  We
>>relatively quickly had to add process level accounting of thread CPU
>>usage such that any thread in a process counted to that process's
>>CPU usage/timeslice/etc.  It basically made the scheduler into a
>>2-stage device - much like user threads but with the kernel doing
>>the work and all of the benefits of kernel threads.  (And did not
>>require any code recompile other than those people who were doing
>>the many-threads CPU hog type of thing ended up having to revert as
>>it was now slower than the single thread-per-CPU code...)
> 
> 
> Then you can just as well use fork(2) and split into processes with the 
> same result. The solution is not thread specific, it is resource limits 
> and/or per user cpu accounting. 

I understand that point - but the basic question is if you schedule
based on the process or based on the thread.  In an interactive multi-
user system, you may even want to back out to the user level.  (Thus
no user can hog the system by doing many things).  But that is usually
not the target of Linux systems (yet?)

The problem then is the inter-process communications.  (At least on
that system - Linux has many better solutions)  That system did not
have shared memory and thus the coordination between processes was
difficult at best.

> Several raytracers can (could?) split the workload into multiple 
> processes, some being started on other computers over rsh or similar.

And they exist - but the I/O overhead makes it "not a win" on a
single machine.  (It hurts too much)

-- 
Michael Sinz -- Director, Systems Engineering -- Worldgate Communications
A master's secrets are only as good as
	the master's ability to explain them to others.


