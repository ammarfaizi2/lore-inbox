Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbTASSIj>; Sun, 19 Jan 2003 13:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbTASSIi>; Sun, 19 Jan 2003 13:08:38 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:28687 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267684AbTASSIh>; Sun, 19 Jan 2003 13:08:37 -0500
Date: Sun, 19 Jan 2003 19:17:16 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
Message-ID: <20030119181716.GA28031@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Sun, Jan 19, 2003 at 02:08:40PM +0000
> If you got 2.4.21-pre3-ac __free_pages_ok oops, please try this patch.
> 
> Hugh
> 
> --- 2.4.21-pre3-ac4/kernel/fork.c	Mon Jan 13 18:56:12 2003
> +++ linux/kernel/fork.c	Sun Jan 19 13:39:37 2003
> @@ -688,6 +688,8 @@
>  	p->lock_depth = -1;		/* -1 = no lock */
>  	p->start_time = jiffies;
>  
> +	INIT_LIST_HEAD(&p->local_pages);
> +
>  	retval = -ENOMEM;
>  	/* copy all the process information */
>  	if (copy_files(clone_flags, p))
> 
If this is it, and so far it looks like it for me, wouldn't it be time
to create a

CONFIG_DEBUG_LIST

option that caught these illegal list manipulations?

I know - talk is cheap, code isn't etc etc :-)

Jurriaan
-- 
pay no deposit and get no return
	Skyclad - No Deposit, No Return
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2785 bogomips load av: 0.06 0.82 0.64
