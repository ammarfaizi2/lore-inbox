Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbUBBKak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 05:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbUBBKak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 05:30:40 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6333 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265333AbUBBKaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 05:30:39 -0500
Date: Mon, 2 Feb 2004 11:31:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jos Hulzink <josh@stack.nl>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Message-ID: <20040202103122.GA29402@elte.hu>
References: <200401291917.42087.kernel@kolivas.org> <200401291039.22561.josh@stack.nl> <200402022027.10151.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402022027.10151.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> What this one does is the following; If there is a "nice" difference
> between tasks running on logical cores of the same cpu, the more
> "nice" one will run a proportion of time equal to the timeslice it
> would have been given relative to the less "nice" task.  ie a nice 19
> task running on one core and the nice 0 task running on the other core
> will let the nice 0 task run continuously (102ms is normal timeslice)
> and the nice 19 task will only run for the last 10ms of time the nice
> 0 task is running. This makes for a much more balanced resource
> distribution, gives significant preference to the higher priority
> task, but allows them to benefit from running on both logical cores.

this is a really good rule conceptually - the higher prio task will get
at least as much raw (unshared) physical CPU slice as it would get
without HT.

	Ingo
