Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316652AbSE0PHE>; Mon, 27 May 2002 11:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSE0PHD>; Mon, 27 May 2002 11:07:03 -0400
Received: from zeus.cs.um.edu.mt ([193.188.34.114]:64401 "EHLO
	zeus.cs.um.edu.mt") by vger.kernel.org with ESMTP
	id <S316652AbSE0PHD>; Mon, 27 May 2002 11:07:03 -0400
Message-ID: <3CF2A0FB.8090507@um.edu.mt>
Date: Mon, 27 May 2002 17:11:23 -0400
From: Joseph Cordina <joseph.cordina@um.edu.mt>
Organization: University of Malta
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wait queue process state
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I am quite new to this list and thus does not know if this question 
has been answered many a times. I have looked in the archive but could 
not find it. Here goes anyway:
     I realised that when processes are placed in the wait queue, they 
are set at either INTERRUPTIBLE or NONINTERRUPTIBLE. I also noticed that 
something like file access is set as NONINTERRUPTIBLE. Could someone 
please tell me the reason for having these two states. I can understand 
that INTERRUPTIBLE can be made to be interrupted by a timer or a signal 
and vice versa for UNTERRUPTIBLE. Yet what makes blocking system calls 
as INTERRUPTIBLE or NONINTERRUPTIBLE. Also why is file access considered 
as NONINTERRUPTIBLE.

In addition, inside the kernel running, are these two different states 
treated differently (apart from the allowance to be interrupted or 
otherwise).

The reason I am asking is that I am working on scheduler activations 
which allow new kernel threads to be created when a kernel thread blocks 
inside the kernel. Yet this only works for INTERRUPTIBLE processes, I 
was thinking of making it work also for NONINTERRUPTIBLE processes. Just 
wondering if this would have any repurcusions. Also when a process 
generates a page fault which causes a page to be retreived from the 
filesystem, it such a process placed in the wait queue as 
NONINTERRUPTIBLE also ?

Cheers

Joseph Cordina
University of Malta

