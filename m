Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLGGrL>; Thu, 7 Dec 2000 01:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLGGrC>; Thu, 7 Dec 2000 01:47:02 -0500
Received: from grunt.okdirect.com ([209.54.94.12]:28428 "HELO mail.pyxos.com")
	by vger.kernel.org with SMTP id <S129370AbQLGGqn>;
	Thu, 7 Dec 2000 01:46:43 -0500
Message-Id: <5.0.2.1.2.20001207000341.03a196e8@209.54.94.12>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 07 Dec 2000 00:13:50 -0600
To: linux-kernel@vger.kernel.org
From: Daniel Walton <zwwe@opti.cgi.net>
Subject: Re: Out of socket memory? (2.4.0-test11)
In-Reply-To: <Pine.LNX.4.10.10012070029250.3437-100000@coffee.psychology
 .mcmaster.ca>
In-Reply-To: <5.0.2.1.2.20001206223822.03997008@209.54.94.12>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm not quite clear how the settings under /proc/sys/vm/* would effect the 
problem.  I neglected to mention in my previous post that all web content 
is served directly from the memory of the web server (no file 
accesses).  The only file accesses that happen are from a MySQL server 
which gets queried about once a second.

Here's the output of /proc/meminfo.  I'm not sure how helpful it is.  I was 
kinda hoping for something that would allow me to see how much memory had 
been allocated for sockets and what the max was.

[root@s4 /proc]# cat meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  261742592 122847232 138895360        0  1757184 88633344
Swap: 271392768        0 271392768
MemTotal:       255608 kB
MemFree:        135640 kB
MemShared:           0 kB
Buffers:          1716 kB
Cached:          86556 kB
Active:          15684 kB
Inact_dirty:     72588 kB
Inact_clean:         0 kB
Inact_target:       68 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255608 kB
LowFree:        135640 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB


-Dan




At 12:30 AM 12/7/2000 -0500, you wrote:

>backlog queue?  tuning /proc/sys/vm/*?
>
> > problem?  Is there any way I can get runtime information from the 
> kernel on
> > things like amount of socket memory used and amount available?  Am I using
>
>/proc/meminfo?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
