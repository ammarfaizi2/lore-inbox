Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbSJaUGy>; Thu, 31 Oct 2002 15:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265376AbSJaUGv>; Thu, 31 Oct 2002 15:06:51 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:31714 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265363AbSJaUGt>; Thu, 31 Oct 2002 15:06:49 -0500
Date: Thu, 31 Oct 2002 14:13:14 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 : kernel BUG at kernel/workqueue.c:69! (ISDN?)
In-Reply-To: <20021031110816.GE16875@ulima.unil.ch>
Message-ID: <Pine.LNX.4.44.0210311408230.27728-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Gregoire Favre wrote:

> ------------[ cut here ]------------
> kernel BUG at kernel/workqueue.c:69!

Well, I thought I had all of these fixed...

> CPU:    0
> EIP:    0060:[<c0129775>]    Not tainted
> EFLAGS: 00010213
> eax: 00000000   ebx: dff8e000   ecx: c03c90d4   edx: c17e3958
> esi: c17e3958   edi: c17e395c   ebp: dffa2280   esp: dff8febc
> ds: 0068   es: 0068   ss: 0068
> Process swapper (pid: 1, threadinfo=dff8e000 task=dff8c080)
> Stack: 00000004 c17e3000 dff8e000 00000000 c0413bfa c17e3000 00000002 00000052
>        c17e3000 00000003 c02e7018 c17e3000 00000003 c17e30be c17e3000 c04127ff
>        c17e3000 000000f2 00000000 c03ad64b c17e3000 c17e3000 dff8ff92 c17e30be
> Call Trace: [<c02e7018>]  [<c011ba65>]  [<c010506f>]  [<c0105032>]  [<c01055a1>]
> Code: 0f 0b 45 00 32 32 38 c0 eb 8b 90 83 ec 10 89 7c 24 08 89 1c
>  <0>Kernel panic: Attempted to kill init!
> Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
> Call Trace: [<c016339a>]  [<c01633d9>]  [<c0147985>]  [<c011afec>]  [<c011ece0>]  [<c0108506>]  [<c01083c5>]  [<c010856d>]  [<c0129775>]  [<c02d7e54>]  [<c021cc3b>]  [<c0107e59>]  [<c02d0068>]  [<c0129775>]  [<c02e7018>]  [<c011ba65>]  [<c010506f>]  [<c0105032>]  [<c01055a1>]

> Trace; c02e7018 <AVM_card_msg+6a/d0>
> Trace; c011ba65 <release_console_sem+cb/ce>
> Trace; c010506f <init+3d/15a>
> Trace; c0105032 <init+0/15a>
> Trace; c01055a1 <kernel_thread_helper+5/c>

I cannot really make much sense of the traces, though, are you sure 
System.map matched the kernel where the oops happened? You might want to 
select CONFIG_KALLSYMS, that guarantees correct resolving of symbols 
without the need to run the oops through ksymoops.

--Kai


