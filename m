Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUI2M2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUI2M2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUI2M2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:28:41 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:45743 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268336AbUI2M2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:28:39 -0400
Message-ID: <21d7e99704092905284f48af35@mail.gmail.com>
Date: Wed, 29 Sep 2004 22:28:35 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040929102840.GA11325@none>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040929102840.GA11325@none>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might help if you enabled AGP for your chipset, you have no agp
compiled in for your Intel motherboard, you need intel agp chipset
support..

Dave.


On Wed, 29 Sep 2004 12:28:40 +0200, Borislav Petkov
<petkov@uni-muenster.de> wrote:
> Hi there people,
>    here are some fine, unresolved mutual exclusion issues. Sysinfo
>    attached.
> 
>    Regards,
>    Boris.
> 
> Sep 29 12:03:07 zmei kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> Sep 29 12:03:07 zmei kernel: [drm:radeon_unlock] *ERROR* Process 2807 using kernel context 0
> Sep 29 12:03:07 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2807
> Sep 29 12:03:07 zmei kernel:  [dump_stack+23/27] dump_stack+0x17/0x1b
> Sep 29 12:03:07 zmei kernel:  [smp_processor_id+146/152] smp_processor_id+0x92/0x98
> Sep 29 12:03:07 zmei kernel:  [add_timer_randomness+274/313] add_timer_randomness+0x112/0x139
> Sep 29 12:03:07 zmei kernel:  [input_event+72/940] input_event+0x48/0x3ac
> Sep 29 12:03:07 zmei kernel:  [kbd_rate+76/156] kbd_rate+0x4c/0x9c
> Sep 29 12:03:07 zmei kernel:  [vt_ioctl+3430/6535] vt_ioctl+0xd66/0x1987
> Sep 29 12:03:07 zmei kernel:  [tty_ioctl+874/1075] tty_ioctl+0x36a/0x433
> Sep 29 12:03:07 zmei kernel:  [sys_ioctl+196/511] sys_ioctl+0xc4/0x1ff
> Sep 29 12:03:07 zmei kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Sep 29 12:03:07 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2807
> Sep 29 12:03:07 zmei kernel:  [dump_stack+23/27] dump_stack+0x17/0x1b
> Sep 29 12:03:07 zmei kernel:  [smp_processor_id+146/152] smp_processor_id+0x92/0x98
> Sep 29 12:03:07 zmei kernel:  [add_timer_randomness+274/313] add_timer_randomness+0x112/0x139
> Sep 29 12:03:07 zmei kernel:  [input_event+72/940] input_event+0x48/0x3ac
> Sep 29 12:03:07 zmei kernel:  [kbd_rate+103/156] kbd_rate+0x67/0x9c
> Sep 29 12:03:07 zmei kernel:  [vt_ioctl+3430/6535] vt_ioctl+0xd66/0x1987
> Sep 29 12:03:07 zmei kernel:  [tty_ioctl+874/1075] tty_ioctl+0x36a/0x433
> Sep 29 12:03:07 zmei kernel:  [sys_ioctl+196/511] sys_ioctl+0xc4/0x1ff
> Sep 29 12:03:07 zmei kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> 
> 
>
