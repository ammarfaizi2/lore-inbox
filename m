Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271975AbRIIOc2>; Sun, 9 Sep 2001 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271973AbRIIOcS>; Sun, 9 Sep 2001 10:32:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:63793 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271972AbRIIOcF>; Sun, 9 Sep 2001 10:32:05 -0400
Date: Sun, 9 Sep 2001 16:31:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909163156.S11329@athlon.random>
In-Reply-To: <20010908222923.H32553@turbolinux.com> <Pine.LNX.4.33.0109082137060.1161-100000@penguin.transmeta. com> <5.1.0.14.2.20010909135727.00aa8be0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20010909135727.00aa8be0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Sun, Sep 09, 2001 at 02:14:54PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 02:14:54PM +0100, Anton Altaparmakov wrote:
> Not a pitfall, but a question: what happens with the get_block() callback 
> passed to block_read_full_page() by the readpage() address space method of 

anything related to file data uses the "real" pagecache that have
nothing to do with this getblk pagecache backed logic, this is only a
trick to share the ram memory for the physically indexed disk cache and
not to run into the alising issues. I cannot see anything obviously
wrong with this logic so I believe it worth a try to implement but I
will do that after I finished other things. Also since Daniel may have
just finished implementing that he may just send me the buffer.c diff
that I can check and integrate into the blkdev-pagecache work in the
future.

Andrea
