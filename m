Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSEEAYI>; Sat, 4 May 2002 20:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSEEAYH>; Sat, 4 May 2002 20:24:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5184 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315785AbSEEAYG>; Sat, 4 May 2002 20:24:06 -0400
Date: Sun, 5 May 2002 02:25:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.4.19pre8aa2
Message-ID: <20020505022508.J1260@dualathlon.random>
In-Reply-To: <20020504165440.C1260@dualathlon.random> <20020504160235.A14926@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 04:02:35PM +0100, Christoph Hellwig wrote:
> On Sat, May 04, 2002 at 04:54:40PM +0200, Andrea Arcangeli wrote:
> > Only in 2.4.19pre8aa2: 00_comx-driver-compile-1
> > 
> > 	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
> > 	it can link as a module, noticed by Eyal Lebedinsky.
> 
> Don't do this - proc_get_inode is static for a reason and doing this
> export in the SuSE tree for ages doesn't make it any better.
> 
> The driver needs serious fixing instead.

I see the driver would better not use procfs that way, but as far I can
tell it's a clean-desing problem, not a pratical problem so I documented
it with a quite explicit name of the patch (and I don't recommend to
merge it in any monolithic tree out there were it could be forgotten, at
the very least it'd need a bold comment on it) and I'll backout as soon
as the driver is fixed. It seems Al started working on it on top of
2.4.5-ac16 on 22 Jun 2001 and after one year the proc_get_inode is still
there so I don't buy the argument that by not exporting it the driver
gets fixed faster, it just remains unusable as module it seems. the
important thing is that it doesn't get forgotten and the name of the
patch ensures that from my part.

Andrea
