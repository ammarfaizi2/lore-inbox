Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289103AbSAGDfo>; Sun, 6 Jan 2002 22:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289105AbSAGDfe>; Sun, 6 Jan 2002 22:35:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45829 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289103AbSAGDfb>; Sun, 6 Jan 2002 22:35:31 -0500
Date: Sun, 6 Jan 2002 19:34:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Richard Henderson <rth@twiddle.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201061927490.1000-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201061930250.5900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Davide Libenzi wrote:
>
> 32 bit words lookup can be easily done in few clock cycles in most cpus
> by using tuned assembly code.

I tried to time "bsfl", it showed up as one cycle more than "nothing" on
my PII.

It used to be something like 7+n cycles on a i386, if I remember
correctly. It's just not an issue any more - trying to use clever code to
avoid it is just silly.

		Linus

