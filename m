Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293426AbSBYQTV>; Mon, 25 Feb 2002 11:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293420AbSBYQTC>; Mon, 25 Feb 2002 11:19:02 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:38898 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S293336AbSBYQSs>; Mon, 25 Feb 2002 11:18:48 -0500
To: Justin Piszcz <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C771D29.942A07C2@starband.net>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3C771D29.942A07C2@starband.net>
Date: 25 Feb 2002 17:08:42 +0100
Message-ID: <m2n0xxo86t.fsf@localhost.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "justin" == Justin Piszcz <war@starband.net> writes:

justin> Wow, not sure if anyone here has done any benchmarks, but look at these
justin> build times:
justin> Kernel 2.4.17 did compile with 3.0.4, just much much slower than 2.95.3
justin> however.

justin> GCC 2.95.3
justin> Boot sector 512 bytes.
justin> Setup is 2628 bytes.
justin> System is 899 kB
justin> make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
justin> 287.28user 23.99system 5:15.81elapsed 98%CPU (0avgtext+0avgdata
justin> 0maxresident)k
justin> 0inputs+0outputs (514864major+684661minor)pagefaults 0swaps

justin> GCC 3.0.4
justin> Boot sector 512 bytes.
justin> Setup is 2628 bytes.
justin> System is 962 kB
justin> warning: kernel is too big for standalone boot from floppy
justin> make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
justin> 406.87user 28.38system 7:23.68elapsed 98%CPU (0avgtext+0avgdata
justin> 0maxresident)k
justin> 0inputs+0outputs (546562major+989237minor)pagefaults 0swaps

Hi, here the times chaned with the lastest 3.0.4, this is the first
3.0 compiler that is faster than 2.96 here.  Compilation of a mdk
kernel (i.e. a kernel with everthing as modules).

(I compiled twice with both compilers & there are not variances).

2.96
2018.76user 159.29system 18:13.20elapsed 199%CPU (0avgtext+0avgdata 0maxresident
)k
0inputs+0outputs (4007797major+8765072minor)pagefaults 0swaps

gcc-3.0.4
1797.23user 133.06system 16:07.98elapsed 199%CPU (0avgtext+0avgdata 0maxresident
)k
0inputs+0outputs (3569637major+8775450minor)pagefaults 0swaps

And the size differences are not as big as they used to be:

root$ ls -l vmlinux*
-rwxr-xr-x    1 root     root      3177771 Feb 24 18:06 vmlinux*
-rwxr-xr-x    1 root     root      3206468 Feb 24 17:47 vmlinux-3.0.4*
root$ size vmlinux*
   text    data     bss     dec     hex filename
2253010  301448  423008 2977466  2d6eba vmlinux
2294630  304924  423008 3022562  2e1ee2 vmlinux-3.0.4

Until now, gcc-3.0 binaryes tend to be quite bigger than gcc-2.96.

root$ rpm -qa | grep gcc | grep -v cpp
gcc-2.96-0.76mdk
libgcc3.0-3.0.4-1mdk
gcc3.0-3.0.4-1mdk


Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
