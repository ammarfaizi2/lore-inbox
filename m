Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTGISAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbTGISAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:00:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52195 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265367AbTGISAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:00:16 -0400
Date: Wed, 9 Jul 2003 15:08:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
In-Reply-To: <200307091954.12895.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
References: <20030709133109.A23587@infradead.org> <200307091943.13680.m.c.p@wolk-project.de>
 <Pine.LNX.4.55L.0307091445470.27004@freak.distro.conectiva>
 <200307091954.12895.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jul 2003, Marc-Christian Petersen wrote:

> On Wednesday 09 July 2003 19:46, Marcelo Tosatti wrote:
>
> Hi Marcelo,
>
> > > > > > I just got a nice XFS oops due to the direct_IO API change in
> > > > > > 2.4.  Guys, this is a STABLE series and APIs are supposed to be
> > > > > > exactly that, _STABLE_.  If you really think O_DIRECT on NFS is soo
> > > > > > important please add a ->direct_IO2 for NFS like the reiserfs
> > > > > > read_inode2 hack.
> > >
> > > I wonder why -aa and -wolk don't have these problems with O_DIRECT vs.
> > > XFS.
> > Do they have the NFS DIRECT IO patch?
> Yes. If not, my sentence would be superflous ;)

Ok, right. Well, I dont know why it doesnt happen there. Maybe not enough
testing?

Anyway, I'm going to revert the NFS DIRECT IO patch because, as Christoph
mentioned, breaks the API.

I except another solution from Trond (maybe ->direct_IO2).

