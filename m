Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSCSV1C>; Tue, 19 Mar 2002 16:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSCSV0w>; Tue, 19 Mar 2002 16:26:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65040 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S292852AbSCSV0d>; Tue, 19 Mar 2002 16:26:33 -0500
Date: Tue, 19 Mar 2002 22:24:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: pavel@suse.cz, Trond Myklebust <trond.myklebust@fys.uio.no>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
Message-ID: <20020319212425.GH12260@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200203191345.HAA74864@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >      > Okay, take userland nfs-server. (This thread was about userland
> > >      > filesystems).
> > > 
> > > Yech... Nobody should be seriously considering using unfsd: it does
> > > not even manage to follow the NFS protocol. That inability was one of
> > > the many reasons why Olaf Kirch abandoned further develpement of unfsd
> > > and started work on knfsd.
> > > 
> > >      > Then, make memory full of dirty pages. Imagine that nfs-server
> > >      > is swapped-out by some bad luck. What you have is extremely
> > >      > nasty deadlock, AFAICS. [To free memory you have to write out
> > >      > dirty data, but you can't do that because you don't have enough
> > >      > memory for nfs-server].
> > > 
> > > So that is another argument for using knfsd rather than unfsd. I will
> > > agree with you that NFS is not perfect, but please judge it on its
> > > actual merits and not on some trumped up charge...
> > 
> > Sorry, this thread was about userland filesystems, and NFS is just not
> > usefull there (for read/write case).
> 
> Assuming, of course, that the daemon doesn't mprotect itself...

Even if it did, I'm not sure it would be safe. write() may need some
memory, too.

> A user mode file system is really only good at debugging a design.

Not agreed. I would not want ftpfs in kernel, yet its happy in
userland.

> All file migration style filesystems, and user mode filesystems, have this
> same problem on paging based systems:
> 
> Can't write buffer until file is migrated (file system full),

Well, filesystem full is nasty case. [I wonder how coda solves that?]
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
