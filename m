Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRJJAgv>; Tue, 9 Oct 2001 20:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271714AbRJJAgl>; Tue, 9 Oct 2001 20:36:41 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:1805 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S271005AbRJJAg2>; Tue, 9 Oct 2001 20:36:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Robert Love <rml@ufl.edu>
Subject: 2.4.10-ac10-preempt lmbench output. 
Date: Tue, 9 Oct 2001 20:36:56 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010003636Z271005-760+23005@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very pleased so far with ac10 with the preempt patch.  Much better than 
2.4.9-ac18-preempt, which is what i was using.  I'm just going to put up some 
output from lmbench to see if anyone who is running the non-preempt version 
is seeing better or worse timings and scores.   Perhaps the improvement is 
all in my head due to me moving my atapi devices off of the promise card 
(since you're not supposed to put any on it) and now everything is generally 
running faster despite the kernel being used.  Heh.  so here they are 

ftp://ftp.bitmover.com/lmbench/LMbench2.tgz
(top of README says lmbench 2alpha8)
compiled without any changes to the Makefile (gcc 2.95.4)

Simple syscall: 0.3226 microseconds
Simple read: 0.8185 microseconds
Simple write: 0.5791 microseconds
Simple stat: 3.7546 microseconds
Simple open/close: 5.6581 microseconds
lat_fs (ext2)
0k      1000    36770   123993
1k      1000    15526   74383
4k      1000    15202   73692
10k     1000    9124    51972
FIFO latency: 8.0457 microseconds
Signal handler installation: 0.932 microseconds
Signal handler overhead: 2.852 microseconds
Protection fault: 0.761 microseconds
Pipe latency: 7.9139 microseconds
Pagefaults on /something.avi: 13098 usecs
Process fork+exit: 249.6818 microseconds
Process fork+execve: 298.0000 microseconds
Process fork+/bin/sh -c: 7883.0000 microseconds
AF_UNIX sock stream latency: 11.0054 microseconds
Select on 200 tcp fd's: 62.7955 microseconds
Select on 200 fd's: 18.5960 microseconds
Fcntl lock latency: 7.3516 microseconds
lat_ctx on an Eterm process
"size=0k ovr=2.82
"size=1024k ovr=301.96

That's all from lmbench2.  Anyone without the preempt patch using the same 
kernel care to compare? I'm very pleased.  
Heavily io bound processes (dbench 32)  still causes something as light as an 
mp3 player to skip, though.   That probably wont be fixed intil 2.5, since 
you need to have preemption in the vm and the rest of the kernel.  
