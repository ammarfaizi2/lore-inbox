Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRB1R6h>; Wed, 28 Feb 2001 12:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRB1R6d>; Wed, 28 Feb 2001 12:58:33 -0500
Received: from www0q.netaddress.usa.net ([204.68.24.46]:3212 "HELO
	www0q.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S129112AbRB1R6R> convert rfc822-to-8bit; Wed, 28 Feb 2001 12:58:17 -0500
Message-ID: <20010228175816.28039.qmail@www0q.netaddress.usa.net>
Date: 28 Feb 2001 11:58:15 CST
From: Neelam Saboo <neelam_saboo@usa.net>
To: linux-kernel@vger.kernel.org
Subject: paging behavior in Linux
X-Mailer: USANET web-mailer (34FM.0700.15B.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a graduate student at Univ Of Illinois at Urbana-Champaign.
Regarding my thesis, I need some help with running a multithreaded program on
red hat linux. I am experimenting with paging behavior. I use a machine where
swap space is large compared to available memory. I run two threads, worker
thread & prefetch thread.
prefetch thread prefetches data in memory by accessing it which worker
thread will use later. Expected result is prefetch thread should take
most of the page faults leaving worker thread time to do actual work.
So, paging time in prefetch thread and work time in worker thread should
overlap and total time taken should be less.
In a PThreads book I found out that when one thread is waiting on a page
fault, other thread continues to work.

When I run my program on a readhat linux machine, I dont get results as
expected, work thread seems to be stuck when prefetch thread is waiting on
a page fault. Is it because, when one thread waits on a page fault, page
table is locked for the other thread also. This is linux specific, as I
get expected results on solaris. 

Can you please provide some explanations ?

Thanks
Neelam  
 


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
