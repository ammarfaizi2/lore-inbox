Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUJCRIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUJCRIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJCRIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 13:08:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:15302 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268043AbUJCRIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 13:08:22 -0400
Date: Sun, 3 Oct 2004 10:06:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, torvalds@osdl.org
Subject: Re: [PATCH] alternate stack dump fix.
Message-Id: <20041003100603.6429acdd.akpm@osdl.org>
In-Reply-To: <41602238.A828A852@tv-sign.ru>
References: <41602238.A828A852@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
>  There is another problem in show_trace(). With CONFIG_FRAME_POINTER
>  every call to print_context_stack() will now print entire call chain,
>  switching the stacks transparently, beacause valid_stack_ptr()
>  now accepts ebp in irq stack.
> 
>  Then show trace switch the stack, and calls print_context_stack()
>  again with the same value in ebp, and we have the same dump
>  after printk(" =======================\n").
> 
>  What do you think about the following patch?
> 
>  Against 2.6.9-rc3.

But it conflicts in a big way with Kirill's patch.  Could you redo it
against 2.6.9-rc3-mm1, or against just 

fix-of-stack-dump-in-soft-hardirqs.patch
fix-of-stack-dump-in-soft-hardirqs-cleanup.patch
fix-of-stack-dump-in-soft-hardirqs-build-fix.patch

from ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm1/broken-out?

Thanks.
