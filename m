Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTLEAPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTLEAPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:15:12 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:18184 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263768AbTLEAPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:15:02 -0500
Date: Thu, 4 Dec 2003 16:14:58 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031205001458.GD14401@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz> <bql9kk$iq1$1@gatekeeper.tmr.com> <20031204012420.GE4420@pegasys.ws> <20031204014743.GF29119@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204014743.GF29119@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Reading this message may result in the loss of free will.  Read and obey.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 05:47:43PM -0800, Mike Fedyk wrote:
> On Wed, Dec 03, 2003 at 05:24:20PM -0800, jw schultz wrote:
> > <OT>
> > As a datapoint i'm running ext2, reiserfs, JFS and XFS each
> > for different reasons.
> > 
> > 	ext2 -- boot (i'm stodgy) and 2kb blocks for archive CDs
> > 
> > 	reiserfs3 -- filesystems not exported nfs (no
> > 	historical version level that i can confirm whether
> > 	i have or not will namesys assert is reliable over
> > 	nfs)
> > 
> 
> Maybe you should just try it?  I've used reiserfs on an NFS/samba server,
> and it didn't give me trouble.

I did once.  Seemed fine for a while then it hit problems
(don't recall specifics) with some files.  Very painful
transitioning active filesystems.  Since then practically
every new version has claimed to have fixed NFS.  I'll wait
until the fix doesn't need to be fixed again for a few revs.

> 
> > 	jfs -- most nfs exported filesystems, decent
> > 	performance and solid but i don't use if for home
> > 	because in SuSE's 2.4.18 (i know it is ancient but
> > 	solid for me) jfs doesn't update mtime of
> > 	directories unless the block allocation changes
> > 	breaking maildir update detection.
> 
> This has been fixed in newer versions of JFS though, right?

Dunno,  I assume so.  It is a pretty obvious bug by the time
i had a server running JFS the kernel i was running was
already old.

If you are running JFS it is easy to test.  Just create a
directory with some files in it and rename or delete one so
the block count of the directory is unchanged and look at
the mtime.

> > 	xfs -- home (because of the jfs bug) Earlier tests
> > 	of xfs gave me horrible performance and i haven't
> > 	gotten around to testing since then.  If this is
> > 	fixed without tuning i might drop jfs.  Then again i
> > 	may drop xfs in the next upgrade if i change distros
> > 	and xfs isn't in-kernel.
> 
> What about ext3?  I tend to prefer ext3 since I know how it works more than
> the others, and it puts data integrity ahead of performance, which is the
> way things should be (TM).

I see too many reports of lost files and ext3 running in a
degraded state unnoticed to trust it.  The features list is
great but there are just too many bugfixes between kernel
versions in production and HEAD.  When i've XFS, reiserfs
and JFS to choose from the need for ext3 just isn't there at
this time.  The added confidence of data journalling on
systems that don't crash just doesn't outweigh doubts caused
by reports of silently lost files. (look further down the
other branch from the message to which this is a reply)

I appreciate the work that has gone into ext3 and have some
hopes that in time it may get past any real or imagined
deficiencies.  I suspect that the biggest value of ext3 at
this time is as a labratory for testing filesystem theory
and new features.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
