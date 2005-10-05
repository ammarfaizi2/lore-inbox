Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVJEWT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVJEWT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVJEWT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:19:56 -0400
Received: from mail16.bluewin.ch ([195.186.19.63]:8161 "EHLO mail16.bluewin.ch")
	by vger.kernel.org with ESMTP id S1030395AbVJEWTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:19:55 -0400
Date: Wed, 5 Oct 2005 18:09:00 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] small cleanup for kernel/printk.c - CodingStyle, Whitespace, printk() loglevels...
Message-ID: <20051005220900.GA2559@mars>
References: <200510052356.49823.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510052356.49823.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 11:56:49PM +0200, Jesper Juhl wrote:
> Small CodingStyle cleanup for kernel/printk.c
>   Removes some trailing whitespace
>   Breaks long lines and make other small changes to conform to CodingStyle
>   Add explicit printk loglevels in two places.
> 
> Linus: Sorry to Cc: you on something as trivial as this, but you /are/ listed as
> the author of the file and I couldn't find a relevant maintainer (except for
> perhaps Andrew (so I added him to CC as well)).
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> Patch has been compile tested.
> 
>  kernel/printk.c |   78 ++++++++++++++++++++++++++++++--------------------------
>  1 files changed, 42 insertions(+), 36 deletions(-)
> 
> --- linux-2.6.14-rc3-git5-orig/kernel/printk.c	2005-10-03 21:55:39.000000000 +0200
> +++ linux-2.6.14-rc3-git5/kernel/printk.c	2005-10-05 23:46:54.000000000 +0200
> @@ -169,11 +169,11 @@ static int __init log_buf_len_setup(char
>  		size = roundup_pow_of_two(size);
>  	if (size > log_buf_len) {
>  		unsigned long start, dest_idx, offset;
> -		char * new_log_buf;
> +		char *new_log_buf;
>  
>  		new_log_buf = alloc_bootmem(size);
>  		if (!new_log_buf) {
> -			printk("log_buf_len: allocation failed\n");
> +			printk(KERN_WARNING "log_buf_len: allocation failed\n");

Wouldn't KERN_ERR be more appropriate here?

>  			goto out;
>  		}
>  
> @@ -193,10 +193,9 @@ static int __init log_buf_len_setup(char
>  		log_end -= offset;
>  		spin_unlock_irqrestore(&logbuf_lock, flags);
>  
> -		printk("log_buf_len: %d\n", log_buf_len);
> +		printk(KERN_NOTICE "log_buf_len: %d\n", log_buf_len);
>  	}
>  out:
> -
>  	return 1;
>  }
>  
> @@ -933,9 +938,9 @@ void register_console(struct console * c
>  }
>  EXPORT_SYMBOL(register_console);
>  
> -int unregister_console(struct console * console)
> +int unregister_console(struct console *console)
>  {
> -        struct console *a,*b;
> +        struct console *a, *b;
>  	int res = 1;

Beep! :)

		Arthur
