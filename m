Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269817AbUJTM7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269817AbUJTM7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270033AbUJTM5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:57:49 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:32684 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269817AbUJTMwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:52:09 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Date: Wed, 20 Oct 2004 14:52:01 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20041012195424.GA3961@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
In-Reply-To: <20041020094508.GA29080@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410201452.01317.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 11:45, Ingo Molnar wrote:
> 
> i have released the -U8 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8

------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:598!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: irtty_sir sir_dev irda crc_ccitt usbcore lp ipv6 dm_mod it87 i2c_isa i2c
CPU:    0
EIP:    0060:[<c01dfa5b>]    Not tainted VLI
EFLAGS: 00010287   (2.6.9-rc4-mm1-RT-U8) 
EIP is at up_write+0x1eb/0x200
eax: de848000   ebx: df3a255c   ecx: 0000001f   edx: c14e3260
esi: df3a24c8   edi: de848000   ebp: de849f7c   esp: de849f5c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kIrDAd (pid: 1295, threadinfo=de848000 task=df3d6110)
Stack: e09119bb de849f74 c0111590 df3a2400 0000001f df3a255c e0915000 de848000 
       de849f94 e09119bb df3a2400 00000282 de849fc4 00000000 de849fec e0911ae2 
       e09129c2 de849fb8 00000000 df3d6110 c01148d0 00000000 00000000 de84ff08 
Call Trace:
 [<e09119bb>] run_irda_queue+0x5b/0xd0 [sir_dev] (4)
 [<c0111590>] mcount+0x14/0x18 (8)
 [<e09119bb>] run_irda_queue+0x5b/0xd0 [sir_dev] (28)
 [<e0911ae2>] irda_thread+0xb2/0xf0 [sir_dev] (24)
 [<c01148d0>] default_wake_function+0x0/0x20 (20)
 [<c010612a>] ret_from_fork+0x6/0x14 (16)
 [<c01148d0>] default_wake_function+0x0/0x20 (16)
 [<e0911a30>] irda_thread+0x0/0xf0 [sir_dev] (24)
 [<c0104319>] kernel_thread_helper+0x5/0xc (12)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: die+0x3f/0x1a0 / (do_invalid_op+0x106/0x110)
.. entry 2: print_traces+0x1d/0x80 / (show_stack+0x83/0xa0)

Code: ff e9 44 ff ff ff 0f 0b a5 00 13 ce 2e c0 eb b6 0f 0b a4 00 13 ce 2e c0 eb a5 c7 04 2
 (events/0/3/CPU#0): new 785 us maximum-latency critical section.
 => started at timestamp 193385865: <kernel_fpu_begin+0x21/0x60>
 =>   ended at timestamp 193386650: <_mmx_memcpy+0x131/0x180>
 [<c012f070>] sub_preempt_count+0x60/0x90 (4)
 [<c012ed5e>] check_preempt_timing+0x15e/0x270 (8)
 [<c01e1a11>] _mmx_memcpy+0x131/0x180 (8)
 [<c012f070>] sub_preempt_count+0x60/0x90 (64)
 [<c01e1a11>] _mmx_memcpy+0x131/0x180 (8)
 [<c01e1a11>] _mmx_memcpy+0x131/0x180 (16)
 [<c01ee1d0>] vgacon_save_screen+0x80/0x90 (28)
 [<c021ba89>] redraw_screen+0x199/0x270 (28)
 [<c012e4ed>] __mcount+0x1d/0x20 (12)
 [<c0216d61>] complete_change_console+0x11/0x100 (4)
 [<c021ec86>] console_callback+0xe6/0xf0 (4)
 [<c0216d89>] complete_change_console+0x39/0x100 (28)
 [<c021ec86>] console_callback+0xe6/0xf0 (28)
 [<c0128e63>] worker_thread+0x1d3/0x2a0 (20)
 [<c021eba0>] console_callback+0x0/0xf0 (28)
 [<c01148d0>] default_wake_function+0x0/0x20 (28)
 [<c01148d0>] default_wake_function+0x0/0x20 (32)
 [<c0111590>] mcount+0x14/0x18 (12)
 [<c012d26a>] kthread+0xaa/0xb0 (28)
 [<c0128c90>] worker_thread+0x0/0x2a0 (20)
 [<c012d1c0>] kthread+0x0/0xb0 (12)
 [<c0104319>] kernel_thread_helper+0x5/0xc (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: kernel_fpu_begin+0x21/0x60 / (_mmx_memcpy+0x36/0x180)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 193387119
