Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSGASt6>; Mon, 1 Jul 2002 14:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSGASt5>; Mon, 1 Jul 2002 14:49:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24803 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316204AbSGAStz>;
	Mon, 1 Jul 2002 14:49:55 -0400
Date: Mon, 1 Jul 2002 20:49:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0207012041110.13852-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Jul 2002, Bill Davidsen wrote:

> What's the issue? The most popular trees have been using it without
> issue for six months or so, and I know of no cases of bad behaviour.  
> [...]

well, the patch is barely 6 months old. A new scheduler changes the
'heart' of the kernel and something like that should not be done for the
stable branch, especially since it has finally started to converge towards
a state that can be called stable ...

> [...] I know there are people who don't believe in the preempt patch,
> but the new scheduler seems to work better under both desktop and server
> load.

well, the preempt patch is rather for RT-type workloads where milliseconds
matter, which improvements are not a matter of belief, but a matter of
hard latencies. Mere mortals should hardly notice its effects under normal
loads - perhaps a bit more 'snappiness'. But such effects do accumulate
up, and people are seeing visible improvements with combo-patches of
lowlat-lockbreak+preempt+O(1).

	Ingo

