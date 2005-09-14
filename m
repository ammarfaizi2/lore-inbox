Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVINJZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVINJZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVINJZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:25:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56744 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965109AbVINJZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:25:52 -0400
Date: Wed, 14 Sep 2005 11:23:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Levent Serinol <lserinol@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jlan@engr.sgi.com
Subject: Re: [PATCH] per process I/O statistics for userspace
Message-ID: <20050914092338.GA2260@elf.ucw.cz>
References: <2c1942a7050912052759c7f730@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1942a7050912052759c7f730@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> with following patch, userspace processes/utilities will be able to
> access per process I/O statistics. for example, top like utilites can
> use this information.

Nice, but should not this perhaps go into the other file? Adding more
integers into long line does not seem nice...
									Pavel

> 
> --- linux-2.6.13/fs/proc/array.c.org    2005-08-29 02:41:01.000000000 +0300
> +++ linux-2.6.13/fs/proc/array.c        2005-09-12 10:22:55.000000000 +0300
> @@ -408,7 +408,7 @@ static int do_task_stat(struct task_stru
> 
>         res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
>  %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
> -%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
> +%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu %llu\n",
>                 task->pid,
>                 tcomm,
>                 state,
> @@ -453,7 +453,9 @@ static int do_task_stat(struct task_stru
>                 task->exit_signal,
>                 task_cpu(task),
>                 task->rt_priority,
> -               task->policy);
> +               task->policy,
> +               task->rchar,
> +               task->wchar);
>         if(mm)
>                 mmput(mm);
>         return res;
> --
> Signed-off-by: Levent Serinol <lserinol@gmail.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
if you have sharp zaurus hardware you don't need... you know my address
