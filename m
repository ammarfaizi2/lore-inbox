Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbUDNFBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 01:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbUDNFBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 01:01:52 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:40219 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263884AbUDNFBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 01:01:25 -0400
Date: Wed, 14 Apr 2004 07:08:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Minor __sched cleanups
Message-ID: <20040414050848.GA2182@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>
References: <1081906686.22908.31.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081906686.22908.31.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/alpha/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c
> --- .24943-linux-2.6.5-mm4/arch/alpha/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
> +++ .24943-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c	2004-04-13 15:10:20.000000000 +1000
> @@ -513,8 +513,8 @@ thread_saved_pc(task_t *t)
>  /*
>   * These bracket the sleeping functions..
>   */
> -#define first_sched	((unsigned long) scheduling_functions_start_here)
> -#define last_sched	((unsigned long) scheduling_functions_end_here)
> +#define first_sched	((unsigned long)__sched_text_start)
> +#define last_sched	((unsigned long)__sched_text_end)

Any good reason to keep the definitions in the various arch specific
process.c files?
Locating them in sched.h would be a nice consolidation.

	Sam
