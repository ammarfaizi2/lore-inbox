Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278293AbRJMOJ4>; Sat, 13 Oct 2001 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278296AbRJMOJr>; Sat, 13 Oct 2001 10:09:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21873 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278293AbRJMOJg>; Sat, 13 Oct 2001 10:09:36 -0400
Date: Sat, 13 Oct 2001 16:10:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: xine pauses with recent (not -ac) kernels
Message-ID: <20011013161001.H714@athlon.random>
In-Reply-To: <01101208552800.00838@baldrick> <01101300085600.00832@baldrick> <20011013001553.F714@athlon.random> <01101315245500.01180@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01101315245500.01180@baldrick>; from duncan.sands@math.u-psud.fr on Sat, Oct 13, 2001 at 03:24:55PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 03:24:55PM +0200, Duncan Sands wrote:
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  3  0  0  25684   3056  40232  88744   0   0   924     0  429  2492  92   8   0
>  2  0  0  25684   3056  41112  87824   0   0   880     0  421  2420  90  10   0
>  1  0  0  25684   3056  42140  86788   0   0  1028     0  455  2638  88  12   0
>  2  0  0  25684   3056  43184  85696   0   0  1044     0  462  2518  87  13   0
>  1  0  0  25684   3056  44144  84732   0   0   960     0  439  2501  94   6   0
>  1  0  0  25684   3112  45096  83756   0   0   952     0  440  2351  89   4   7
>  0  0  0  25684  27260  45096  70380   0   0     0     0  178   283   0   6  94
>  0  0  0  25684  27260  45096  70380   0   0     0     0  122   127   0   2  98

some pagecache is released so this could proof Linus's theory that we
block releasing the pagecache on the blkdev at the last close.

Can you try if his suggested workaround fixes the problem for you?

Andrea
