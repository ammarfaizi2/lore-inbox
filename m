Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBTMCq>; Tue, 20 Feb 2001 07:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRBTMCh>; Tue, 20 Feb 2001 07:02:37 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:7256 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129159AbRBTMCZ>; Tue, 20 Feb 2001 07:02:25 -0500
Date: Tue, 20 Feb 2001 06:02:05 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
Reply-To: Philipp Rumpf <prumpf@mandrakesoft.com>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
cc: linux-kernel@vger.kernel.org, prumpf@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] new setprocuid syscall
In-Reply-To: <Pine.A41.4.31.0102192312330.174604-100000@pandora.inf.elte.hu>
Message-ID: <Pine.LNX.3.96.1010220055423.9350A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urN linux-2.4.1/arch/i386/kernel/entry.S
> linux-2.4.1-setprocuid/arch/i386/kernel/entry.S
> --- linux-2.4.1/arch/i386/kernel/entry.S        Thu Nov  9 02:09:50 2000
> +++ linux-2.4.1-setprocuid/arch/i386/kernel/entry.S     Mon Feb 19
> 22:12:00 2001
> @@ -645,6 +645,7 @@
>         .long SYMBOL_NAME(sys_madvise)
>         .long SYMBOL_NAME(sys_getdents64)       /* 220 */
>         .long SYMBOL_NAME(sys_fcntl64)
> +       .long SYMBOL_NAME(sys_setprocuid)
>         .long SYMBOL_NAME(sys_ni_syscall)       /* reserved for TUX */
> 
>         /*

You stole TUX's syscall slot.

> +       p = find_task_by_pid(pid);
> +       p->fsuid = p->euid = p->suid = p->uid = uid;

p might be NULL.

