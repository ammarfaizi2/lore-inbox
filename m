Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTKNVE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTKNVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:04:26 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:34690
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264594AbTKNVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:04:24 -0500
Date: Fri, 14 Nov 2003 16:01:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jens Gecius <jens@gecius.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: hardlock oops on 2.6.0-test3 smp
In-Reply-To: <87n0azj8ti.fsf@maniac.gecius.de>
Message-ID: <Pine.LNX.4.53.0311141559320.27998@montezuma.fsmlabs.com>
References: <87n0azj8ti.fsf@maniac.gecius.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003, Jens Gecius wrote:

> Hi!
> 
> Just came back from vacation and found this nasty screen:
> 
> Oops 0002 [<#1>]
> CPU: 1
> EIP: 0060:[<c91386f3>] Not tainted
> EFLAGS: 00010082
> EIP is at detach_pid+0x23/0x110
> eax: 6b6b6b6b  ebx: 6b6b6b6b  ecx: d379ba20  edx: d379b970
> esi: 6b6b6b6b  edi: 00100100  ebp: 00000000  esp: f5641ef8
> ds: 007b  es: 007b  ss: 0668
> Process tcplogd (pid: 1712, threadinfo=f5640000 task=f7606670)
> Stack: d379b920 d379b920 f5640000 d379bf1c c012641c d379b920 c0126522 d379b920
>        d379b9c4 d379b920 bfffd28c 00000000 0000674b c01285db d379b920 f4be6774
>        00000000 c026af61 d379b920 d379b920 f7606670 d379b9c4 f760670c c0128acd
> Call Trace: [<c01264c1>] __unhash_process+0x5c/0xb0
>             [<c0126522>] release_task+0xb2/0x250
>             [<c01285db>] wait_task_zombie+0x1ab/0x230
>             [<c026af61>] selinux_task_wait+0x41/0x50
>             [<c0128acd>] sys_wait4+0x24d/0x260
>             [<c011fd40>] default_wake_funktion+0x0/0x30
>             [<c011fd40>] default_wake_funktion+0x0/0x30
>             [<c010b4cb>] syscall_call+0x7/0xb
> Code: 89 58 04 89 03 c7 41 04 00 03 30 00 89 ba b0 00 00 00 f0 ff

This has been fixed, try running -test9

Thanks

