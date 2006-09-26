Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWIZDEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWIZDEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 23:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWIZDEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 23:04:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750709AbWIZDEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 23:04:32 -0400
Date: Mon, 25 Sep 2006 20:04:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [patch] epoll_pwait for 2.6.18 ...
Message-Id: <20060925200419.85aa4ff6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609251735070.4749@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0609251735070.4749@alien.or.mcafeemobile.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 17:43:10 -0700 (PDT)
Davide Libenzi <davidel@xmailserver.org> wrote:

> 
> The attached patch implements the epoll_pwait system call

Your email client space-stuffed it.  That's pretty easy to fix up, but...

> arch/i386/kernel/syscall_table.S |    1
> fs/eventpoll.c                   |   55 ++++++++++++++++++++++++++++++++++++---
> include/asm-i386/unistd.h        |    3 +-
> include/linux/syscalls.h         |    3 ++

Could you please also wire up x86_64, so we can keep the 32-bit syscall
numbers in sync?  I guess we should do arch/ia64/ia32/ia32_entry.S too, but
people don't seem to do that.

