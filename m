Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282336AbRKXBqH>; Fri, 23 Nov 2001 20:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282337AbRKXBp6>; Fri, 23 Nov 2001 20:45:58 -0500
Received: from [209.250.53.159] ([209.250.53.159]:47888 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S282336AbRKXBpu>; Fri, 23 Nov 2001 20:45:50 -0500
Date: Fri, 23 Nov 2001 19:42:49 -0600
From: Steven Walter <srwalter@yahoo.com>
To: listmail@majere.epithna.com
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: Error: compiling with preempt-kernel-rml-2.4.15-1.patch
Message-ID: <20011123194249.A5258@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	listmail@majere.epithna.com, linux-kernel@vger.kernel.org,
	rml@tech9.net
In-Reply-To: <Pine.LNX.4.33.0111231906210.3406-100000@majere.epithna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111231906210.3406-100000@majere.epithna.com>; from listmail@majere.epithna.com on Fri, Nov 23, 2001 at 07:13:50PM -0500
X-Uptime: 7:33pm  up 26 days,  2:10,  1 user,  load average: 1.13, 1.10, 1.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 07:13:50PM -0500, listmail@majere.epithna.com wrote:
> I applied the preempt-kernel-rml-2.4.15-1.patch file to a clean
> just untarred 2.14.15 kernel source, and began to compile got the
> following error.
> I know the source is good, I compiled a non-patched Kernel from the same
> archive earlier, re-extracted after the error, repeated, redownloaded,
> reextracted. repeated.
>
> make[2]: Entering directory `/usr/src/linux/kernel'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686    -fno-omit-frame-pointer
> -c -o sched.o sched.c
> sched.c: In function `__schedule_tail':
> sched.c:509: structure has no member named `has_cpu'
> make[2]: *** [sched.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/kernel'
> make: *** [_dir_kernel] Error 2
> root@majere:/usr/src/linux#

Looks like the patch misses a place to has x->has_cpu to task_has_cpu(x)
Shouldn't be difficult for you to change it.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
