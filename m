Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRAJUjr>; Wed, 10 Jan 2001 15:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbRAJUjh>; Wed, 10 Jan 2001 15:39:37 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:17925 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S129595AbRAJUjR>; Wed, 10 Jan 2001 15:39:17 -0500
Date: Wed, 10 Jan 2001 22:39:16 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error in 2.4.0
Message-ID: <20010110223916.A1131@elektroni.ee.tut.fi>
Mail-Followup-To: Andreas Dilger <adilger@turbolinux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010110171535.A206@elektroni.ee.tut.fi> <200101101904.f0AJ4St12593@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101101904.f0AJ4St12593@webber.adilger.net>; from adilger@turbolinux.com on Wed, Jan 10, 2001 at 12:04:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 12:04:28PM -0700, Andreas Dilger wrote:
> Decoding the first few words to hex, then ASCII gives
> sts.pte_spinlock
> #define pgtable_cache_size      (pgt_quicklists.pgtable_cache_sz)
> #define pgd_
> 
> and I it continues.  The defines are from include/asm-sparc/pgalloc.h
> and it is possible the first few words are out-of-order frees of indirect
> blocks or something.  In any case, were you just untarring a 2.4 kernel
> tree at the time of this problem?  That would be a bad thing, since it
> would point to a bug still in the 2.4.0 kernel.
> 
> Alternately, were you just rm -r an old kernel tree?  Is it possible you
> have not fsck'd this filesystem since running one of 2.4.0-test10 through
> 2.4.0-test12 (or maybe even test13)?  In this case, it is possible that
> the filesystem was corrupted with the older kernels, but you just didn't
> notice it if it was in an unused kernel tree.

It was a file system where I do not work much, so after looking the time
stamps of the directories and studying bash_history I am now rather sure
what I was doing then: 'rm -rf linux-2.2.19pre7'. But it was not exactly an
old kernel tree because I had built it only today morning while running
2.4.0. (It was not an old tree just patched today but I untarred it fresh
from a 2.2.18 tar ball and patched and compiled it after that). The box had
been running 2.4.0 continuously since Sunday 7 Jan and I rebooted it today
afternoon only after I had seen the fs error messages. Until Sunday I was
using only 2.2 kernels. Before Sunday and 2.4.0 the file system was last fscked
on Saturday the 6th because of a power loss!

I did once try some 2.4.0-test kernel on this box but it was a long time ago
(I don't remember which exact version number the kernel had). It seemed to
start up ok then but after starting netscape and moving its windows it hung
and I had to power reset the box and of course it fscked immediately. But it
was a long time ago and after that I have only used 2.2 kernels.

Hmm. It surely seems 2.4.0 is to blame here, I'm afraid.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
