Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTBQO1j>; Mon, 17 Feb 2003 09:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBQOML>; Mon, 17 Feb 2003 09:12:11 -0500
Received: from mx1.elte.hu ([157.181.1.137]:25063 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267187AbTBQOJ7>;
	Mon, 17 Feb 2003 09:09:59 -0500
Date: Mon, 17 Feb 2003 15:19:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Don't wake up tasks on offline processors
In-Reply-To: <Pine.LNX.4.50.0302170254480.18087-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0302171518220.24394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:

> This patch stops waking up of tasks onto offline processors. We need
> this when migrating tasks from offline processors onto other online ones
> and to avert a livelock whilst doing so.

this code too should be done in a separate 'zap_runqueue()' function,
which also needs to iterate through all tasks and migrate them off to an
online CPU. This code definitely does not belong into the wakeup hotpath.

	Ingo

