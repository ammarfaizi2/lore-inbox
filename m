Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131678AbRCSX2j>; Mon, 19 Mar 2001 18:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbRCSX23>; Mon, 19 Mar 2001 18:28:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17676 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131674AbRCSX2N>; Mon, 19 Mar 2001 18:28:13 -0500
Date: Mon, 19 Mar 2001 15:27:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <001201c0b0ca$30eb1910$5517fea9@local>
Message-ID: <Pine.LNX.4.31.0103191525480.937-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Manfred Spraul wrote:
>
> Rik, did you check that {pte,pmd}_alloc are thread safe? At least in
> 2.4.2 they aren't (include/asm-i386/pgalloc.h), and your patch doesn't
> touch pgalloc.

Excellent point. We used to do all the looping and re-trying, but it got
ripped out a long time ago (and in any case, it historically didn't do
SMP, so the old code doesn't really work).

		Linus

