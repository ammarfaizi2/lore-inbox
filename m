Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265025AbSJWO3H>; Wed, 23 Oct 2002 10:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265030AbSJWO3H>; Wed, 23 Oct 2002 10:29:07 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11563 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265025AbSJWO3G>; Wed, 23 Oct 2002 10:29:06 -0400
Date: Wed, 23 Oct 2002 16:35:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021023143515.GE1912@dualathlon.random>
References: <20021018145204.GG23930@dualathlon.random> <200210232227.47721.harisri@bigpond.com> <20021023124659.GF30182@dualathlon.random> <200210240026.36642.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210240026.36642.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 12:26:36AM +1000, Srihari Vijayaraghavan wrote:
> Hello Andrea,
> 
> On Wednesday 23 October 2002 22:46, Andrea Arcangeli wrote:
> > Ok, please try to backout 2.4.20pre11aa1/00_reduce-module-races-1.
> > I just moved it into the 20 serie. that should fix this bit.
> 
> Yes I did that. I renamed it to _00_reduce-module-races-1, and did the 
> patching again.
> 
> But that did not help. Here is the current std_err:
> 
> exit.c: In function `release_task':
> exit.c:44: warning: implicit declaration of function `sched_exit'
> shmem.c: In function `shmem_getpage_locked':
> shmem.c:560: warning: unused variable `flags'
> {standard input}: Assembler messages:
> {standard input}:1014: Warning: indirect lcall without `*'
> {standard input}:1091: Warning: indirect lcall without `*'
> {standard input}:1176: Warning: indirect lcall without `*'
> {standard input}:1255: Warning: indirect lcall without `*'
> {standard input}:1271: Warning: indirect lcall without `*'
> {standard input}:1281: Warning: indirect lcall without `*'
> {standard input}:1349: Warning: indirect lcall without `*'
> {standard input}:1364: Warning: indirect lcall without `*'
> {standard input}:1375: Warning: indirect lcall without `*'
> {standard input}:1874: Warning: indirect lcall without `*'
> {standard input}:1960: Warning: indirect lcall without `*'
> init_task.c:3:34: linux/sched_runqueue.h: No such file or directory
> make[1]: *** [init_task.o] Error 1
> make: *** [_dir_arch/i386/kernel] Error 2

try to apply all the scheduler related patches:

10_sched-o1-hyperthreading-3  20_apm-o1-sched-1  20_sched-o1-fixes-5
21_o1-A4-aa-1 20_rcu-poll-7

Andrea
