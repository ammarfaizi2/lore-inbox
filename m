Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbRLUQFO>; Fri, 21 Dec 2001 11:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLUQFF>; Fri, 21 Dec 2001 11:05:05 -0500
Received: from naughty.monkey.org ([204.181.64.8]:49560 "HELO
	naughty.monkey.org") by vger.kernel.org with SMTP
	id <S284669AbRLUQE4>; Fri, 21 Dec 2001 11:04:56 -0500
Date: Fri, 21 Dec 2001 11:04:45 -0500 (EST)
From: Chuck Lever <cel@monkey.org>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: <davej@codemonkey.org.uk>, <trond.myklebust@fys.uio.no>, <davej@suse.de>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: Possible O_DIRECT problems ?
In-Reply-To: <w53ellp2out.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.BSO.4.33.0112211059090.25513-100000@naughty.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:  the complete patch against 2.4.16 (should work with little or no
modification against 2.4.17) is here:

http://www.citi.umich.edu/projects/nfs-perf/patches/

you'll need to apply inode2file.diff then nfs-odirect11.diff, and it
requires Trond's pathconf patch in order to be completely useful.

because O_DIRECT cannot do small I/O (must be a multiple of a block size),
does fsx work when using it?  can someone describe the failures?

On Fri, 21 Dec 2001, GOTO Masanori wrote:

> At Fri, 21 Dec 2001 00:39:42 +0000,
> Dave Jones <davej@codemonkey.org.uk> wrote:
> >
> > On Fri, Dec 21, 2001 at 01:23:45AM +0100, Trond Myklebust wrote:
> >
> >  >    O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
> >  > Lever's NFS patches you've been testing?
>
> Where is Chuck's patch ? I searched but didn't find.
>
> > Nope, stock 2.4.17rc2 & 2.5.1.
> > I thought NFS might just ignore the O_DIRECT flag if it didn't
> > understand it yet, I wasn't expecting such a dramatic failure.
>
> Supporting direct_IO with NFS is some meaningful
> for users who have fast NAS server environment, IMHO.
>
> > I just got reminded of the bugs Andrew Morton & some others
> > found in O_DIRECT, so this may be hitting the same problems
> > already found.
>
> No, I think it's another issue, but it may be another bugs...
>
> -- gotom
>

	- Chuck Lever
--
corporate:	<cel@netapp.com>
personal:	<chucklever@bigfoot.com>

