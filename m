Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRDLQKO>; Thu, 12 Apr 2001 12:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135218AbRDLQJz>; Thu, 12 Apr 2001 12:09:55 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:700 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135217AbRDLQJw>; Thu, 12 Apr 2001 12:09:52 -0400
Message-ID: <3AD5D311.5BFE39A6@mvista.com>
Date: Thu, 12 Apr 2001 09:08:49 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@us.ibm.com>
CC: mingo@elte.hu, Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Bug in sys_sched_yield
In-Reply-To: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> In the recent optimizations to sys_sched_yield a bug was introduced.
> In the current implementation of sys_sched_yield()
> the aligned_data and idle_tasks are indexed by logical cpu-#.
> 
> They should however be indexed by physical cpu-#.
> Since logical==physical on the x86 platform, it doesn't matter there,
> for other platforms where this is not true it will matter.
> Below is the fix.
> 
Uh...  I do know about this map, but I wonder if it is at all needed. 
What is the real difference between a logical cpu and the physical one. 
Or is this only interesting if the machine is not Smp, i.e. all the cpus
are not the same?  It just seems to me that introducing an additional
mapping just slows things down and, if all the cpus are the same, does
not really do anything.  Of course, I am assuming that ALL usage would
be to the logical :)

George
