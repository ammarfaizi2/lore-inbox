Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUAZRZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUAZRZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:25:52 -0500
Received: from [212.220.30.16] ([212.220.30.16]:21722 "EHLO spot.plotinka.ru")
	by vger.kernel.org with ESMTP id S264363AbUAZRZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:25:47 -0500
Date: Mon, 26 Jan 2004 22:25:44 +0500
From: m0sia <m0sia@plotinka.ru>
To: Chmouel Boudjnah <chmouel@chmouel.com>, linux-kernel@vger.kernel.org
Subject: Re: scheduler crash 2.6.2-rc1-mm2
Message-Id: <20040126222544.125764ab.m0sia@plotinka.ru>
In-Reply-To: <m3fze2vb90.fsf@dark.chmouel.fr>
References: <m3fze2vb90.fsf@dark.chmouel.fr>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 2004 19:02:51 +0100
Chmouel Boudjnah <chmouel@chmouel.com> wrote:

> Hi,
> 
> I don't have a proper way to reproduce it (it crashed while the
> cmputer was idle and i was in the shower) but i am going to test -rc2
> and -rc1-mm3
> 
> version:
> 2.6.2-rc1-mm2 : gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk)
> 
> dmesg:
> 
> request_module: failed /sbin/modprobe -- char-major-81-0. error = 256
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> request_module: failed /sbin/modprobe -- sound-service-1-0. error = 256
> request_module: failed /sbin/modprobe -- sound-service-1-0. error = 256
> request_module: failed /sbin/modprobe -- char-major-116-0. error = 256
> request_module: failed /sbin/modprobe -- char-major-116-0. error = 256
> request_module: failed /sbin/modprobe -- char-major-116-0. error = 256
> request_module: failed /sbin/modprobe -- sound-service-1-0. error = 256
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c011d765>] interruptible_sleep_on_timeout+0xf5/0x130
>  [<c011d290>] default_wake_function+0x0/0x10
>  [<e08fbdcf>] cm_write+0x51f/0x7b0 [cmpci]
>  [<c0154de0>] vfs_write+0xb0/0x110
>  [<c0154ee8>] sys_write+0x38/0x60
>  [<c02488a6>] sysenter_past_esp+0x43/0x65
> 
> request_module: failed /sbin/modprobe -- char-major-116-0. error = 256
> request_module: failed /sbin/modprobe -- sound-service-1-0. error = 256
> request_module: failed /sbin/modprobe -- sound-service-1-0. error = 256
> 
> Cheers,
> 
> -- 
> Travel's around the world - http://www.chmouel.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I had the same problem on 2.6.1-love3. I simply disabled ACPI in kernel.
