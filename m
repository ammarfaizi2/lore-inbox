Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSLMPUn>; Fri, 13 Dec 2002 10:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLMPUm>; Fri, 13 Dec 2002 10:20:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54918 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264767AbSLMPUl>; Fri, 13 Dec 2002 10:20:41 -0500
Date: Fri, 13 Dec 2002 10:30:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org, Andrew Walrond <andrew@walrond.org>
Subject: Re: Symlink indirection
In-Reply-To: <200212131611.04355.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002, Marc-Christian Petersen wrote:

> On Friday 13 December 2002 16:06, Andrew Walrond wrote:
> 
> Hi Andrew,
> 
> > Is the number of allowed levels of symlink indirection (if that is the
> > right phrase; I mean symlink -> symlink -> ... -> file) dependant on the
> > kernel, or libc ? Where is it defined, and can it be changed?
> 
> fs/namei.c
> 
>  if (current->link_count >= 5)
> 
> change to a higher value.
> 
> So, the answer is: Kernel :)
> 
> ciao, Marc

No, that thing (whetever it is) is different.

Script started on Fri Dec 13 10:26:30 2002
# file *
foo:        symbolic link to ../foo
typescript: empty
# pwd
/root/foo
# cd *
# cd *
# cd *
# cd *
# cd *
# cd *
# pwd
/root/foo/foo/foo/foo/foo/foo/foo
# cd *
# cd *
# cd *
# pwd
/root/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo
# cd *
# cd *
# cd *
# pwd
/root/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo
# exit
exit

Script done on Fri Dec 13 10:27:21 2002


You can do this until you run out of string-space. Your "link-count"
has something to do with something else.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


