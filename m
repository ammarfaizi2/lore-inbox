Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVJYAvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVJYAvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 20:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVJYAvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 20:51:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbVJYAvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 20:51:25 -0400
Date: Mon, 24 Oct 2005 17:50:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: [PATCH] 2.6.14-rc5 fails to build with out CONFIG_FUTEX
Message-Id: <20051024175039.49d97e6f.akpm@osdl.org>
In-Reply-To: <435D7E7F.6020608@mvista.com>
References: <435D6F50.1000403@mvista.com>
	<20051024165452.3a809632.akpm@osdl.org>
	<435D7E7F.6020608@mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Andrew Morton wrote:
> > George Anzinger <george@mvista.com> wrote:
> > 
> >>Both kernel/exit.c and fs/dcache.c refer to functions in kernel/futex.c which is not built unless 
> >>CONFIG_FUTEX is true.  This causes a build failure at link time:
> >>   LD      vmlinux
> >>kernel/built-in.o(.text+0xab58): In function `do_exit':
> >>/usr/src/linux-2.6.14-rc/kernel/exit.c:851: undefined reference to `exit_futex'
> >>fs/built-in.o(.text+0x1b2bf): In function `dput':
> >>/usr/src/linux-2.6.14-rc/fs/dcache.c:165: undefined reference to `futex_free_robust_list'
> > 
> > 
> > This problem is specific to the robust-futexes patch.
> 
> And that appears to be in rc5, right?
> 

Nope.  Your patch is not applicable to mainline kernels.
