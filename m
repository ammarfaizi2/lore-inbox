Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRCRADD>; Sat, 17 Mar 2001 19:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRCRACx>; Sat, 17 Mar 2001 19:02:53 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:9089 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129115AbRCRACq>; Sat, 17 Mar 2001 19:02:46 -0500
Message-ID: <3AB3FB5A.BAA50BEA@uow.edu.au>
Date: Sun, 18 Mar 2001 11:03:38 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
        mc@cs.stanford.edu
Subject: Re: [CHECKER] 28 potential interrupt errors
In-Reply-To: <Pine.GSO.4.31.0103162216360.10409-100000@elaine24.Stanford.EDU> <Pine.LNX.4.30.0103172238030.17004-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> [ n_r3964.c stuff ]
> ...
> akpm, were you looking at this?

I'm planning on poking through everything which has been
identified as a posible problem.  But I won't start for
several weeks - give the maintainers (if any) time to
address these things.

So.. please go ahead :)

There's another thing which needs doing to n_r3964.c, BTW - the
abuse of task queues in r3964_close().  This is, I think, the
only client of task queues which needs to poke so deeply into
the implementation internals and Linus has mentioned something about
needing to redesign the task queues in 2.5.  So n_r3964 needs
somehow to be redesigned so that it can use standard APIs.

-
