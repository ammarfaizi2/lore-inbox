Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTBURvD>; Fri, 21 Feb 2003 12:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267616AbTBURvD>; Fri, 21 Feb 2003 12:51:03 -0500
Received: from [196.12.44.6] ([196.12.44.6]:27881 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S267615AbTBURvC>;
	Fri, 21 Feb 2003 12:51:02 -0500
Date: Fri, 21 Feb 2003 23:31:07 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Livio Baldini Soares <livio@ime.usp.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Remote execution of syscalls (was  Re: Syscall from Kernel Space)
In-Reply-To: <20030221174414.GA28062@ime.usp.br>
Message-ID: <Pine.LNX.4.44.0302212321530.6139-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


before anything else, thanx for the response, i was very much discouraged 
by the fact that i did not get any replies...

coming to whats happening...  lets see it this way... Theres a process (x)  
that is migrated to some other node. Now any syscall that the process (X)  
makes is to be shipped back to the originating node.  Say i have a user
thread (Y) running and receiving requests for syscall executions.  And now
if i execute a syscall, the syscall will be executed as of (Y) is 
executing it, but i want the syscall to run as if (X) is executing it!
The process (X) still exists on the originating system, but is idle.

Someone please help me out!

Prasad.

On Fri, 21 Feb 2003, Livio Baldini Soares wrote:
> Prasad writes:
> > 
> > I am sorry for not being clear... but i think its time to tell you where i 
> > needed it.  I, as a graduating project am working on a distributed 
> > computing system, a part of which is "transparent process migration in 
> > non-distributed environments".  In my system i would like to ship the 
> > syscalls back to the original node(where the process originated). so for 
> > that i have a kernel thread that takes the requests and is supposed to 
> > execute the syscalls on behalf of the process (I have the idle task 
> > structure existing on the originating node even after the process is 
> > migrated to the other node).  And the question is how do i do that. 
> 
>   Hummm.. why  not use  the more "obvious"  solution which is  using a
> user-level thread  instead of  a kernel thread?   Then you  could make
> whatever syscall  you want as  a process. Seems  cleaner to me,  and I
> can't see any  obvious disadvantages (of course, I  don't know exactly
> what you're trying to do over there). 
> 
>   You could  have the kernel spawn  a regular user  process to receive
> system  calls   from  the  external  node  everytime   you  migrate  a
> process. Or maybe even better,  one simple daemon which is responsible
> for receiving syscalls for all external processes. 
> 

-- 
Failure is not an option

