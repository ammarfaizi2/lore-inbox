Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTCFO7h>; Thu, 6 Mar 2003 09:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTCFO7h>; Thu, 6 Mar 2003 09:59:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19467 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264711AbTCFO7g>; Thu, 6 Mar 2003 09:59:36 -0500
Date: Thu, 6 Mar 2003 07:07:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060845510.4248-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303060704580.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> 
> please do another thing as well: in addition to applying the -A4 patch,
> also renice X to -10.

NO.

This is a BUG IN THE SCHEDULER!

We should notice automatically that X is "interactive", thanks to the 
fact that interactive tasks wait for it. That's the whole point of my very 
simple patch..

So don't argue about things that are obviously broken. Renicing X is not 
the answer, and in fact there have been multiple reports that it makes 
XMMS skip sound because it just _hides_ the problem and moves it 
elsewhere.

Please test my simple patch that should at least attack the real issue 
instead of waffling and hiding it.

			Linus

