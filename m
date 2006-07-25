Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWGYEZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWGYEZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWGYEZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:25:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20408 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932428AbWGYEZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:25:14 -0400
Subject: Re: [NFS] [PATCH 002 of 9] knfsd: knfsd: Remove an unused variable
	from e_show().
From: Greg Banks <gnb@melbourne.sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <17605.39934.963857.665398@cse.unsw.edu.au>
References: <20060725114207.21779.patches@notabene>
	 <1060725015432.21921@suse.de>
	 <20060725041059.GA13294@filer.fsl.cs.sunysb.edu>
	 <17605.39934.963857.665398@cse.unsw.edu.au>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1153801496.1547.652.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 25 Jul 2006 14:24:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 14:20, Neil Brown wrote:
> On Tuesday July 25, jsipek@fsl.cs.sunysb.edu wrote:
> > On Tue, Jul 25, 2006 at 11:54:32AM +1000, NeilBrown wrote:
> > ...
> > > diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
> > > --- .prev/fs/nfsd/export.c	2006-07-24 14:33:06.000000000 +1000
> > > +++ ./fs/nfsd/export.c	2006-07-24 14:33:26.000000000 +1000
> > > @@ -1178,7 +1178,6 @@ static int e_show(struct seq_file *m, vo
> > ...
> > >  	if (p == (void *)1) {
> > 
> > I'm not an NFS expert, but the above makes me want to puke. Isn't there a
> > cleaner way of doing whatever needs to be done without:
> > 
> > 1) hard-coding a constant
> > 2) comparing a variable to an arbitrary pointer
> > 
> 
> Probably.  We just need a pointer value that is definitely not a
> pointer to a valid cache_head object, and is not NULL.
> (void*)1 seems a reasonable choice, but maybe #defineing something
> would help.

include/linux/seq_file.h:

#define SEQ_START_TOKEN ((void *)1)

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


