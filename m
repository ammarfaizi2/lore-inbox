Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTL0Xgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 18:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTL0Xgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 18:36:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43095 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264880AbTL0Xgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 18:36:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
	<2003Dec27.212103@a0.complang.tuwien.ac.at>
	<Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Dec 2003 16:31:22 -0700
In-Reply-To: <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
Message-ID: <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 27 Dec 2003, Anton Ertl wrote:
> > 
> > And you probably mean "repeatable every time".  Ok, then a random
> > scheme has, by your definition, no pathological worst case.  I am not
> > sure that this is a consolation when I happen upon one of its
> > unpredictable and unrepeatable worst cases.
> 
> Those "unpredictable" cases are so exceedingly rare that they aren't worth
> worrying about.

They show up a lot in benchmarks which makes the something
to worry about.  Even if real world applications don't show
the same behavior.  Of course it is stupid to tune machines
to the benchmarks but...

> Basically: prove me wrong. People have tried before. They have failed. 
> Maybe you'll succeed. I doubt it, but hey, I'm not stopping you.

For anyone taking you up on this I'd like to suggest two possible
directions.

1) Increasing PAGE_SIZE in the kernel.
2) Creating zones for the different colors.  Zones were not
   implemented last time, this was tried.

Both of those should be minimal impact to the complexity
of the current kernel. 

I don't know where we will wind up but the performance variation's
caused by cache conflicts in today's applications are real, and easily
measurable.  Giving the growing increase in performance difference
between CPUs and memory Amdahl's Law shows this will only grow
so I think this is worth looking at.

Eric
