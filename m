Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWBGPII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWBGPII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWBGPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:08:07 -0500
Received: from witte.sonytel.be ([80.88.33.193]:60366 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965123AbWBGPIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:08:06 -0500
Date: Tue, 7 Feb 2006 16:08:00 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 03/20] pid: Introduce a generic helper to test for
 init.
In-Reply-To: <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.62.0602071607220.17769@pademelon.sonytel.be>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
 <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
 <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Eric W. Biederman wrote:
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -894,6 +894,19 @@ static inline int pid_alive(struct task_
>  	return p->pids[PIDTYPE_PID].nr != 0;
>  }
>  
> +/**
> + * is_init - check if a task structure is the first user space
> + *	     task the kernel created.
> + * @p: Task structure to be checked.
       ^
> + */
> +static inline int is_init(struct task_struct *tsk)
                                                 ^^^
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
