Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTBYBUL>; Mon, 24 Feb 2003 20:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTBYBSc>; Mon, 24 Feb 2003 20:18:32 -0500
Received: from dp.samba.org ([66.70.73.150]:6619 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265135AbTBYBSK>;
	Mon, 24 Feb 2003 20:18:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: modutils: FATAL: Error running install... 
In-reply-to: Your message of "Mon, 24 Feb 2003 17:27:34 BST."
             <20030224172734.C29439@deep-space-9.dsnet> 
Date: Tue, 25 Feb 2003 12:27:43 +1100
Message-Id: <20030225012823.8C09A2C54A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030224172734.C29439@deep-space-9.dsnet> you write:
> ===== kernel/kmod.c 1.24 vs edited =====
> --- 1.24/kernel/kmod.c	Mon Feb 24 04:18:09 2003
> +++ edited/kernel/kmod.c	Mon Feb 24 17:19:39 2003
> @@ -154,6 +154,7 @@
>  
>  	/* Unblock all signals. */
>  	flush_signals(current);
> +	current->sighand->action[SIGCHLD-1].sa.sa_handler = SIG_DFL;
>  	spin_lock_irq(&current->sighand->siglock);
>  	flush_signal_handlers(current);
>  	sigemptyset(&current->blocked);

Is there really no cleaner way that this?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
