Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTIOJZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTIOJZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:25:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:63872 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261698AbTIOJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:25:43 -0400
Date: Mon, 15 Sep 2003 10:39:01 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309150939.h8F9d13D000943@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, piggin@cyberone.com.au
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>That's a non-issue.  300 bytes matters a lot on some systems.  The
> >>>fact that there are drivers that are bloated is nothing to do with
> >>>it.
> >>>
> >>Its kind of irrelevant when by saying "Athlon" you've added 128 byte
> >>alignment to all the cache friendly structure padding.
> >>
> >
> >My intention is that we won't have done 128 byte alignments just by
> >'supporting' Athlons, only if we want to run fast on Athlons.  A
> >distribution kernel that is intended to boot on all CPUs needs
> >workarounds for Athlon bugs, but it doesn't need 128 byte alignment.
> >
> >Obviously using such a kernel for anything other than getting a system
> >up and running to compile a better kernel is a Bad Thing, but the
> >distributions could supply separate Athlon, PIV, and 386 _optimised_
> >kernels.
> >
>
> Why bother with that complexity? Just use 128 byte lines. This allows
> a decent generic kernel. The people who have space requirements would
> only compile what they need anyway.

So, basically, if you compile a kernel for a 386, but think that maybe
one day you might need to run it on an Athlon for debugging purposes,
you use 128 byte padding, because it's not too bad on the 386?  Seems
pretty wasteful to me when the obvious, simple, elegant solution is to
allow independent selection of workaround inclusion and optimisation.
Especially since half of the work has already been done.

John.
