Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318236AbSIFI6O>; Fri, 6 Sep 2002 04:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSIFI6O>; Fri, 6 Sep 2002 04:58:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39378 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318236AbSIFI6N>;
	Fri, 6 Sep 2002 04:58:13 -0400
Date: Fri, 6 Sep 2002 11:07:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Juan M. de la Torre" <jmtorre@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Little bug in O(1) scheduler patch (also in 2.4.19-ac4)
In-Reply-To: <20020906083254.GA769@apocalipsis>
Message-ID: <Pine.LNX.4.44.0209061106370.10843-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Sep 2002, Juan M. de la Torre wrote:

>  a module compiled for kernel 2.4.19-ac4, with CONFIG_MODVERSIONS, and
> importing flush_signals() from kernel, fails to load, reporting
> "unresolved symbol flush_signals_xxxxxxxx".

what module?

>  The problem is that the type of the argument passed to flush_signals()
> has been changed from "struct task_struct *" to "task_t *" in sched.h,
> but it remains unchanged in kernel/signal.c. The same happens with
> flush_signal_handlers().

hm, struct task_struct * is the same as task_t *.

	Ingo

