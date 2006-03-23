Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWCWLpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWCWLpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWCWLpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:45:17 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:12051 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751336AbWCWLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:45:16 -0500
Date: Thu, 23 Mar 2006 19:44:31 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jiri Slaby <jirislaby@gmail.com>
cc: Jiri Slaby <xslaby@fi.muni.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow [Was: 2.6.16-rc6-mm1]
In-Reply-To: <441CB176.8020103@gmail.com>
Message-ID: <Pine.LNX.4.64.0603231943220.6390@eagle.themaw.net>
References: <E1FIYLc-00080b-00@decibel.fi.muni.cz>
 <Pine.LNX.4.64.0603131330210.21830@eagle.themaw.net> <441CB176.8020103@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2006, Jiri Slaby wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ian Kent napsal(a):
> > On Sun, 12 Mar 2006, Jiri Slaby wrote:
> > 
> >> Andrew Morton wrote:
> >>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> >> [snip]
> >>> +remove-redundant-check-from-autofs4_put_super.patch
> >>> +autofs4-follow_link-missing-funtionality.patch
> >>>
> >>> Update autofs4 patches in -mm.
> >> Hello, 
> >>
> >> I caught this during ftp browsing autofs-bind-mounted directories. I don't know
> >> circumstancies and if the patches above are source of problem. I also don't know
> >> if -rc6-mm1 is the first one.
> > 
> > btw what do you mean autofs-bind-mounted ?
> > 
> >> BUG: atomic counter underflow at:
> >>  [<c0104736>] show_trace+0x13/0x15
> >>  [<c0104873>] dump_stack+0x1e/0x20
> >>  [<c01d6c97>] autofs4_wait+0x751/0x93a
> >>  [<c01d543b>] try_to_fill_dentry+0xca/0x11c
> >>  [<c01d59b3>] autofs4_revalidate+0xe1/0x148
> >>  [<c0171338>] do_lookup+0x40/0x157
> >>  [<c0172ec4>] __link_path_walk+0x804/0xe8c
> >>  [<c017359c>] link_path_walk+0x50/0xe8
> >>  [<c01738b7>] do_path_lookup+0x10f/0x26d
> >>  [<c017429c>] __user_walk_fd+0x33/0x50
> >>  [<c016d226>] vfs_stat_fd+0x1e/0x50
> >>  [<c016d30d>] vfs_stat+0x20/0x22
> >>  [<c016d328>] sys_stat64+0x19/0x2d
> >>  [<c0103127>] syscall_call+0x7/0xb
> >>
> > 
> > There's some suspicious code in waitq.c.
> > Could you try the following patch for me please?
> Yes, the patch below does solve the problem, can go upstream, good work!

Sorry to take so long to get back, I've been busy.

Thanks for that.
I'll submit the patch.

Ian

