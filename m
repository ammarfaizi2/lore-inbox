Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291756AbSBHT0E>; Fri, 8 Feb 2002 14:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291759AbSBHTZu>; Fri, 8 Feb 2002 14:25:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34732 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291756AbSBHTZg>;
	Fri, 8 Feb 2002 14:25:36 -0500
Date: Fri, 8 Feb 2002 22:23:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Martin Wirth <Martin.Wirth@dlr.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        haveblue <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.GSO.4.21.0202081416410.28514-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0202082221500.17064-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Feb 2002, Alexander Viro wrote:

> Had anyone actually seen lseek() vs. lseek() contention prior to the
> switch to ->i_sem-based variant? [...]

yes, i've seen this for years. (if you accept dbench overhead.)

and regarding the reintroduction of BKL, *please* do not just use a global
locks around such pieces of code, lock bouncing sucks on SMP, even if
there is no overhead.

	Ingo

