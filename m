Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRCHNiu>; Thu, 8 Mar 2001 08:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbRCHNik>; Thu, 8 Mar 2001 08:38:40 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:21609 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131369AbRCHNi3>; Thu, 8 Mar 2001 08:38:29 -0500
Date: Thu, 8 Mar 2001 07:37:51 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103081337.HAA76233@tomcat.admin.navo.hpc.mil>
To: james.rich@m.cc.utah.edu, Tom Sightler <ttsig@tuxyturvy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Questions about Enterprise Storage with Linux
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james rich <james.rich@m.cc.utah.edu>:
> On Wed, 7 Mar 2001, Tom Sightler wrote:
> 
> > 2.  Does linux have any problems with large (500GB+) NFS exports, how about
> > large files over NFS?
> > 
> > 3.  What filesystem would be best for such large volumes?  We currently use
> > reirserfs on our internal system, but they generally have filesystems in the
> > 18-30GB ranges and we're talking about potentially 10-20x that.  Should we
> > look at JFS/XFS or others?
> 
> I think that for filesystems this size you definately want to look at XFS
> of JFS.  Maybe you will decide not to use them - but you should test them.
> 
> I am currently using XFS and it really works.  It currently has some
> issues when used with raid 1, but it is probably the most suited for what
> you want.  Exporting an XFS volume over NFS is no problem.  You can also
> use xfs_growfs to change the size of your XFS partition.  I haven't had
> any instability during all the time I've used XFS.

The biggest difficulty I had with XFS (not on linux as a server) had
more to do with NFS/XFS performance. The SGI clients worked fine while
the Linux clients were about 10-20% slower. This was a year ago so this
may not apply anymore. I haven't seen any Linux NFS benchmarks recently.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
