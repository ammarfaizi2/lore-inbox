Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284687AbRLUQPF>; Fri, 21 Dec 2001 11:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284677AbRLUQOz>; Fri, 21 Dec 2001 11:14:55 -0500
Received: from naughty.monkey.org ([204.181.64.8]:36432 "HELO
	naughty.monkey.org") by vger.kernel.org with SMTP
	id <S278660AbRLUQOm>; Fri, 21 Dec 2001 11:14:42 -0500
Date: Fri, 21 Dec 2001 11:14:41 -0500 (EST)
From: Chuck Lever <cel@monkey.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: GOTO Masanori <gotom@debian.or.jp>, <davej@codemonkey.org.uk>,
        <davej@suse.de>, <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: Possible O_DIRECT problems ?
In-Reply-To: <E16HP4f-0001di-00@charged.uio.no>
Message-ID: <Pine.BSO.4.33.0112211109091.25513-100000@naughty.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Trond Myklebust wrote:

> On Friday 21. December 2001 05:12, GOTO Masanori wrote:
> > At Fri, 21 Dec 2001 00:39:42 +0000,
> >
> > Dave Jones <davej@codemonkey.org.uk> wrote:
> > > On Fri, Dec 21, 2001 at 01:23:45AM +0100, Trond Myklebust wrote:
> > >  >    O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
> > >  > Lever's NFS patches you've been testing?
> >
> > Where is Chuck's patch ? I searched but didn't find.
>
> I haven't put it up on my own web-site, but it should be available from the
> CITI NFS client performance project site. See
>
>    http://www.citi.umich.edu/projects/nfs-perf/patches/
>
> > Supporting direct_IO with NFS is some meaningful
> > for users who have fast NAS server environment, IMHO.
>
> It can also provide for better data security in some circumstances.
> Journaling in databases over NFS can for instance benefit greatly, and has
> been one of Chuck's motivations for doing it.

the patch is designed for applications that manage their own data cache,
like databases do.  but it is also useful for applications that want to
move large datasets without blowing the O/S level data cache.

in the NFS case, because O_DIRECT read() and write() always go back to the
server, you can more easily build clustered and HA applications that share
the data storage backend.

	- Chuck Lever
--
corporate:	<cel@netapp.com>
personal:	<chucklever@bigfoot.com>

