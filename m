Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRCHQtn>; Thu, 8 Mar 2001 11:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRCHQtX>; Thu, 8 Mar 2001 11:49:23 -0500
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:26830 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S129309AbRCHQtV>; Thu, 8 Mar 2001 11:49:21 -0500
Date: Thu, 8 Mar 2001 09:48:39 -0700 (MST)
From: james rich <james.rich@m.cc.utah.edu>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org
Subject: Re: Questions about Enterprise Storage with Linux
In-Reply-To: <200103081337.HAA76233@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.GSO.4.05.10103080946530.25324-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Jesse Pollard wrote:

> james rich <james.rich@m.cc.utah.edu>:
> > On Wed, 7 Mar 2001, Tom Sightler wrote:
> > 
> > > 2.  Does linux have any problems with large (500GB+) NFS exports, how about
> > > large files over NFS?
> > > 
> > > 3.  What filesystem would be best for such large volumes?  We currently use
> > > reirserfs on our internal system, but they generally have filesystems in the
> > > 18-30GB ranges and we're talking about potentially 10-20x that.  Should we
> > > look at JFS/XFS or others?
> > 
> > I think that for filesystems this size you definately want to look at XFS
> > of JFS.  Maybe you will decide not to use them - but you should test them.
> > 
> > I am currently using XFS and it really works.  It currently has some
> > issues when used with raid 1, but it is probably the most suited for what
> > you want.  Exporting an XFS volume over NFS is no problem.  You can also
> > use xfs_growfs to change the size of your XFS partition.  I haven't had
> > any instability during all the time I've used XFS.
> 
> The biggest difficulty I had with XFS (not on linux as a server) had
> more to do with NFS/XFS performance. The SGI clients worked fine while
> the Linux clients were about 10-20% slower. This was a year ago so this
> may not apply anymore. I haven't seen any Linux NFS benchmarks recently.

Recent changes in CVS appear to have resolved this issue.

James Rich
james.rich@m.cc.utah.edu

