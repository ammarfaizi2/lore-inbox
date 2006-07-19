Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWGSPZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWGSPZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWGSPZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:25:30 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:38625 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S964870AbWGSPZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:25:29 -0400
Subject: Re: XFS breakage in 2.6.18-rc1
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Nathan Scott <nathans@sgi.com>, Torsten Landschoff <torsten@debian.org>,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <200607191343.33502.s0348365@sms.ed.ac.uk>
References: <20060718222941.GA3801@stargate.galaxy>
	 <20060719085731.C1935136@wobbly.melbourne.sgi.com>
	 <1153304468.3706.4.camel@localhost>
	 <200607191343.33502.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 17:25:26 +0200
Message-Id: <1153322726.25089.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-19 at 13:43 +0100, Alistair John Strachan wrote:
> On Wednesday 19 July 2006 11:21, Kasper Sandberg wrote:
> > On Wed, 2006-07-19 at 08:57 +1000, Nathan Scott wrote:
> > > On Wed, Jul 19, 2006 at 12:29:41AM +0200, Torsten Landschoff wrote:
> > > > Hi friends,
> > >
> > > Hi Torsten,
> > >
> > > > I upgraded to 2.6.18-rc1 on sunday, with the following results (taken
> > > > from my /var/log/kern.log), which ultimately led me to reinstall my
> > > > system:
> > > >
> > > > Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
> > > > Jul 17 07:33:53 pulsar kernel: dir: inode 54526538
> > >
> > > I suspect you had some residual directory corruption from using the
> > > 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> > > fixed in the latest -stable point release).
> >
> > This has me very worried.
> >
> > i just upgraded to .18-rc1-git5 when it came out, i used .17-rc3 before.
> > does this mean my .17-rc3 may have corrupted my filesystem?
> >
> > what action do you suggest i do now?
> >
> > > > of programs fail in mysterious ways. I tried to recover using
> > > > xfs_repair but I feel that my partition is thorougly borked. Of course
> > > > no data was lost due to backups but still I'd like this bug to be fixed
> > > > ;-)
> > >
> > > 2.6.18-rc1 should be fine (contains the corruption fix).  Did you
> > > mkfs and restore?  Or at least get a full repair run?  If you did,
> > > and you still see issues in .18-rc1, please let me know asap.
> > >
> > > thanks.
> 
> According to another thread Nathan just responded to, it sounds like we need 
> to wait for a new version of the xfsprogs package, and then run xfs_repair on 
> the affected filesystems. I wouldn't worry about it too much if you've not 
> had any crashes. The damage can be repaired, just not right now.
without ANY loss? because even though it would be abit painful for me to
do, i do have the option of smashing in a new drive, copy everything,
and reinitialize my filesystem.
> 
> I'm still waiting for a crash on a machine that has been under heavy load for 
> 28 days, so it's obviously not _that_ easy to trigger.
so basically if i upgrade to a safe kernel before i do get these errors,
im good?


> 

