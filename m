Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUJNUGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUJNUGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUJNUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:03:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33264 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267505AbUJNUCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:02:31 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041014002433.GA19399@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu>  <20041014002433.GA19399@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097784144.5310.13.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Oct 2004 13:02:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure about this one ..


------------[ cut here ]------------
kernel BUG at fs/buffer.c:1360!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c01619c1>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc4-mm1-VP-U1)
EIP is at __find_get_block+0xe1/0x100
eax: 00000001   ebx: cfd30c14   ecx: cffdc600   edx: 00000000
esi: 0005709b   edi: 00000000   ebp: cfd30b70   esp: cfd30b54
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kjournald (pid: 786, threadinfo=cfd30000 task=cfd26040)
Stack: 00000002 00000000 0005709b 00000000 cfd30c14 0005709b 00000000
cfd30b94
       c01619fe cffeab80 0005709b 00000000 00001000 cfd30c14 00000002
cfd30c44
       cfd30bac c0161a99 cffeab80 0005709b 00000000 00001000 cfd30bd4
c019aff0
Call Trace:
 [<c01619fe>] __getblk+0x1e/0x60
 [<c0161a99>] __bread+0x19/0x40
 [<c019aff0>] ext3_get_branch+0x70/0x100
 [<c019b61a>] ext3_get_block_handle+0x7a/0x2e0
 [<c026b1ee>] as_choose_req+0xe/0x1e0
 [<c026bc5f>] as_update_arq+0x1f/0x60
 [<c019b8c3>] ext3_get_block+0x43/0x80
 [<c0163735>] generic_block_bmap+0x35/0x40
 [<c0134c73>] __mcount+0x13/0x20
 [<c019c26d>] ext3_bmap+0xd/0xa0
 [<c01797c5>] bmap+0x45/0x60
 [<c019c2dc>] ext3_bmap+0x7c/0xa0
 [<c019b880>] ext3_get_block+0x0/0x80
 [<c01797c5>] bmap+0x45/0x60
 [<c01af8c2>] journal_bmap+0x42/0xa0
 [<c0134c73>] __mcount+0x13/0x20
 [<c0134249>] _mutex_unlock+0x9/0x60
 [<c01af827>] journal_next_log_block+0x47/0xa0
 [<c0113d30>] mcount+0x14/0x18
 [<c01af832>] journal_next_log_block+0x52/0xa0
 [<c01af939>] journal_get_descriptor_buffer+0x19/0xc0
 [<c01ac4ec>] journal_commit_transaction+0xf6c/0x13e0
 [<c01aedee>] kjournald+0xce/0x260
 [<c013555c>] sub_preempt_count+0x7c/0xa0
 [<c0133d00>] autoremove_wake_function+0x0/0x60
 [<c03b2a33>] _spin_unlock_irq+0x13/0x40
 [<c0133d00>] autoremove_wake_function+0x0/0x60
 [<c0119459>] schedule_tail+0x19/0x60
 [<c01aece0>] commit_timeout+0x0/0x20
 [<c01aed20>] kjournald+0x0/0x260
 [<c0103339>] kernel_thread_helper+0x5/0xc
Code: 45 14 39 43 10 75 a0 85 ff 74 17 8b 45 e4 89 f9 8d 14 b8 8b 42 fc
89 02 83 ea 04
                                                                                      

