Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280571AbRKBFx5>; Fri, 2 Nov 2001 00:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280572AbRKBFxs>; Fri, 2 Nov 2001 00:53:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34105 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280571AbRKBFxd>; Fri, 2 Nov 2001 00:53:33 -0500
Date: Fri, 2 Nov 2001 06:52:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Zlatko's I/O slowdown status
Message-ID: <20011102065255.B3903@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0110261018270.1001-100000@penguin.transmeta.com> <87k7xfk6zd.fsf@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87k7xfk6zd.fsf@atlas.iskon.hr>; from zlatko.calusic@iskon.hr on Sun, Oct 28, 2001 at 06:30:14PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zlatko,

I'm not sure how the email thread ended but I noticed different
unplugging of the I/O queues in mainline (mainline was a little more
overkill than -ac) and also wrong bdflush histeresis (pre-wakekup of
bdflush to avoid blocking if the write flood could be sustained by the
bandwith of the HD was missing for example).

So you may want to give a spin to pre6aa1 and see if it makes any
difference, if it makes any difference I'll know what your problem is
(see the buffer.c part of the vm-10 patch in pre6aa1 for more details).

thanks,

Andrea
