Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263014AbTCSPtF>; Wed, 19 Mar 2003 10:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbTCSPtF>; Wed, 19 Mar 2003 10:49:05 -0500
Received: from ligur.expressz.com ([212.24.178.154]:1162 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S263014AbTCSPtE>;
	Wed, 19 Mar 2003 10:49:04 -0500
Date: Wed, 19 Mar 2003 17:00:01 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrus <andrus@members.ee>
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED UNTILL NOW!)
In-Reply-To: <Pine.LNX.3.96.1030319154022.28099C-100000@ligur.expressz.com>
Message-ID: <Pine.LNX.3.96.1030319165504.29781C-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, BODA Karoly jr. wrote:

> 	Well for me it didn't work on those kernels (all was i386 "of
> course"): 
> 2.4.19-pre6aa1
> 2.4.21-pre4aa1
> 2.4.21-pre4aa3
> 2.2.16pre7

	I must fix this. On those kernels WORKS the exploit. :( I've tried
lots of times (>100) to run simply the exploit didn't work. But when I
wanted to trace what the difference is it was working. :( I didn't try 
the other versions I think it will work too... strace of course is not
setuid root. Here it goes:

woockie@death:~/tmp$ ls -l ptrace
-rwxr-xr-x    1 woockie  woockie      9031 Mar 19 14:59 ptrace
woockie@death:~/tmp$ strace -o /dev/null -f -F ./ptrace
Process 4003 attached
[+] Attached to 4004
[+] Signal caught
[+] Shellcode placed at 0x4000da2d
umovestr: Input/output error
[+] Now wait for suid shell...
Process 4005 attached
Process 4002 suspended
Process 4003 detached
PTRACE_ATTACH: Operation not permitted
Too late?
PTRACE_ATTACH: Operation not permitted
Too late?



[1]+  Stopped                 strace -o /dev/null -f -F ./ptrace
woockie@death:~/tmp$ killall strace
woockie@death:~/tmp$ ls -l ptrace
-rwsr-sr-x    1 root     root         9031 Mar 19 14:59 ptrace
woockie@death:~/tmp$ ./ptrace
root@death:~/tmp#


-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

P.S.: sorry for the previous mail :( Can anyone explain me why this works
only this way?

