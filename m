Return-Path: <linux-kernel-owner+w=401wt.eu-S1161060AbXALLCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbXALLCo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbXALLCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:02:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2265 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161072AbXALLCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:02:42 -0500
Date: Thu, 11 Jan 2007 14:29:56 +0000
From: Pavel Machek <pavel@suse.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jan Kara <jack@suse.cz>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: unionfs unusable on multiuser systems (was Re: [PATCH 01/24] Unionfs: Documentation)
Message-ID: <20070111142956.GA6843@ucw.cz>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org> <20070108231524.GA1269@filer.fsl.cs.sunysb.edu> <20070109121552.GA1260@atrey.karlin.mff.cuni.cz> <1168360219.6054.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168360219.6054.14.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That statement is meant to scare people away from modifying the lower fs :)
> > > I tortured unionfs quite a bit, and it can oops but it takes some effort.
> >   But isn't it then potential DOS? If you happen to union two filesystems
> > and an untrusted user has write access to both original filesystem and
> > the union, then you say he'd be able to produce oops? That does not
> > sound very secure to me... And if any secure use of unionfs requires
> > limitting access to the original trees, then I think it's a good reason
> > to implement it in unionfs itself. Just my 2 cents.
> 
> You mean somebody like, say, a perfectly innocent process working on the
> NFS server or some other client that is oblivious to the existence of
> unionfs stacks on your particular machine?
> To me, this has always sounded like a showstopper for using unionfs with
> a remote filesystem.

Actually, it is worse than that. find / (and updatedb) *will* write to
all the filesystems (atime).

Expecting sysadmins to know/prevent this seems like expecting quite a
lot from them. Sounds like a show stopper to me :-(....
							Pavel
-- 
Thanks for all the (sleeping) penguins.
