Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWEaVEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWEaVEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWEaVEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:04:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965006AbWEaVEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:04:06 -0400
Date: Wed, 31 May 2006 14:06:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531140652.054e2e45.akpm@osdl.org>
In-Reply-To: <447DEF49.9070401@google.com>
References: <447DEF49.9070401@google.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> wrote:
>
> The x86_65 panic in LTP has changed a bit. Looks more useful now.
> Possibly just unrelated new stuff. Possibly we got lucky.
> 
> M
> 
> 
> http://test.kernel.org/abat/33807/debug/console.log
> 
> nable to handle kernel paging request at 0000000000001034 RIP:
>   [<ffffffff8048c5c4>] __sched_text_start+0x51c/0x745
> PGD 1d836a067 PUD 1e2704067 PMD 0
> Oops: 0002 [1] SMP
> last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
> CPU 0
> Modules linked in:
> Pid: 230, comm: kswapd0 Not tainted 2.6.17-rc5-mm1-autokern1 #1
> RIP: 0010:[<ffffffff8048c5c4>]  [<ffffffff8048c5c4>] 
> __sched_text_start+0x51c/0x745
> RSP: 0000:ffff810100237b48  EFLAGS: 00010093
> RAX: ffff8100e3c592b0 RBX: 0000000000000d84 RCX: ffffffff805f0cd8
> RDX: 000000003b9a078a RSI: ffff8100e3c590d0 RDI: 000000000007989e
> RBP: ffff810100237be8 R08: ffff81007bfec930 R09: ffff81007bfec8e8
> R10: ffff81007bfec8e8 R11: ffff81007ff3c2d8 R12: 0000000000000000
> R13: ffff8101fd8ec140 R14: ffff810001011680 R15: 000002b3bb3b33a4
> FS:  0000000000000000(0000) GS:ffffffff8061c000(0000) knlGS:00000000f7db6460
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000001034 CR3: 00000001f18fa000 CR4: 00000000000006e0
> Process kswapd0 (pid: 230, threadinfo ffff810100236000, task 
> ffff8100e3c590d0)
> Stack: ffff81007bfec8e8 ffff81007bfec8e8 ffffffff805f0cd8 000000007ff3c2d8
>         ffff8100e3c590d0 000000000000c276 ffffffff805f0cd8 ffff8100e3c592b0
>         ffff81007be407b0 ffff81007be407b0
> Call Trace:
>   [<ffffffff8024d24c>] __remove_from_page_cache+0x1c/0x65
>   [<ffffffff8048d16c>] cond_resched+0x4c/0x7b
>   [<ffffffff8025783d>] shrink_inactive_list+0x125/0x882
>   [<ffffffff8048c7ed>] thread_return+0x0/0xd1
>   [<ffffffff80258493>] shrink_zone+0xd2/0xf3
>   [<ffffffff80258a4b>] kswapd+0x359/0x49b
>   [<ffffffff8023e51c>] autoremove_wake_function+0x0/0x37
>   [<ffffffff802586f2>] kswapd+0x0/0x49b
>   [<ffffffff8023dff8>] kthread+0xd0/0xfc
>   [<ffffffff8020a34e>] child_rip+0x8/0x12
>   [<ffffffff8023df28>] kthread+0x0/0xfc
>   [<ffffffff8020a346>] child_rip+0x0/0x12

What are you doing to make this happen?
