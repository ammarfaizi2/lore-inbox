Return-Path: <linux-kernel-owner+w=401wt.eu-S1753166AbWLOSrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbWLOSrQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbWLOSrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:47:16 -0500
Received: from sbcs.sunysb.edu ([130.245.1.15]:61520 "EHLO sbcs.cs.sunysb.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbWLOSrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:47:15 -0500
Date: Fri, 15 Dec 2006 13:47:10 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Al Boldi <a1426z@gawab.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <200612150803.01246.a1426z@gawab.com>
Message-ID: <Pine.GSO.4.53.0612151241290.26813@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
 <200612141412.30686.a1426z@gawab.com> <Pine.GSO.4.53.0612141828220.8234@compserv1>
 <200612150803.01246.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nikolai Joukov wrote:
> > > > We started the project in April 2004.  Right now I am using it as my
> > > > /home/kolya file system at home.  We believe that at this stage RAIF
> > > > is mature enough for others to try it out.  The code is available at:
> > > >
> > > > 	<ftp://ftp.fsl.cs.sunysb.edu/pub/raif/>
> > > >
> > > > The code requires no kernel patches and compiles for a wide range of
> > > > kernels as a module.  The latest kernel we used it for is 2.6.13 and
> > > > we are in the process of porting it to 2.6.19.
> > > >
> > > > We will be happy to hear your back.
> > >
> > > When removing a file from the underlying branch, the oops below happens.
> > > Wouldn't it be possible to just fail the branch instead of oopsing?
> >
> > This is a known problem of all Linux stackable file systems.  Users are
> > not supposed to change the file systems below mounted stackable file
> > systems (but they can read them).  One of the ways to enforce it is to use
> > overlay mounts.  For example, mount the lower file systems at
> > /raif/b0 ... /raif/bN and then mount RAIF at /raif.  Stackable file
> > systems recently started getting into the kernel and we hope that there
> > will be a better solution for this problem in the future.  Having said
> > that, you are right: failing the branch would be the right thing to do.
>
> Good.  It seems that there is also some tmpfs/raif-over-nfs deadlock
> situation.  Can't really tell if it's the kernel or the raif, but when do
> you think the patches could be brought into sync with the current mainline?

It would be great if you could send us more details about how to recreate
this deadlock and we will take a look at it.  It would be even better if
you and everybody else who finds bugs in RAIF submit the bug reports to:

  <http://bugzilla.fsl.cs.sunysb.edu>

We are in the process of porting RAIF to 2.6.19 right now.  Should be done
in early January.  The trick is that we are trying to keep the same source
good for a wide range of kernel versions.  In fact, not too long ago we
even were able to compile it for 2.4.24!

Nikolai.
---------------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
