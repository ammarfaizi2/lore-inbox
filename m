Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275798AbRI1CYm>; Thu, 27 Sep 2001 22:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275797AbRI1CYb>; Thu, 27 Sep 2001 22:24:31 -0400
Received: from [195.223.140.107] ([195.223.140.107]:26621 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275795AbRI1CYT>;
	Thu, 27 Sep 2001 22:24:19 -0400
Date: Fri, 28 Sep 2001 04:24:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928042417.J14277@athlon.random>
In-Reply-To: <20010928014720.Z14277@athlon.random> <Pine.LNX.4.33.0109272108400.29056-100000@ping.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109272108400.29056-100000@ping.us.dell.com>; from robert_macaulay@dell.com on Thu, Sep 27, 2001 at 09:12:25PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 09:12:25PM -0500, Robert Macaulay wrote:
> Thanks Andrea. I'll see if we can repeat the 0-page alloc again.

Ok, it is possible the 0-page alloc failed because NOHIGHIO was
disabled, Linus's fix being less finegrined than mine could also lead
more easily to 0-page alloc failed.

However failing bounce-allocation is not important since we have the
reserved pool for those allocations. Not having to use the reserved
pool only allows an higher amount of I/O in parallel. This is why I said
we could have dropped the NOHIGHIO logic in first place if we wanted to
go the non finegrined way.

Andrea
