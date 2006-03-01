Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWCACo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWCACo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWCACo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:44:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964842AbWCACoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:44:55 -0500
Date: Tue, 28 Feb 2006 18:44:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228184450.dd831456.akpm@osdl.org>
In-Reply-To: <440503E5.1070100@yahoo.com.au>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<6bffcb0e0602280701h1d5cbeaar@mail.gmail.com>
	<6bffcb0e0602280820ic87332k@mail.gmail.com>
	<440503E5.1070100@yahoo.com.au>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> >>Feb 28 15:13:42 ltg01-sid kernel: BUG: warning at
> >>/usr/src/linux-mm/fs/inotify.c:533/inotify_d_instantiate()
> >>Feb 28 15:13:42 ltg01-sid kernel:  [show_trace+13/15] show_trace+0xd/0xf
> >>Feb 28 15:13:42 ltg01-sid kernel:  [dump_stack+21/23] dump_stack+0x15/0x17
> >>Feb 28 15:13:42 ltg01-sid kernel:  [inotify_d_instantiate+47/98]
> >>inotify_d_instantiate+0x2f/0x62
> >>Feb 28 15:13:42 ltg01-sid kernel:  [d_instantiate+70/114]
> >>d_instantiate+0x46/0x72
> >>Feb 28 15:13:42 ltg01-sid kernel:  [ext3_add_nondir+44/64]
> >>ext3_add_nondir+0x2c/0x40
> >>Feb 28 15:13:42 ltg01-sid kernel:  [ext3_link+163/217] ext3_link+0xa3/0xd9
> >>Feb 28 15:13:42 ltg01-sid kernel:  [vfs_link+292/379] vfs_link+0x124/0x17b
> >>Feb 28 15:13:42 ltg01-sid kernel:  [sys_linkat+157/218] sys_linkat+0x9d/0xda
> >>Feb 28 15:13:42 ltg01-sid kernel:  [sys_link+20/25] sys_link+0x14/0x19
> >>Feb 28 15:13:42 ltg01-sid kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> >>
> >>Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.16-rc5-mm1/mm-dmesg
> >>Here is config http://www.stardust.webpages.pl/files/mm/2.6.16-rc5-mm1/mm-config
> > 
> > 
> > This patch is causing that warning
> > inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
> > 
> 
> The warning is harmless really. I guess it can be removed.

?    How did DCACHE_INOTIFY_PARENT_WATCHED get set on that dentry?
