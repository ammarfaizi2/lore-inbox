Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273534AbRI3OYh>; Sun, 30 Sep 2001 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273535AbRI3OYS>; Sun, 30 Sep 2001 10:24:18 -0400
Received: from portal.suidrewt.org ([195.13.119.227]:31391 "EHLO
	portal.suidrewt.org") by vger.kernel.org with ESMTP
	id <S273534AbRI3OYO>; Sun, 30 Sep 2001 10:24:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Zombie Processes, No Child Process errors
Message-Id: <E15niPg-0006Dm-00@portal.suidrewt.org>
From: "Dope on Plaztic,,," <pip@suidrewt.org>
Date: Sun, 30 Sep 2001 15:21:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have been experiencing problems with my Linux box (Debian 2.2, SID,
pIII 500, 128mb) concerning 'zombie processes' and 'no child process'
errors.

Zombie: For example, i `cat` a file, and nothing happens, i ctrl+c 
from it, and i look in `ps` output, i see [cat <defunct>] - this has 
happend with gzip, tar, more, etc.  I have no clue why this is happening
and to my knowledge i havent' done anything which would cause this.

No Child Process:
[1]
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
rm -f tools/build
Putting child 0x08074140 (clean) PID 745 on the chain.
Live child 0x08074140 (clean) PID 745
make[1]: *** wait: No child processes.  Stop.
make[1]: *** Waiting for unfinished jobs....
Live child 0x08074140 (clean) PID 745
make[1]: *** wait: No child processes.  Stop.
Got a SIGCHLD; 1 unreaped children.
Reaping losing child 0x0808a928 PID 744
make: *** [archclean] Error 2
Removing child 0x0808a928 PID 744  from chain.
(root@mischief):/usr/src/linux#

As you can see, this makes it impossible to compile various applications,
including a new kernel :).  That output is from `make` with a debug flag.

I have experience the same 'no child processes' errors with `tar` too.  Again
I have not done anything to my knowledge which would cause this.

I have tried new ram chips, etc, to no avail.  Also, on a clean kernel and 
patched up(with grsecurity, no-exec stack etc).  

PLEASE can you CC: me the replies to this, as i have not yet subscribed.
Thanks a lot,
pip
(Please forgive me if this is not a kernel based problem, i am exploring
all avenues :)
