Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWHBMYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWHBMYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHBMYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:24:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49419 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750793AbWHBMYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:24:22 -0400
Date: Wed, 2 Aug 2006 12:22:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: use after free on ctrl-alt-del
Message-ID: <20060802122226.GK7601@ucw.cz>
References: <20060728233533.GC3217@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728233533.GC3217@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With 2.6.18-rc2-git6, I see this when I hit ctrl-alt-del
> on one of my machines (oddly on no others though).
> 
> BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
>  printing eip:
> 6b6b6b6b
> *pde = 00000000
> Oops: 0000 [#2]    <-- The other oopsen were from SATA, more bugs to follow.
> eax: dfa4d49c ebx: 6b6b6b6b ecx: 00000000 edx: 00000001
> esi: dfa4d49c edi: 00000000 ebp: c1858e7c esp: c1858e68
> ...
> Call Trace:
> show_stack_log_lvl+0x8a
> show_registers
> die
> do_page_fault
> error_code
> blocking_notifier_call_chain
> kernel_restart_prepare
> kernek_restart
> sys_reboot
> syscall_call

Some driver perhaps? Could you try it with minimal drivers?

-- 
Thanks for all the (sleeping) penguins.
