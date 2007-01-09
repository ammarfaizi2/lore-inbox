Return-Path: <linux-kernel-owner+w=401wt.eu-S932217AbXAISY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbXAISY2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbXAISY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:24:28 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:56161 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbXAISY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:24:27 -0500
Date: Tue, 9 Jan 2007 13:24:18 -0500
Message-Id: <200701091824.l09IOICE010721@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: "Erez Zadok" <ezk@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       kolya@cs.sunysb.edu
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Tue, 09 Jan 2007 20:03:15 +0200."
             <5d96567b0701091003i6a98f8fep60d1a0b9c6c586d1@mail.gmail.com> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5d96567b0701091003i6a98f8fep60d1a0b9c6c586d1@mail.gmail.com>, "Raz Ben-Jehuda(caro)" writes:
> On 1/9/07, Erez Zadok <ezk@cs.sunysb.edu> wrote:
> > In message <20070109095345.GB12406@infradead.org>, Christoph Hellwig writes:
> > > On Mon, Jan 08, 2007 at 07:03:35PM -0500, Erez Zadok wrote:
> > > > However, I must caution that a file system like ecryptfs is very different
> > > > from Unionfs, the latter being a fan-out file system---and both have very
> > > > different goals.  The common code between the two file systems, at this
> > > > stage, is not much (and we've already extracted some of it into the "stackfs
> > > > layer").
> > >
> > > I think that's an very important point.  We have a chance to get that
> > > non-fanout filesystems right quite easily - something I wished that would
> > > have been done before the ecryptfs merge - while getting fan-out stackable
> > > filesystems is a really hard task.  In addition to that I know exactly
> > > one fan-out stackable filesystem that is posisbly useful, which is unionfs.
> >
> > Christoph, on our Unionfs mailing list, we've been asked numerous times for
> > additional functionality.  People asked for load balancing based on CPU
> > time, rtt, latency, space available, etc.  People asked for replication
> > functionality.  People asked for failover.  And more.  Some users have
> > become so motivated, that they developed and maintain their own Unionfs
> > patches to support rudimentary load-balancing and replication.
> >
> > Our answer had always been the same: those features are nice, but have no
> > place in Unionfs.  That's why we've created RAIF, exactly to give all those
> 
> Erez hello
> my name is raz.
> Just for my better understanding , raifs stands for raided file system ?
> what sort of raids do they have ?
> thank you
> raz

To start with, see <http://www.fsl.cs.sunysb.edu/project-raif.html> for
software and documentation.  RAIF is storage virtualization at the file
level.  It can do levels 0, 1, 2, 4, 5, 6, and several combos.  It's
designed such that you could easily plugin a new RAID policy/level that you
invent.  We've got LB functionality too (RR and proportional share).  And
you can configure stuff on a per file, per dir, or per file-type basis.

BTW, the lkml forum may not be the best forum to discuss it: better divert
future discussions to fsdevel or one of our lists (which you can get to from
the RAIF project URL above).

Cheers,
Erez.
