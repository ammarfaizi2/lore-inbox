Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273141AbRIUBYR>; Thu, 20 Sep 2001 21:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274734AbRIUBYG>; Thu, 20 Sep 2001 21:24:06 -0400
Received: from [195.223.140.107] ([195.223.140.107]:9207 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S273141AbRIUBX7>;
	Thu, 20 Sep 2001 21:23:59 -0400
Date: Fri, 21 Sep 2001 03:22:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Stefan Westerfeld <stefan@space.twc.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Message-ID: <20010921032230.Q729@athlon.random>
In-Reply-To: <200109210047.f8L0lkv26045@maile.telia.com> <E15kEjB-0006n9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15kEjB-0006n9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 21, 2001 at 02:03:37AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 02:03:37AM +0100, Alan Cox wrote:
> they dont get stuck doing a huge amount of pageout work for someone else.
> Thats one thing I seem to be seeing with the 10pre11 VM.

actually one feature of the 10pre11 VM is that it will avoid a task to
give to other people the pages that it is freeing for itself. The
previous VM didn't has such a feature. So (in theory :) it should be the
other way around. see the implementation of page_alloc.c::balance_classzone().

Actually Linus found just a few minutes ago a possible source for high
latencies in the pre12 VM, my silly mistake, he will certainly fix it in
pre13 somehow just in case that was the problem.

Andrea
