Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136524AbREIPFV>; Wed, 9 May 2001 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136525AbREIPFL>; Wed, 9 May 2001 11:05:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44906 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136524AbREIPEw>; Wed, 9 May 2001 11:04:52 -0400
Date: Wed, 9 May 2001 17:04:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Reto Baettig <baettig@scs.ch>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>
Subject: Re: blkdev in pagecache
Message-ID: <20010509170416.U2506@athlon.random>
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com> <3AF93CA2.F2E8C5DB@mandrakesoft.com> <3AF95C2A.1765681E@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AF95C2A.1765681E@scs.ch>; from baettig@scs.ch on Wed, May 09, 2001 at 05:03:06PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 05:03:06PM +0200, Reto Baettig wrote:
> Jeff Garzik schrieb:
> > 
> > Martin Dalecki wrote:
> > > > - I force the virtual blocksize for all the blkdev I/O
> > > >   (buffered and direct) to work with a 4096 bytes granularity instead of
> > >
> > > You mean PAGE_SIZE :-).
> 
> Or maybe 8192 bytes on alphas ?!? ;-)

Again, see my argument with Jens, if we make it 8k we risk triggering
lowlevel driver assumption about b_size being <= 4k. At least on my
alpha the fs has a 4k blocksize and I think I never tested myself using
a b_size of 8k yet and so I didn't wanted to put too many unknown
variables into the first equation ;).

Andrea
