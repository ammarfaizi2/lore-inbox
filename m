Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131394AbRBMObL>; Tue, 13 Feb 2001 09:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131585AbRBMObB>; Tue, 13 Feb 2001 09:31:01 -0500
Received: from [64.64.109.142] ([64.64.109.142]:12808 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131394AbRBMOa4>; Tue, 13 Feb 2001 09:30:56 -0500
Message-ID: <3A8944F1.93C252EB@didntduck.org>
Date: Tue, 13 Feb 2001 09:30:09 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Rode <Martin.Rode@programmfabrik.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG in sched.c, Kernel 2.4.1?
In-Reply-To: <3A8942FA.484BE2FC@programmfabrik.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Rode wrote:
> 
> After upgrading to kernel 2.4.1 my box locked hard after starting the
> regular arkeia backup. I had previously problems with MM on kernel
> 2.2.18 and > 2.2.19pre2. My report a few days ago is still unanswered.
> 
> I would be glad if someone would be comment this time.
> 
> Here's the typed crash dump:
> 
> st0: Block limits 1 - 16777215 bytes.
> Scheduling an interrupt
> kernel BUG at sched.c:714!
> invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c0113781>]
> EFLAGS: 00010282
> eax: 0000001b ebx 00000000 ecx df4f6000 edx 00000001
> esi: 001cffe3 edi db5eede0 ebp dc0e9f40 esp dc0e9ef0
> ds 0018 es 0018 ss 0018
> process o3flow (pid 13180 stackpage dc0e9000)
> stack: c01f26f3 c01f2856 000002ca db5eed80 dc0e8000 db5eede0 dc0e9f18
> dc0e8000 000033ba 00000000 00000000 000000e7 0000001c 0000001c
> fffffff3 dc0e8000 00000800 00000000 dc0e8000 dc0e9f68 c0139c44
> d488bf80 00000000
> 
> call trace: [<cc0139c44>] [<c0139d1c>] [<c0130af6>] [<c0108e93>]
> 
> code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 8d 76 00 55 89 e5 83 ec
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

Run this oops message through ksymoops please.  It will make debugging
it alot easier.

--

				Brian Gerst
