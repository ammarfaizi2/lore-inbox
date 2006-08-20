Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWHTQpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWHTQpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWHTQpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:45:24 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:63979 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750923AbWHTQpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:45:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RvsHcir8vrWkYcV9bUusRey0RkjmY/WmP2d0J4Qr+5+dEO91WZYnaZwOjk15d/JFgFvgmqUtlsXgacZY+tpjYN/P2MP9/GQAOZvvdmAprT9PBaF6kczeart3ew/14k/POh067VMRDj+RrdIvFa+0eVTqGkx9mVw0/Y7C/pURBsM=
Message-ID: <6bffcb0e0608200945ga2409h4d90c7193a4e8bff@mail.gmail.com>
Date: Sun, 20 Aug 2006 18:45:22 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm2
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <44E88821.8080001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819220008.843d2f64.akpm@osdl.org>
	 <44E88821.8080001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> >
>
> System hangs on this
>
> Aug 20 17:47:47 euridica kernel: BUG: MAX_STACK_TRACE_ENTRIES too low!
> Aug 20 17:47:47 euridica kernel: turning off the locking correctness validator.
> Aug 20 17:47:47 euridica kernel:  [<c01041b5>] dump_trace+0x64/0x1b2
> Aug 20 17:47:47 euridica kernel:  [<c0104315>] show_trace_log_lvl+0x12/0x25
> Aug 20 17:47:47 euridica kernel:  [<c0104985>] show_trace+0xd/0x10
> Aug 20 17:47:47 euridica kernel:  [<c0104a4d>] dump_stack+0x19/0x1b
> Aug 20 17:47:47 euridica kernel:  [<c013878b>] save_trace+0xd0/0xdd
> Aug 20 17:47:47 euridica kernel:  [<c01387f4>] add_lock_to_list+0x5c/0x7a
> Aug 20 17:47:47 euridica kernel:  [<c013a93d>] __lock_acquire+0x9f3/0xaef
> Aug 20 17:47:47 euridica kernel:  [<c013ada3>] lock_acquire+0x71/0x91
> Aug 20 17:47:47 euridica kernel:  [<c02f87b9>] _spin_lock_irqsave+0x2c/0x3c
> Aug 20 17:47:47 euridica kernel:  [<c01d2b8a>] avc_has_perm_noaudit+0x23b/0x487
> Aug 20 17:47:47 euridica kernel:  [<c01d3a5c>] avc_has_perm+0x22/0x45
> Aug 20 17:47:48 euridica kernel:  [<c01d3d58>] ipc_has_perm+0x58/0x60
> Aug 20 17:47:48 euridica kernel:  [<c01d3d96>] selinux_ipc_permission+0x36/0x39
> Aug 20 17:47:48 euridica kernel:  [<c01c7ad6>] ipcperms+0xd7/0xe0
> Aug 20 17:47:48 euridica kernel:  [<c01ca6c0>] do_shmat+0x29b/0x2b2
> Aug 20 17:47:49 euridica kernel:  [<c0107c96>] sys_ipc+0xe8/0x143
> Aug 20 17:47:49 euridica kernel:  [<c01031b5>] sysenter_past_esp+0x56/0x8d
> Aug 20 17:47:49 euridica kernel: DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Aug 20 17:47:49 euridica kernel:
> Aug 20 17:47:49 euridica kernel: Leftover inexact backtrace:
> Aug 20 17:47:49 euridica kernel:
> Aug 20 17:47:50 euridica kernel:  [<c0104315>] show_trace_log_lvl+0x12/0x25
> Aug 20 17:47:50 euridica kernel:  [<c0104985>] show_trace+0xd/0x10
> Aug 20 17:47:50 euridica kernel:  [<c0104a4d>] dump_stack+0x19/0x1b
> Aug 20 17:47:50 euridica kernel:  [<c013878b>] save_trace+0xd0/0xdd
> Aug 20 17:47:50 euridica kernel:  [<c01387f4>] add_lock_to_list+0x5c/0x7a
> Aug 20 17:47:50 euridica kernel:  [<c013a93d>] __lock_acquire+0x9f3/0xaef
> Aug 20 17:47:50 euridica kernel:  [<c013ada3>] lock_acquire+0x71/0x91
> Aug 20 17:47:50 euridica kernel:  [<c02f87b9>] _spin_lock_irqsave+0x2c/0x3c
> Aug 20 17:47:50 euridica kernel:  [<c01d2b8a>] avc_has_perm_noaudit+0x23b/0x487
> Aug 20 17:47:51 euridica kernel:  [<c01d3a5c>] avc_has_perm+0x22/0x45
> Aug 20 17:47:51 euridica kernel:  [<c01d3d58>] ipc_has_perm+0x58/0x60
> Aug 20 17:47:51 euridica kernel:  [<c01d3d96>] selinux_ipc_permission+0x36/0x39
> Aug 20 17:47:52 euridica kernel:  [<c01c7ad6>] ipcperms+0xd7/0xe0
>
> When I build kernel with gcc 3.4.6 everything works fine.

Now it also works fine with gcc 4.1.1. I still get "BUG:
MAX_STACK_TRACE_ENTRIES too low!". Probably it was unclean build (I
don't know why. I have "make clean" in my build scripts).

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
