Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSLTLKB>; Fri, 20 Dec 2002 06:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLTLKB>; Fri, 20 Dec 2002 06:10:01 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:40163 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261836AbSLTLJ7> convert rfc822-to-8bit; Fri, 20 Dec 2002 06:09:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Robert Love <rml@tech9.net>, Con Kolivas <conman@kolivas.net>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Fri, 20 Dec 2002 12:17:07 +0100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212200850.32886.conman@kolivas.net> <200212201042.48161.conman@kolivas.net> <1040341995.2521.81.camel@phantasy>
In-Reply-To: <1040341995.2521.81.camel@phantasy>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201217.07097.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 December 2002 00:53, Robert Love wrote:

Hi Robert,

> You would probably get the same effect or better by setting
> prio_bonus_ratio lower (or off).
> Setting it lower will also give less priority bonus/penalty and not
> reinsert the tasks so readily into the active array.
> Something like the attached patch may help...

> --- linux-2.5.52/kernel/sched.c	2002-12-19 18:47:53.000000000 -0500
> +++ linux/kernel/sched.c	2002-12-19 18:48:05.000000000 -0500
> @@ -66,8 +66,8 @@
>  int child_penalty = 95;
>  int parent_penalty = 100;
>  int exit_weight = 3;
> -int prio_bonus_ratio = 25;
> -int interactive_delta = 2;
> +int prio_bonus_ratio = 5;
> +int interactive_delta = 1;
>  int max_sleep_avg = 2 * HZ;
>  int starvation_limit = 2 * HZ;
FYI: These changes are a horrible slowdown of all apps while kernel 
compilation.

ciao, Marc
