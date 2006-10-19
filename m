Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946659AbWJSXUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946659AbWJSXUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946660AbWJSXUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:20:30 -0400
Received: from xenotime.net ([66.160.160.81]:29376 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1946659AbWJSXU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:20:29 -0400
Date: Thu, 19 Oct 2006 16:22:02 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Neil Brown <neilb@suse.de>
Cc: Grant Coady <gcoady.lk@gmail.com>, Al Viro <viro@ftp.linux.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
Message-Id: <20061019162202.1ebc7fc1.rdunlap@xenotime.net>
In-Reply-To: <17719.7138.688743.259430@cse.unsw.edu.au>
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk>
	<1161206763.6095.172.camel@lade.trondhjem.org>
	<17718.51050.186385.512984@cse.unsw.edu.au>
	<20061019012600.GR29920@ftp.linux.org.uk>
	<du2ej21g7pkccoe4cigs8r9gsq1ir6nc9p@4ax.com>
	<17719.7138.688743.259430@cse.unsw.edu.au>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 16:32:02 +1000 Neil Brown wrote:

> On Thursday October 19, grant_lkml@dodo.com.au wrote:
> > On Thu, 19 Oct 2006 02:26:00 +0100, Al Viro <viro@ftp.linux.org.uk> wrote:
> > 
> > >Folks, seriously, please run sparse after changes; it's a simple matter of
> > >make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/; nothing tricky and it saves a lot
> > >of potential PITA...
> > 
> > grant@sempro:~/linux/linux-2.6.19-rc2a$ make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/;
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CHECK   scripts/mod/empty.c
> > /bin/sh: sparse: command not found
> > make[2]: *** [scripts/mod/empty.o] Error 127
> > make[1]: *** [scripts/mod] Error 2
> > make: *** [scripts] Error 2
> > 
> > What sparse?  Pointer please?  Hell of a keyword to search for :(
> > 
> > Thanks,
> > Grant.
> 
> git clone  git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> cd sparse
> make
> make install
> 
> 
> Of course you need git first ... not "GNU Interactive Tools", but
> Linus' SCM.  Most distros have it.

another easy way to get sparse is to grab the latest tarball
snapshot from http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
then
make; make install  # installs into ~/bin, no root required


---
~Randy
