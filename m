Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268906AbSIRSBi>; Wed, 18 Sep 2002 14:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268907AbSIRSBi>; Wed, 18 Sep 2002 14:01:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22657 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268906AbSIRSBh>;
	Wed, 18 Sep 2002 14:01:37 -0400
Date: Wed, 18 Sep 2002 20:14:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918115835.B656@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0209182008490.25598-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Cort Dougan wrote:

> You're talking about a different problem there.  Creating a thread
> within a realistic time-limit for a sensible number of threads is not a
> bad idea. Doing it for a huge number of threads may not be something
> that has to be done right away.  Don't screw up the low to middle-end -
> that trend is getting frightening in Linux.

sorry, but you must have missed the patch i posted yesterday. It can be
done, it's fast, it does not hurt *any* benchmark and it actually has a
worst-case cache-cold latency of 10 microseconds, even if 1 million
threads are started up already.

and besides it significantly speeds up some other areas as well, like
session management in shells, group-signal delivery performance, tty
handling and more.

	Ingo

