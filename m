Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTG0MTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTG0MTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:19:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57563 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270763AbTG0MTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:19:12 -0400
Date: Sun, 27 Jul 2003 14:33:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G3
In-Reply-To: <200307261156.32209.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0307271430220.19003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Jul 2003, Con Kolivas wrote:

> With this section of your patch:
> 
> +               if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
> 
> that would requeue active tasks a variable duration into their running
> time dependent on their task timeslice rather than every 50ms. Shouldn't
> it be:
> 
> +               if (!((task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY) &&
> 
> to ensure it is TIMESLICE_GRANULARITY into the timeslice of a process?

yeah, agreed.

	Ingo

