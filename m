Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281810AbRLCIvl>; Mon, 3 Dec 2001 03:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284398AbRLCIuD>; Mon, 3 Dec 2001 03:50:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58152 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S282995AbRLBWTv>; Sun, 2 Dec 2001 17:19:51 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lm@bitmover.com (Larry McVoy),
        vonbrand@sleipnir.valparaiso.cl (Horst von Brand),
        linux-kernel@vger.kernel.org (lkml)
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16AeE3-0004ct-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Dec 2001 14:59:32 -0700
In-Reply-To: <E16AeE3-0004ct-00@the-village.bc.nu>
Message-ID: <m1pu5xwaez.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > The next incremental step is to get some good distributed and parallel
> > file systems.  So you can share one filesystem across the cluster.
> > And there is some work going on in those areas.  luster, gfs,
> > intermezzo.
> 
> gfs went proprietary - you want opengfs

Right.
 
> A lot of good work on the rest of that multi-node clustering is going on
> already - take a look at the compaq open source site.

Basically my point.
 
> cccluster is more for numa boxes, but it needs the management and SSI views
> that the compaq stuff offers simply because most programmers won't program
> for a cccluster or manage one.

I've seen a fair number of mpi programs, and if you have a program
that takes weeks to run on a single system.  There is a lot of
incentive to work it out.  Plus I have read about a lot of web sites
that are running on a farm of servers.  Admittedly the normal
architecture has one fat database server behind the web servers, but
that brings me back to needing a good distributed storage techniques.

And I really don't care if most programmers won't program for a
cccluster.  Most programmers don't have one or a problem that needs
one to solve.  So you really only need those people interested in the
problem to work on it.

But single system image type projects are useful, but need to be
watched.  You really need to standardize on how a cluster is put
together (software wise), and making things easier always helps.  But
you also need to be very careful because you can easily write code
that does not scale.  And people doing cluster have wild notions of
scaling o.k. 64 Nodes worked let's try a thousand...

As far as I can tell the only real difference between a numa box, and
a normal cluster of machines running connected with fast ethernet is
that a numa interconnect is a blazingly fast interconnect.  So if you
can come up with a single system image solution over fast ethernet a
ccNuma machine just magically works.

Eric
