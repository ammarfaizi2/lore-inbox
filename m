Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTB1DP6>; Thu, 27 Feb 2003 22:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTB1DP5>; Thu, 27 Feb 2003 22:15:57 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:10300 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S267438AbTB1DP4>; Thu, 27 Feb 2003 22:15:56 -0500
Message-ID: <3E5ED13B.3E92E287@us.ibm.com>
Date: Thu, 27 Feb 2003 19:02:20 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.5.63 BUG in deadline-iosched.c
References: <3E5E70E0.36937042@us.ibm.com> <20030227144749.48e8e0f1.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Janet Morgan <janetmor@us.ibm.com> wrote:
> >
> > I got this on 2.5.63 while running the "find" command:
> >
> > kernel BUG at drivers/block/deadline-iosched.c:145!
> > invalid operand: 0000
> > CPU:    3
> > EIP:    0060:[<c026f8a1>]    Not tainted
> > EFLAGS: 00010046
> > EIP is at deadline_find_drq_hash+0x41/0xb0
> > eax: f76fe060   ebx: f76fe058   ecx: f76fe060   edx: 00000000
> > esi: f76fe060   edi: f76fe044   ebp: f76fe050   esp: f7e27c88
> > ds: 007b   es: 007b   ss: 0068
> > Process pdflush (pid: 16, threadinfo=f7e26000 task=c3b39300)
> > Stack: 010d7ce6 00000000 f7fd2ae0 f7fd2ae0 f7fd2ae0 f7747f80 c026fbc9
> > f7747f80
> >        010d7ce6 00000000 f7747f80 00000000 f7759000 f7759000 00000008
> > c026a438
> >        f7759000 f7e27cf8 f7fd2ae0 c026cc58 f7759000 f7e27cf8 f7fd2ae0
> > 010d7ce6
> > Call Trace:
> >  [<c026fbc9>] deadline_merge+0x49/0x120
> >  [<c026a438>] elv_merge+0x18/0x30
> >  [<c026cc58>] __make_request+0xb8/0x440
>
> Nick, could this be caused by a stale next_drq[] entry?
>
> If so,
>
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.63/2.5.63-mm1/broken-out/deadline-dispatching-fix.patch
>
> is designed to fix it.

Thanks Andrew.  2.5.63-mm1 fixes the problem.

