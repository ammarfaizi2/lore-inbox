Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131285AbRCHH1N>; Thu, 8 Mar 2001 02:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131286AbRCHH1D>; Thu, 8 Mar 2001 02:27:03 -0500
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:64665 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S131285AbRCHH0p>; Thu, 8 Mar 2001 02:26:45 -0500
Date: Thu, 8 Mar 2001 00:22:37 -0700 (MST)
From: james rich <james.rich@m.cc.utah.edu>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Questions about Enterprise Storage with Linux
In-Reply-To: <006301c0a765$3ca118e0$1601a8c0@zeusinc.com>
Message-ID: <Pine.GSO.4.05.10103080016480.9469-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Tom Sightler wrote:

> 2.  Does linux have any problems with large (500GB+) NFS exports, how about
> large files over NFS?
> 
> 3.  What filesystem would be best for such large volumes?  We currently use
> reirserfs on our internal system, but they generally have filesystems in the
> 18-30GB ranges and we're talking about potentially 10-20x that.  Should we
> look at JFS/XFS or others?

I think that for filesystems this size you definately want to look at XFS
of JFS.  Maybe you will decide not to use them - but you should test them.

I am currently using XFS and it really works.  It currently has some
issues when used with raid 1, but it is probably the most suited for what
you want.  Exporting an XFS volume over NFS is no problem.  You can also
use xfs_growfs to change the size of your XFS partition.  I haven't had
any instability during all the time I've used XFS.

James Rich
james.rich@m.cc.utah.edu

