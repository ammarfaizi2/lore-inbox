Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264704AbSIRPWc>; Wed, 18 Sep 2002 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbSIRPWc>; Wed, 18 Sep 2002 11:22:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60639 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264704AbSIRPWc>;
	Wed, 18 Sep 2002 11:22:32 -0400
Date: Wed, 18 Sep 2002 17:33:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Cort Dougan <cort@fsmlabs.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918090104.E14918@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0209181711350.22395-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Cort Dougan wrote:

> Can we get a lockless, scalable, fault-tolerant, pre-emption safe,
> zero-copy and distributed get_pid() that meets the Carrier Grade
> specification? [...]

of course, and it should also be massively-threaded, LSB-compliant,
enterprise-ready, secure, cluster-aware, power-saving and self-healing. I
admit that there's still lots of work to be done, but there's just so many
hours in a day.

> If at all possible I need it to do garbage collection, too.

actually, on-the-fly O(log(N)) multiprocessor garbage collection is
already integrated into its high-end modular OO design.

> Perhaps a get_pid() that solves the Turning Halting Problem should be on
> the todo list for 2.6.

the first small mystery to solve are certain perturbations in Alan
Turing's name. But, yes, it's definitely a goal of the PID allocator to be
an answer to all, but also for it to avoid infinite loops for every
possible input value, while yielding slightly more subtle output than the
numeric value of 42. Patch in a few minutes.

	Ingo

