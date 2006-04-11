Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWDKGYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWDKGYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWDKGYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:24:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbWDKGYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:24:09 -0400
Date: Mon, 10 Apr 2006 22:23:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
Message-Id: <20060410222324.7b9daeef.akpm@osdl.org>
In-Reply-To: <20060411100527.GA112@oleg>
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg>
	<20060407155113.37d6a3b3.akpm@osdl.org>
	<20060407155619.18f3c5ec.akpm@osdl.org>
	<m1d5fslcwx.fsf@ebiederm.dsl.xmission.com>
	<20060408172745.GA89@oleg>
	<m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u091dnry.fsf@ebiederm.dsl.xmission.com>
	<20060411100527.GA112@oleg>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Andrew, could you please drop these ones:
> 
>  	task-make-task-list-manipulations-rcu-safe-fix.patch
>  	task-make-task-list-manipulations-rcu-safe-fix-fix.patch

plop, plop.

>  Then we need this "patch" for de_thread:
> 
>  -		list_add_tail_rcu(&current->tasks, &init_task.tasks);
>  +		list_replace_rcu(&leader->tasks, &current->tasks);
>   ...
>  -		list_del_init(&leader->tasks);

OK, please send patch.

>  Currently I don't know how the code looks in -mm tree,

http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 is -mm-as-of-now.

> I lost the plot.

What plot?
