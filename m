Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287539AbSAFCWI>; Sat, 5 Jan 2002 21:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287002AbSAFCV5>; Sat, 5 Jan 2002 21:21:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23700 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287267AbSAFCVn>;
	Sat, 5 Jan 2002 21:21:43 -0500
Date: Sun, 6 Jan 2002 05:19:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <E16N35L-00024p-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201060517480.6501-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Alan Cox wrote:

> There are better algorithms than the branching one already. You can do
> it a 32bit one with a multiply shift and 6 bit lookup if your multiply
> is ok, or for non superscalar processors using shift and adds.
>
> 64bit is 32bit ffz(x.low|x.high) and a single bit test

ok - i wasnt thinking straight. as few branches as possible should be the
way to go, no BTB will help such functions so branches must be reduced.

	Ingo

