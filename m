Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSHZSIJ>; Mon, 26 Aug 2002 14:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSHZSIH>; Mon, 26 Aug 2002 14:08:07 -0400
Received: from [195.39.17.254] ([195.39.17.254]:23936 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318182AbSHZSIA>;
	Mon, 26 Aug 2002 14:08:00 -0400
Date: Mon, 26 Aug 2002 14:35:28 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone-detached-2.5.31-B0
Message-ID: <20020826123528.GB359@elf.ucw.cz>
References: <Pine.LNX.4.44.0208132307340.12804-100000@localhost.localdomain> <Pine.LNX.4.44.0208151715320.2982-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208151715320.2982-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> one of the debugging tests triggered a false-positive BUG() when a
> detached thread was straced. Fix against BK-curr attached.
> 
> 	Ingo
> 
> --- kernel/signal.c.orig	Thu Aug 15 17:12:02 2002
> +++ kernel/signal.c	Thu Aug 15 17:12:34 2002
> @@ -774,7 +774,7 @@
>  	int why, status;
>  
>  	/* is the thread detached? */
> -	if (sig == -1 || tsk->exit_signal == -1)
> +	if (sig == -1)
>  		BUG();
>  
>  	info.si_signo = sig;

Why not BUG_ON()?
									Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
