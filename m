Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135673AbREJMJT>; Thu, 10 May 2001 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136137AbREJMJG>; Thu, 10 May 2001 08:09:06 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136135AbREJMDO>;
	Thu, 10 May 2001 08:03:14 -0400
Message-ID: <3AFA548C.FAF60B63@idb.hist.no>
Date: Thu, 10 May 2001 10:42:52 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510004959.B7653@higherplane.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:
> 
> On Wed, May 09, 2001 at 10:38:14AM +0300, Mart?n Marqu?s wrote:
> > We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb scsi disks to
> > come so we can change our proxy server, that will run on Linux with Squid.
> > One disk will go inside (I think?) and the other 4 on a tower conected to the
> > RAID, which will be have the cache of the squid server.
> 
> that's a pretty huge cache, have you considered using 8*9gb disks
> instead of 4*18?  what sort of request throughput/latency are you
> aiming for?  as the number of requests grows, disk seek times are
> a very real problem.
> 
> > One of my partners thinks that we should use reiserfs on all the server (the
> > partitions of the Linux distro, and the cache partitions), and I found out
> > that reiserfs has had lots of bugs, and is marked as experimental in kernel
> 
> well, lots of bugs in reiserfs have been fixed.. obviously there are
> more bugs to come (as always), but on the whole a lot of people are very
> happy with it.  there certainly haven't been many posts of reiserfs
> corruption lately at all on linux-kernel.
> 
> > 2.4.4. Not to mention that the people of RH discourage there users from using
> > it.
> 
> they do?
> 
> > So what I want is to know which is the status of this 3 journaling FS. Which
> > is the one we should look for?
> 
> xfs, while wonderful, probably isn't what you're looking for.  AFAIK it
> is intended more for very very very large files.
> 
> > I think that the data lose is not significant in a proxy cache, if the FS is
> > really fast, as is said reiserfs is.
> 
> data loss is always significant.  consider the case where you are forced
> to rebuild the filesystem squid's cache directories reside on...
> admittedly it is an extreme case, but it is a possibility all the same.
> 
If you worry about that, put the squid cache in a fs
of its own.  If it ever dies - use mkfs and restart with an empty cache.
No need to spend a long time fsck'ing something with a limited lifetime
that can be re-fetched.

Helge Hafting
