Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318334AbSGYBRO>; Wed, 24 Jul 2002 21:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318335AbSGYBRO>; Wed, 24 Jul 2002 21:17:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29457 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318334AbSGYBRN>; Wed, 24 Jul 2002 21:17:13 -0400
Date: Wed, 24 Jul 2002 18:21:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@zip.com.au>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] updated low-latency zap_page_range
In-Reply-To: <1027559785.17950.3.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207241820170.5944-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Jul 2002, Robert Love wrote:
>
> 	if (preempt_count() == 1 && need_resched())
>
> Then we get "if (0 && ..)" which should hopefully be evaluated away.

I think preempt_count() is not unconditionally 0 for non-preemptible
kernels, so I don't think this is a compile-time constant.

That may be a bug in preempt_count(), of course.

		Linus

