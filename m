Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318199AbSGQGob>; Wed, 17 Jul 2002 02:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSGQGoa>; Wed, 17 Jul 2002 02:44:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20454 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318199AbSGQGoa>;
	Wed, 17 Jul 2002 02:44:30 -0400
Date: Thu, 18 Jul 2002 08:46:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: oleg@tv-sign.ru, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling,
 SCHED_BATCH
In-Reply-To: <20020714122911.GA179@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0207180842430.21102-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jul 2002, Pavel Machek wrote:

> Does it mean that we now have working scheduler class that only
> schedules jobs when no other thread wants to run (as long as SCHED_BATCH
> task does not enter the kernel)?

yes, that's exactly the point of SCHED_BATCH. Furthermore: it enables the
correct timeslicing of such SCHED_BATCH tasks as well between each other -
so it's not equivalent to 'infinitely low SCHED_NORMAL priority', but it's
rather an additional hierarchy of scheduling classes. Plus it uses longer
timeslices.

	Ingo

