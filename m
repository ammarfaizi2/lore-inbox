Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSJYNrb>; Fri, 25 Oct 2002 09:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJYNrb>; Fri, 25 Oct 2002 09:47:31 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:46052 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261407AbSJYNra> convert rfc822-to-8bit; Fri, 25 Oct 2002 09:47:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Sat, 26 Oct 2002 00:03:06 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021018145204.GG23930@dualathlon.random> <200210240026.36642.harisri@bigpond.com> <20021023143515.GE1912@dualathlon.random>
In-Reply-To: <20021023143515.GE1912@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210260003.06285.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

[I tried to post the reply through groups.google.com, and it looks like it 
didn't get to lkml. :( ]

> try to apply all the scheduler related patches:
>
> 10_sched-o1-hyperthreading-3  20_apm-o1-sched-1  20_sched-o1-fixes-5
> 21_o1-A4-aa-1 20_rcu-poll-7

OK.

I have applied the patches 0* and the following patches in this order:
10_sched-o1-hyperthreading-3
20_apm-o1-sched-1
20_rcu-poll-7
20_sched-o1-fixes-5
21_o1-A4-aa-1

The resulting kernel is very stable and it does not crash.

Then I tried patches [01]* and the extra patches (20_apm-o1-sched-1,
20_rcu-poll-7, 20_sched-o1-fixes-5, 21_o1-A4-aa-1), I couldn't compile
the kernel.

Here is the current std_err:

inode.c:1468: warning: initialization from incompatible pointer type
In file included from ide.c:149:
/usr/src/01/include/linux/ide.h:333:16: warning: ISO C requires
whitespace after the macro name
ide.c: In function `init_hwif_data':
ide.c:270: `ide_disk' undeclared (first use in this function)
ide.c:270: (Each undeclared identifier is reported only once
ide.c:270: for each function it appears in.)
ide.c: In function `ide_geninit':
ide.c:639: `ide_disk' undeclared (first use in this function)
ide.c: In function `do_reset1':
ide.c:791: `ide_disk' undeclared (first use in this function)
ide.c: In function `ide_dump_status':
ide.c:973: `ide_disk' undeclared (first use in this function)
ide.c: In function `try_to_flush_leftover_data':
ide.c:1034: `ide_disk' undeclared (first use in this function)
ide.c: In function `ide_error':
ide.c:1071: `ide_disk' undeclared (first use in this function)
ide.c: In function `start_request':
ide.c:1373: `ide_disk' undeclared (first use in this function)
ide.c: In function `ide_open':
ide.c:2119: `ide_disk' undeclared (first use in this function)
ide.c: In function `ide_reinit_drive':
ide.c:2768: `ide_disk' undeclared (first use in this function)
ide.c: In function `ide_ioctl':
ide.c:2842: `ide_disk' undeclared (first use in this function)
ide.c: In function `ide_setup':
ide.c:3383: `ide_disk' undeclared (first use in this function)
make[3]: *** [ide.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_ide] Error 2
make: *** [_dir_drivers] Error 2
make: *** Waiting for unfinished jobs....
{standard input}: Assembler messages:
{standard input}:1014: Warning: indirect lcall without `*'
{standard input}:1091: Warning: indirect lcall without `*'
{standard input}:1176: Warning: indirect lcall without `*'
{standard input}:1255: Warning: indirect lcall without `*'
{standard input}:1271: Warning: indirect lcall without `*'
{standard input}:1281: Warning: indirect lcall without `*'
{standard input}:1349: Warning: indirect lcall without `*'
{standard input}:1364: Warning: indirect lcall without `*'
{standard input}:1375: Warning: indirect lcall without `*'
{standard input}:1874: Warning: indirect lcall without `*'
{standard input}:1960: Warning: indirect lcall without `*'

Thanks.
-- 
Hari
harisri@bigpond.com


