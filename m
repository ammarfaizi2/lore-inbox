Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTKTPDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTKTPDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:03:02 -0500
Received: from ns.suse.de ([195.135.220.2]:59075 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261893AbTKTPDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:03:00 -0500
To: jak@rudolph.ccur.com (Joe Korty)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] Opteron support for mqueues-4.00 +bug fixes
References: <200311201432.OAA05361@rudolph.ccur.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Nov 2003 16:02:57 +0100
In-Reply-To: <200311201432.OAA05361@rudolph.ccur.com.suse.lists.linux.kernel>
Message-ID: <p73fzgjozfi.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jak@rudolph.ccur.com (Joe Korty) writes:

>  __SYSCALL(__NR_vserver, sys_ni_syscall)
> +#define __NR_mq_open			274
> +__SYSCALL(__NR_mq_open, sys_mq_open)

The patch is buggy. You cannot add any unmapped holes into the x86-64 
system call table, it adds an oopsable hole to the entry.

In general you cannot add any system calls without coordinating with
Linus and the architecture maintainers first. And the list is not sparse.

-Andi
