Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318082AbSGWIrH>; Tue, 23 Jul 2002 04:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318083AbSGWIrH>; Tue, 23 Jul 2002 04:47:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53448 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318082AbSGWIrG>;
	Tue, 23 Jul 2002 04:47:06 -0400
Date: Tue, 23 Jul 2002 10:49:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: anton wilson <anton.wilson@camotion.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RML pre-emptive 2.4.19-ac2 with O(1)
In-Reply-To: <200207222337.TAA19236@test-area.com>
Message-ID: <Pine.LNX.4.44.0207231048180.2980-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, anton wilson wrote:

> I tried to change the current RML preemptive patch for 2.4.19-rc2 to
> work with the O(1) scheduler patch applied. The only changes I made were
> in sched.c - Not sure if this is a correct change:

looks good at first sight.

this one:

> +
> +       /* Set the preempt count _outside_ the spinlocks! */
> +       idle->preempt_count = (idle->lock_depth >= 0);

needs to be #if CONFIG_PREEMPT.

	Ingo

