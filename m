Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTBUReR>; Fri, 21 Feb 2003 12:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTBUReR>; Fri, 21 Feb 2003 12:34:17 -0500
Received: from bidu.ime.usp.br ([143.107.45.12]:12936 "HELO bidu.ime.usp.br")
	by vger.kernel.org with SMTP id <S267609AbTBUReQ>;
	Fri, 21 Feb 2003 12:34:16 -0500
Date: Fri, 21 Feb 2003 14:44:15 -0300
From: Livio Baldini Soares <livio@ime.usp.br>
To: Prasad <prasad_s@students.iiit.net>
Cc: Andrea Arcangeli <andrea@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Remote execution of syscalls (was  Re: Syscall from Kernel Space)
Message-ID: <20030221174414.GA28062@ime.usp.br>
Mail-Followup-To: Livio Baldini Soares <livio@ime.usp.br>,
	Prasad <prasad_s@students.iiit.net>,
	Andrea Arcangeli <andrea@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030220224532.GE31480@x30.school.suse.de> <Pine.LNX.4.44.0302210959320.22616-100000@students.iiit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302210959320.22616-100000@students.iiit.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Prasad!
 
 [Caveat:  I am I  kernelnewbie, anything  I say  can and  probably is
wrong, anyway]

Prasad writes:
> 
> I am sorry for not being clear... but i think its time to tell you where i 
> needed it.  I, as a graduating project am working on a distributed 
> computing system, a part of which is "transparent process migration in 
> non-distributed environments".  In my system i would like to ship the 
> syscalls back to the original node(where the process originated). so for 
> that i have a kernel thread that takes the requests and is supposed to 
> execute the syscalls on behalf of the process (I have the idle task 
> structure existing on the originating node even after the process is 
> migrated to the other node).  And the question is how do i do that. 

  Hummm.. why  not use  the more "obvious"  solution which is  using a
user-level thread  instead of  a kernel thread?   Then you  could make
whatever syscall  you want as  a process. Seems  cleaner to me,  and I
can't see any  obvious disadvantages (of course, I  don't know exactly
what you're trying to do over there). 

  You could  have the kernel spawn  a regular user  process to receive
system  calls   from  the  external  node  everytime   you  migrate  a
process. Or maybe even better,  one simple daemon which is responsible
for receiving syscalls for all external processes. 

  Or I'm way off park? 

  best regards!

--  
  Livio <livio@ime.usp.br>
