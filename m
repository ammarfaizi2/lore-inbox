Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbRBVXbC>; Thu, 22 Feb 2001 18:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbRBVXaw>; Thu, 22 Feb 2001 18:30:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60174 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129150AbRBVXam>; Thu, 22 Feb 2001 18:30:42 -0500
Date: Thu, 22 Feb 2001 19:44:11 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
In-Reply-To: <20010222235700.B30330@athlon.random>
Message-ID: <Pine.LNX.4.21.0102221915370.2435-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Feb 2001, Andrea Arcangeli wrote:

<snip>

> However if you have houndred of different queues doing I/O at the same
> time it may make a difference, but probably with tons of harddisks
> you'll also have tons of ram... In theory we could put a global limit
> on top of the the per-queue one. Or we could at least upper bound the
> total_ram / 3.

The global limit on top of the per-queue limit sounds good. 

Since you're talking about the "total_ram / 3" hardcoded value... it
should be /proc tunable IMO. (Andi Kleen already suggested this)

