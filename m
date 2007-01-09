Return-Path: <linux-kernel-owner+w=401wt.eu-S932305AbXAIRkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbXAIRkB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbXAIRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:40:00 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54832 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbXAIRj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:39:59 -0500
Date: Tue, 9 Jan 2007 12:28:59 -0500
Message-Id: <200701091728.l09HSxQI009160@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Tue, 09 Jan 2007 09:53:45 GMT."
             <20070109095345.GB12406@infradead.org> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20070109095345.GB12406@infradead.org>, Christoph Hellwig writes:
> On Mon, Jan 08, 2007 at 07:03:35PM -0500, Erez Zadok wrote:
> > However, I must caution that a file system like ecryptfs is very different
> > from Unionfs, the latter being a fan-out file system---and both have very
> > different goals.  The common code between the two file systems, at this
> > stage, is not much (and we've already extracted some of it into the "stackfs
> > layer").
> 
> I think that's an very important point.  We have a chance to get that
> non-fanout filesystems right quite easily - something I wished that would
> have been done before the ecryptfs merge - while getting fan-out stackable
> filesystems is a really hard task.  In addition to that I know exactly
> one fan-out stackable filesystem that is posisbly useful, which is unionfs.

Christoph, on our Unionfs mailing list, we've been asked numerous times for
additional functionality.  People asked for load balancing based on CPU
time, rtt, latency, space available, etc.  People asked for replication
functionality.  People asked for failover.  And more.  Some users have
become so motivated, that they developed and maintain their own Unionfs
patches to support rudimentary load-balancing and replication.

Our answer had always been the same: those features are nice, but have no
place in Unionfs.  That's why we've created RAIF, exactly to give all those
who wanted "just one more thing added to Unionfs" another f/s to play with.
Who knows, maybe one day, some of those features may wind up in a Unionfs-NG
or as composable VFS plugins.  But for now, we've given the community RAIF
so they can play with it, experiment, enhance, whatever.  RAIF is newer
than Unionfs and for now we're just accumulating experience with it.

In other words, I think there are other fan-out file systems of use other
than Unionfs.  If and when Unionfs made it into mainline, I'll guarantee you
that you'll have users asking for other fan-out functionality.  That is why I
think it is prudent to wait and gather more experience with stackable file
systems in Linux, before embarking on a more generic functionality layer,
which would support non-fanout as well as fanout extensions.

> Because of that I'm much more inclined to add VFS asistance for this
> particular problem (unioning) instead of adding complex infrastructure
> to solve a general problem that people don't benefit from.

I'd love to see VFS assistance for Unioning in particular and for stacking
in general.  But again, I prefer to gather some practical experience first,
and then try to generalize any new VFS-level helper functionality.

Sincerely,
Erez.
