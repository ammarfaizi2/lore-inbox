Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSKDUuI>; Mon, 4 Nov 2002 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSKDUuI>; Mon, 4 Nov 2002 15:50:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:15316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262750AbSKDUuH>;
	Mon, 4 Nov 2002 15:50:07 -0500
Subject: Re: [PATCH] performance counters 3.1 for 2.5.45 [4/4]: kernel
	changes
From: Stephen Hemminger <shemminger@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <15814.55581.459295.2217@kim.it.uu.se>
References: <200210312310.AAA07615@kim.it.uu.se>
	<1036440740.18668.5.camel@dell_ss3.pdx.osdl.net> 
	<15814.55581.459295.2217@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 12:56:36 -0800
Message-Id: <1036443396.18668.16.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 12:31, Mikael Pettersson wrote:
> Stephen Hemminger writes:
>  > On Thu, 2002-10-31 at 15:10, Mikael Pettersson wrote:
>  > > This is part 4 of 4 of perfctr-3.1 for the 2.5.45 kernel:
>  > > kernel changes to integrate the low and high-level drivers.
> ...
>  > 
>  > Rather than adding yet another system call, shouldn't this be done by
>  > extending the cpu part of sysfs (or /proc)?
> 
> Why?
> ptrace() is a system call
> fork() is a system call
> write() is a system call
> other arch's performance counter interfaces are system calls
> ...

ptrace predates /proc, and /proc is gradually superseding ptrace.
Eventually it is hoped that ptrace dies.

Other architecture's added performance counters back in 2.4 before sysfs
was added.

The reason to use a file system rather than a syscall is so that
standard tools like sh, awk, perl, ... can be used on the data without
having to build a separate command to access the data.

Linus is more likely to adopt simpler logical interfaces.


