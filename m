Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136429AbREDPbu>; Fri, 4 May 2001 11:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136430AbREDPbl>; Fri, 4 May 2001 11:31:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12376 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136429AbREDPb0>; Fri, 4 May 2001 11:31:26 -0400
Date: Fri, 4 May 2001 17:29:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010504172940.U3762@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010504135614.S16507@suse.de>; from axboe@suse.de on Fri, May 04, 2001 at 01:56:14PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 01:56:14PM +0200, Jens Axboe wrote:
> Or you can rewrite block_read/write to use the page cache, in which case
> you'd have more luck doing the above.

once block_dev is in pagecache there will obviously be no-way to share
cache between the block device and the filesystem, because all the
caches will be in completly different address spaces.

Andrea
