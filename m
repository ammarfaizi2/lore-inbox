Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWGSW7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWGSW7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 18:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWGSW7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 18:59:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62404 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932561AbWGSW7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 18:59:47 -0400
Date: Thu, 20 Jul 2006 08:59:04 +1000
From: Nathan Scott <nathans@sgi.com>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060720085904.E1947140@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1153304468.3706.4.camel@localhost>; from lkml@metanurb.dk on Wed, Jul 19, 2006 at 12:21:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 12:21:08PM +0200, Kasper Sandberg wrote:
> On Wed, 2006-07-19 at 08:57 +1000, Nathan Scott wrote:
> > On Wed, Jul 19, 2006 at 12:29:41AM +0200, Torsten Landschoff wrote:
> > > Hi friends, 
> > 
> > Hi Torsten,
> > 
> > > I upgraded to 2.6.18-rc1 on sunday, with the following results (taken
> > > from my /var/log/kern.log), which ultimately led me to reinstall my 
> > > system:
> > > 
> > > Jul 17 07:33:53 pulsar kernel: xfs_da_do_buf: bno 16777216
> > > Jul 17 07:33:53 pulsar kernel: dir: inode 54526538
> > 
> > I suspect you had some residual directory corruption from using the
> > 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> > fixed in the latest -stable point release).
> This has me very worried.
> 
> i just upgraded to .18-rc1-git5 when it came out, i used .17-rc3 before.
> does this mean my .17-rc3 may have corrupted my filesystem?
> 
> what action do you suggest i do now?

The odds are decent that you're unaffected.  You can check your filesystem
using xfs_check or xfs_repair -n and these will give you a good indication
as to whether further action is required.

cheers.

-- 
Nathan
