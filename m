Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUIVRbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUIVRbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUIVRbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:31:50 -0400
Received: from mail3.utc.com ([192.249.46.192]:35991 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266149AbUIVRbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:31:12 -0400
Message-ID: <4151B6B8.6000201@cybsft.com>
Date: Wed, 22 Sep 2004 12:30:32 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Oops in __posix_lock_file was:Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S2
References: <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
In-Reply-To: <20040921074426.GA10477@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S2 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S2
> 

I don't know if this one has been fixed in S3 or not but I also saw this 
in S1 I think. This just happened when I booted back into S2 so I 
thought I would report it.

kr


Sep 22 12:00:44 porky kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Sep 22 12:00:44 porky kernel:  printing eip:
Sep 22 12:00:44 porky kernel: c01776dd
Sep 22 12:00:44 porky kernel: *pde = 00000000
Sep 22 12:00:44 porky kernel: using smp_processor_id() in preemptible 
code: mingetty/2667
Sep 22 12:00:44 porky kernel:  [<c011c58e>] smp_processor_id+0x8e/0xa0
Sep 22 12:00:44 porky kernel:  [<c01078b8>] die+0x18/0x190
Sep 22 12:00:44 porky kernel:  [<c0121675>] vprintk+0x125/0x170
Sep 22 12:00:44 porky kernel:  [<c012153d>] printk+0x1d/0x30
Sep 22 12:00:44 porky kernel:  [<c011958d>] do_page_fault+0x32d/0x621
Sep 22 12:00:44 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 22 12:00:44 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 22 12:00:44 porky kernel:  [<c02b3f9a>] _spin_unlock+0x1a/0x40
Sep 22 12:00:44 porky init: open(/dev/pts/0): No such file or directory
Sep 22 12:00:44 porky kernel:  [<c0138512>] check_preempt_timing+0x192/0x200
Sep 22 12:00:45 porky init: open(/dev/pts/0): No such file or directory
Sep 22 12:00:45 porky kernel:  [<c02b3f9a>] _spin_unlock+0x1a/0x40
Sep 22 12:00:45 porky kernel:  [<c014a8a3>] kmem_cache_alloc+0x63/0x70
Sep 22 12:00:45 porky kernel:  [<c02b314e>] cond_resched+0xe/0x80
Sep 22 12:00:45 porky kernel:  [<c0119260>] do_page_fault+0x0/0x621
Sep 22 12:00:45 porky kernel:  [<c0107175>] error_code+0x2d/0x38
Sep 22 12:00:45 porky kernel:  [<c01776dd>] __posix_lock_file+0x6d/0x5a0
Sep 22 12:00:45 porky kernel:  [<c0176a2e>] flock_to_posix_lock+0xe/0x170
Sep 22 12:00:45 porky kernel:  [<c0178bd6>] fcntl_setlk+0x166/0x2d0
Sep 22 12:00:45 porky kernel:  [<c01b3fd8>] dummy_file_lock+0x8/0x10
Sep 22 12:00:45 porky kernel:  [<c0178c0f>] fcntl_setlk+0x19f/0x2d0
Sep 22 12:00:45 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 22 12:00:45 porky kernel:  [<c02b3f9a>] _spin_unlock+0x1a/0x40
Sep 22 12:00:45 porky kernel:  [<c0138512>] check_preempt_timing+0x192/0x200
Sep 22 12:00:45 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 22 12:00:45 porky kernel:  [<c02b3f9a>] _spin_unlock+0x1a/0x40
Sep 22 12:00:45 porky kernel:  [<c01747d2>] sys_fcntl64+0xa2/0xc0
Sep 22 12:00:45 porky kernel:  [<c0174501>] do_fcntl+0x11/0x1c0
Sep 22 12:00:45 porky kernel:  [<c01745f5>] do_fcntl+0x105/0x1c0
Sep 22 12:00:45 porky kernel:  [<c01747d2>] sys_fcntl64+0xa2/0xc0
Sep 22 12:00:46 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71
Sep 22 12:00:46 porky kernel: Oops: 0000 [#1]
Sep 22 12:00:46 porky kernel: PREEMPT SMP
Sep 22 12:00:46 porky kernel: Modules linked in: parport_pc lp parport 
autofs4 sunrpc tulip ide_cd cdrom floppy sg microcode dm_mod uhci_hcd 
usbcore ipv6 ext3 jbd aic7xxx sd_mod scsi_mod
Sep 22 12:00:46 porky kernel: CPU:    0
Sep 22 12:00:47 porky kernel: EIP:    0060:[<c01776dd>]    Not tainted VLI
Sep 22 12:00:47 porky kernel: EFLAGS: 00010246   (2.6.9-rc2-mm1-VP-S2)
Sep 22 12:00:47 porky kernel: EIP is at __posix_lock_file+0x6d/0x5a0
Sep 22 12:00:47 porky kernel: eax: 00000000   ebx: 00000000   ecx: 
d74e05ac   edx: 00000000
Sep 22 12:00:47 porky kernel: esi: dc53e328   edi: dc53e3d8   ebp: 
de96ff00   esp: de96fea4
Sep 22 12:00:47 porky kernel: ds: 007b   es: 007b   ss: 0068   preempt: 
00000001
Sep 22 12:00:47 porky kernel: Process mingetty (pid: 2667, 
threadinfo=de96e000 task=dfcecbf0)
Sep 22 12:00:48 porky kernel: Stack: d74e05ac d74e01ec 00000202 00000046 
c0176a2e d74e05ac dea26ce0 d74e05ac
Sep 22 12:00:48 porky kernel:        dea26ce0 de96fee4 00000202 c0178bd6 
c01b3fd8 d74e05ac 00000000 00000000
Sep 22 12:00:48 porky kernel:        00000000 00000000 d74e054c d74e04ec 
d74e05ac dea26ce0 00000000 de96ff7c
Sep 22 12:00:48 porky kernel: Call Trace:
Sep 22 12:00:48 porky kernel:  [<c0176a2e>] flock_to_posix_lock+0xe/0x170
Sep 22 12:00:48 porky kernel:  [<c0178bd6>] fcntl_setlk+0x166/0x2d0
Sep 22 12:00:48 porky kernel:  [<c01b3fd8>] dummy_file_lock+0x8/0x10
Sep 22 12:00:48 porky kernel:  [<c0178c0f>] fcntl_setlk+0x19f/0x2d0
Sep 22 12:00:48 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 22 12:00:48 porky kernel:  [<c02b3f9a>] _spin_unlock+0x1a/0x40
Sep 22 12:00:48 porky kernel:  [<c0138512>] check_preempt_timing+0x192/0x200
Sep 22 12:00:48 porky kernel:  [<c0138759>] sub_preempt_count+0x69/0x80
Sep 22 12:00:48 porky kernel:  [<c02b3f9a>] _spin_unlock+0x1a/0x40
Sep 22 12:00:48 porky kernel:  [<c01747d2>] sys_fcntl64+0xa2/0xc0
Sep 22 12:00:48 porky kernel:  [<c0174501>] do_fcntl+0x11/0x1c0
Sep 22 12:00:48 porky kernel:  [<c01745f5>] do_fcntl+0x105/0x1c0
Sep 22 12:00:48 porky kernel:  [<c01747d2>] sys_fcntl64+0xa2/0xc0
Sep 22 12:00:48 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71
Sep 22 12:00:48 porky kernel: Code: 74 2f 8d 96 b0 00 00 00 89 55 e0 8b 
86 b0 00 00 00 85 c0 74 1c 89 c3 8d b4 26 00 00 00 00 f6 43 30 01 0f 85 
ce 04 00 00 89 5d e0 <8b> 1b 85 db 75 ed 8b 55 0c 31 ff f6 42 30 08 0f 
85 6e 02 00 00




