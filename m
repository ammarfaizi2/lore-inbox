Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbQK3VMl>; Thu, 30 Nov 2000 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130076AbQK3VMc>; Thu, 30 Nov 2000 16:12:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8768 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129815AbQK3VMZ>; Thu, 30 Nov 2000 16:12:25 -0500
Date: Thu, 30 Nov 2000 21:41:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, V Ganesh <ganesh@veritas.com>,
        linux-kernel@vger.kernel.org, linux-LVM@sistina.com, mingo@redhat.com
Subject: Re: [PATCH] Re: [bug] infinite loop in generic_make_request()
Message-ID: <20001130214121.D18804@athlon.random>
In-Reply-To: <14886.7367.247491.267120@notabene.cse.unsw.edu.au> <200011302005.eAUK5re01932@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011302005.eAUK5re01932@webber.adilger.net>; from adilger@turbolinux.com on Thu, Nov 30, 2000 at 01:05:53PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 01:05:53PM -0700, Andreas Dilger wrote:
> the RAID and LVM make_request functions should be changed to do that
> instead (i.e. 0 on success, -ve on error, and maybe "1" if they do their
> own recursion to break the loop)?

We preferred to let the lowlevel drivers to handle error themselfs to
simplify the interface. The lowlevel driver needs to call buffer_IO_error
before returning in case of error.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
