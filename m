Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRHLWZB>; Sun, 12 Aug 2001 18:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269490AbRHLWYv>; Sun, 12 Aug 2001 18:24:51 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:16652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269489AbRHLWYt>; Sun, 12 Aug 2001 18:24:49 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 12 Aug 2001 15:24:16 -0700
Message-Id: <200108122224.f7CMOGO01895@penguin.transmeta.com>
To: manuel@mclure.org, linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Newsgroups: linux.dev.kernel
In-Reply-To: <20010812145953.A955@ulthar.internal.mclure.org>
In-Reply-To: <20010812113142.G948@ulthar.internal.mclure.org> <E15W1eR-000691-00@the-village.bc.nu> <20010812133539.A17802@ulthar.internal.mclure.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010812145953.A955@ulthar.internal.mclure.org> you write:
>
>I've answered that one on my own - I installed today's CVS emu10k1 and got
>another Oops:

The oops seems to be due to "wave_dev->woinst" being NULL.

Can you try just adding the line

	if (!woinst)
		return;

to the top of the function (just before the "spin_lock_irqsave()"). Does
that fix it for you?

		Linus
