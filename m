Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVGRSTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVGRSTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVGRSTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 14:19:24 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:46792 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261360AbVGRSTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 14:19:23 -0400
Date: Mon, 18 Jul 2005 20:18:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix missing refrigerator invocation in jffs2.
Message-ID: <20050718181855.GA19802@wohnheim.fh-wedel.de>
References: <1121660092.13487.83.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1121660092.13487.83.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 July 2005 14:14:53 +1000, Nigel Cunningham wrote:
> 
> Here's a patch to fix a missing refrigerator call in jffs2.
                                                           ^
You should shorten the description by one letter, roughly. ;)

> 
> Signed-off by: Nigel Cunningham <nigel@suspend2.net>
> 
>  intrep.c |    3 +++
>  1 files changed, 3 insertions(+)
> diff -ruNp 235-jffs-intrep.patch-old/fs/jffs/intrep.c 235-jffs-intrep.patch-new/fs/jffs/intrep.c
> --- 235-jffs-intrep.patch-old/fs/jffs/intrep.c	2005-07-18 06:36:59.000000000 +1000
> +++ 235-jffs-intrep.patch-new/fs/jffs/intrep.c	2005-07-18 14:02:27.000000000 +1000
> @@ -3397,6 +3397,9 @@ jffs_garbage_collect_thread(void *ptr)
>  			siginfo_t info;
>  			unsigned long signr = 0;
>  
> +			if (try_to_freeze())
> +				continue;
> +
>  			spin_lock_irq(&current->sighand->siglock);
>  			signr = dequeue_signal(current, &current->blocked, &info);
>  			spin_unlock_irq(&current->sighand->siglock);
> 
> -- 
> Evolution.
> Enumerate the requirements.
> Consider the interdependencies.
> Calculate the probabilities.
> Be amazed that people believe it happened. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca
