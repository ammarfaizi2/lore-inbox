Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129856AbQKKFsT>; Sat, 11 Nov 2000 00:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129829AbQKKFsJ>; Sat, 11 Nov 2000 00:48:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:50953 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129785AbQKKFrx>; Sat, 11 Nov 2000 00:47:53 -0500
Date: Fri, 10 Nov 2000 23:47:50 -0600
To: Robert Lynch <rmlynch@best.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001110234750.B28057@wire.cadcamlab.org>
In-Reply-To: <3A0C86B3.62DA04A2@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0C86B3.62DA04A2@best.com>; from rmlynch@best.com on Fri, Nov 10, 2000 at 03:37:23PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Robert Lynch]
> I've been regularly building kernels in the testXX series, and
> they have been coming out ~ 600K; test10-final and test11-pre1:
> 
> -rw-r--r--    1 root     root       610503 Oct 31 18:39 vmlinuz-t10
> -rw-r--r--    1 root     root       610568 Nov  7 20:26 vmlinuz-t11p01
> 
> test11-pre2 comes out ~ 900K:
> 
> -rw-r--r--    1 root     root       926345 Nov 10 10:16 vmlinuz-t11p02

Track it down yourself:

1) The sizes of your two 'vmlinux' files: do they differ wildly as well?

2a) If no, check the make logs between the vmlinux link line and bzImage
    creation.  Compare the two and note any significant differences.

2b) If yes, write a perl script to compute symbol sizes from each
    System.map file.  (Symbol size == address of next symbol minus
    address of this symbol.)  Sort numerically, then compare old vs new
    for symbols that have grown a lot, or large new symbols.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
