Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292969AbSBVTqN>; Fri, 22 Feb 2002 14:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292966AbSBVTqA>; Fri, 22 Feb 2002 14:46:00 -0500
Received: from zok.SGI.COM ([204.94.215.101]:128 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292970AbSBVTnx>;
	Fri, 22 Feb 2002 14:43:53 -0500
Date: Fri, 22 Feb 2002 11:44:10 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Erich Focht <efocht@ess.nec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech <lse-tech@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for
 non-current tasks
In-Reply-To: <Pine.LNX.4.33.0202221003120.3674-100000@localhost.localdomain>
Message-ID: <Pine.SGI.4.21.0202221136510.570279-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Ingo Molnar wrote:
> 
> well, how do you migrate the task from an IRQ context?

Let it remove itself, in due time.

> even if it worked, this adds a 1/(2*HZ) average latency to the migration.
> I wanted to have something that is capable of migrating tasks 'instantly'.

That's the key question, from my perspective.

I was not aware of any need for instant migration, and to
the best of my knowledge, a clock tick latency was just fine.
But if your intuition suggests its worth supporting instant
migration, go for it.

The main concern I had with Erich Focht's patches that also
attempted instant migration was that Ingo wouldn't agree.
Somehow, I don't think that concern applies for your patches.

Thanks, Ingo!  I'm delighted with the outcome.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

