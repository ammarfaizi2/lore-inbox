Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285045AbRLKNqe>; Tue, 11 Dec 2001 08:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285031AbRLKNqZ>; Tue, 11 Dec 2001 08:46:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25922 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285032AbRLKNqQ>; Tue, 11 Dec 2001 08:46:16 -0500
Date: Tue, 11 Dec 2001 14:46:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211144634.F4801@athlon.random>
In-Reply-To: <3C15B0B3.1399043B@zip.com.au> <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Dec 11, 2001 at 11:32:25AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:32:25AM -0200, Rik van Riel wrote:
> On Mon, 10 Dec 2001, Andrew Morton wrote:
> 
> > This test on a 64 megabyte machine, on ext2:
> >
> > 	time (tar xfz /nfsserver/linux-2.4.16.tar.gz ; sync)
> >
> > On 2.4.17-pre7 it takes 21 seconds.  On -aa it is much slower: 36 seconds.
> 
> > Execution time for `make -j12 bzImage' on a 64meg RAM/512 meg swap
> > dual x86:
> >
> > -aa:					4 minutes 20 seconds
> > 2.4.7-pre8				4 minutes 8 seconds
> > 2.4.7-pre8 plus the below patch:	3 minutes 55 seconds
> 
> 
> Andrea, it seems -aa is not the holy grail VM-wise. If you want

it may be not a holy grail in swap benchmarks and flood of writes to
disk, those are minor performance regressions, but I have no one single
bug report related to "stability".

The only thing I got back from Andrew is been "it runs a little slower"
in those two tests.

and of course he didn't even attempted to benchmark the interactive
feeling that was the _whole_ point of my buffer.c and elevator changes.

So as far as I'm concerned 2.4.15aa1 and 2.4.17pre?aa? are just rock
solid and usable in production.

We'll keep doing background benchmarking and changes that cannot
affect stability, but the core design is finished as far I can tell.

Andrea
