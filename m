Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbRFNSQ5>; Thu, 14 Jun 2001 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263608AbRFNSQr>; Thu, 14 Jun 2001 14:16:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17210 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263607AbRFNSQk>; Thu, 14 Jun 2001 14:16:40 -0400
Date: Thu, 14 Jun 2001 20:16:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Henderson <rth@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614201634.C2115@athlon.random>
In-Reply-To: <20010614191219.A30567@athlon.random> <20010614191634.B30567@athlon.random> <20010614192122.C30567@athlon.random> <20010614103249.A28852@redhat.com> <20010614194757.B715@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010614194757.B715@athlon.random>; from andrea@suse.de on Thu, Jun 14, 2001 at 07:47:57PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:47:57PM +0200, Andrea Arcangeli wrote:
> On Thu, Jun 14, 2001 at 10:32:49AM -0700, Richard Henderson wrote:
> > within glibc, and (2) making these accesses slower since they
> > will be considered O_DIRECT after the change.
> 
> and then read/write will return -EINVAL which is life-threatening.
> O_DIRECT like rawio via /dev/raw imposes special buffer size and
> alignment (size multiple of softblocksize of the fs and softblocksize
> alignment, at max I can turn it down to hardblocksize without intensive
> changes and guaranteeing zerocopy [modulo bounce buffers on x86 of
> course]).
> 
> So in short at least glibc would need to be replaced...

in the meantime we solve this issue I released a new o_direct patch and
a 2.4.6pre3aa1 with O_DIRECT set like in the patches I sent to Linus at
the start of the thread. As soon as we take a definitive decision I will
update them. (in the meantime alpha users will at least be allowed again
to use O_SYNC with o_direct support applied ;)

Andrea
