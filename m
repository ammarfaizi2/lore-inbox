Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263266AbTCUFTy>; Fri, 21 Mar 2003 00:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbTCUFTy>; Fri, 21 Mar 2003 00:19:54 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35047 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263266AbTCUFTx>;
	Fri, 21 Mar 2003 00:19:53 -0500
Date: Fri, 21 Mar 2003 06:30:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Eric Wong <eric@yhbt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.5.64-bk10-C4
In-Reply-To: <20030321004409.GA16206@bl4st.yhbt.net>
Message-ID: <Pine.LNX.4.44.0303210629560.1918-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Mar 2003, Eric Wong wrote:

> Would this be an equivalent fix for 2.4.20-ck4?

yes - but the reverse of it.

> -	long sleep_time = jiffies - p->sleep_timestamp - 1;
> +	unsigned long sleep_time = jiffies - p->sleep_timestamp;
>  	prio_array_t *array = rq->active;
>  
> -	if (!rt_task(p) && (sleep_time > 0)) {
> +	if (!rt_task(p) && sleep_time) {

	Ingo

