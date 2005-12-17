Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVLQUhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVLQUhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVLQUhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:37:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbVLQUhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:37:20 -0500
Date: Sat, 17 Dec 2005 12:36:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two bugs in kernel 2.6.15-rc5
Message-Id: <20051217123657.2289c084.akpm@osdl.org>
In-Reply-To: <489ecd0c0512131837p654b7d8bqd63cd3342542d1da@mail.gmail.com>
References: <489ecd0c0512131837p654b7d8bqd63cd3342542d1da@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang <luke.adi@gmail.com> wrote:
>
> Hi all,
> 
>    During porting Blackfin architecture to latest kernel, I found two issues:
> 
>  1. kernel/futex.c invokes handle_mm_fault() function, which calls
> __handle_mm_fault(). But __handle_mm_fault() is defined in
> mm/memory.c, which is only compiled when CONFIG_MMU is defined. So
> those without MMUs can not use futex any more.
> 
>    How do you think this shall be fixed? Use #ifdef CONFIG_MMU ... #endif?

See frv-make-futex-code-compilable-on-nommu.patch from recent -mm kernels.

