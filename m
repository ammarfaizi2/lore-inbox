Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSJWOLP>; Wed, 23 Oct 2002 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbSJWOLP>; Wed, 23 Oct 2002 10:11:15 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:59891 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265023AbSJWOLN> convert rfc822-to-8bit; Wed, 23 Oct 2002 10:11:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Thu, 24 Oct 2002 00:26:36 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021018145204.GG23930@dualathlon.random> <200210232227.47721.harisri@bigpond.com> <20021023124659.GF30182@dualathlon.random>
In-Reply-To: <20021023124659.GF30182@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210240026.36642.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Wednesday 23 October 2002 22:46, Andrea Arcangeli wrote:
> Ok, please try to backout 2.4.20pre11aa1/00_reduce-module-races-1.
> I just moved it into the 20 serie. that should fix this bit.

Yes I did that. I renamed it to _00_reduce-module-races-1, and did the 
patching again.

But that did not help. Here is the current std_err:

exit.c: In function `release_task':
exit.c:44: warning: implicit declaration of function `sched_exit'
shmem.c: In function `shmem_getpage_locked':
shmem.c:560: warning: unused variable `flags'
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
init_task.c:3:34: linux/sched_runqueue.h: No such file or directory
make[1]: *** [init_task.o] Error 1
make: *** [_dir_arch/i386/kernel] Error 2

Thanks.
-- 
Hari
harisri@bigpond.com

