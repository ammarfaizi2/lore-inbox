Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132882AbRAJJjn>; Wed, 10 Jan 2001 04:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131846AbRAJJjd>; Wed, 10 Jan 2001 04:39:33 -0500
Received: from fritz.st-and.ac.uk ([138.251.24.9]:30674 "EHLO
	fritz.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id <S135185AbRAJJjT>; Wed, 10 Jan 2001 04:39:19 -0500
Message-Id: <l03130302b681de2fd7a0@[138.251.135.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 10 Jan 2001 09:39:05 +0000
To: linux-kernel@vger.kernel.org
From: Mark Hindley <mh15@st-andrews.ac.uk>
Subject: 2.4.0 kernel paging error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running 2.4.0 final. I got the following failed paging request which
produced a complete freeze.

As you can see it was precipitated by cron starting to run some
housekeeping stuff overnight.

Has anyone else had prblems?


Mark

Jan 10 02:25:01 hindleyhome /USR/SBIN/CRON[3823]: (root) CMD (test -e
/usr/sbin/anacron || run-parts --report /etc/cron.daily)
Jan 10 02:30:01 hindleyhome /USR/SBIN/CRON[3827]: (root) CMD (/sbin/rmmod -a)
Jan 10 02:30:01 hindleyhome /USR/SBIN/CRON[3828]: (root) CMD (test -x
/usr/sbin/anacron && /usr/sbin/anacron -s)
Jan 10 02:30:01 hindleyhome anacron[3830]: Anacron 2.1 started on 2001-01-10
Jan 10 02:30:01 hindleyhome anacron[3830]: Will run job `cron.daily' in 5 min.
Jan 10 02:30:01 hindleyhome anacron[3830]: Jobs will be executed sequentially
Jan 10 02:35:01 hindleyhome /USR/SBIN/CRON[3832]: (root) CMD (/sbin/rmmod -a)
Jan 10 02:35:01 hindleyhome anacron[3830]: Job `cron.daily' started
Jan 10 02:35:01 hindleyhome anacron[3836]: Updated timestamp for job
`cron.daily' to 2001-01-10
Jan 10 02:35:53 hindleyhome kernel: Unable to handle kernel paging request
at virtual address c4870840
Jan 10 02:35:53 hindleyhome kernel:  printing eip:
Jan 10 02:35:53 hindleyhome kernel: c013d747
Jan 10 02:35:53 hindleyhome kernel: *pde = 03d61063
Jan 10 02:35:53 hindleyhome kernel: *pte = 00000000
Jan 10 02:35:53 hindleyhome kernel: Oops: 0000
Jan 10 02:35:53 hindleyhome kernel: CPU:    0
Jan 10 02:35:53 hindleyhome kernel: EIP:    0010:[clear_inode+159/216]
Jan 10 02:35:53 hindleyhome kernel: EFLAGS: 00010282
Jan 10 02:35:53 hindleyhome kernel: eax: c4870820   ebx: c338f4a0   ecx:
c338f4a8   edx: c1169fa4
Jan 10 02:35:53 hindleyhome kernel: esi: c1169fa4   edi: c1dccde8   ebp:
c1169fac   esp: c1169f78
Jan 10 02:35:53 hindleyhome kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 02:35:53 hindleyhome kernel: Process kswapd (pid: 3, stackpage=c1169000)
Jan 10 02:35:53 hindleyhome kernel: Stack: c338f4a0 c013d7bf c338f4a0
c1dccc08 c1dccc00 c013d9c2 c1169fa4 000000ee
Jan 10 02:35:53 hindleyhome kernel:        00000004 00000000 000003b3
c2c8fde8 c3e38bc8 00000000 c013d9f1 00000000
Jan 10 02:35:53 hindleyhome kernel:        c0126453 00000006 00000004
00000006 00000004 00010f00 c01d32d7 c1168239
Jan 10 02:35:53 hindleyhome kernel: Call Trace: [dispose_list+63/88]
[prune_icache+234/248] [shrink_icache_memory+33/48]
[do_try_to_free_pages+91/128] [kswapd+116/272] [kernel_thread+40/56]
Jan 10 02:35:53 hindleyhome kernel:
Jan 10 02:35:53 hindleyhome kernel: Code: 8b 40 20 85 c0 74 06 53 ff d0 83
c4 04 8b 83 e0 00 00 00 85


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
