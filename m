Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWGSXKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWGSXKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWGSXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:10:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5062 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932563AbWGSXJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:09:59 -0400
Date: Thu, 20 Jul 2006 09:09:45 +1000
From: Nathan Scott <nathans@sgi.com>
To: Torsten Landschoff <torsten@debian.org>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060720090945.G1947140@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <20060719211402.GA1133@stargate.galaxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060719211402.GA1133@stargate.galaxy>; from torsten@debian.org on Wed, Jul 19, 2006 at 11:14:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 11:14:02PM +0200, Torsten Landschoff wrote:
> On Wed, Jul 19, 2006 at 08:57:31AM +1000, Nathan Scott wrote:
> > I suspect you had some residual directory corruption from using the
> > 2.6.17 XFS (which is known to have a lurking dir2 corruption issue,
> > fixed in the latest -stable point release).
> 
> That probably the cause of my problem. Thanks for the info!
> 
> BTW: I think there was nothing important on the broken filesystems, but
> I'd like to keep what's still there anyway just in case... How would you
> suggest should I copy that data? I fear, just mounting and using cp 
> might break and shutdown the FS again, would xfsdump be more
> appropriate?

Yeah, xfsdumps not a bad idea, the interfaces it uses may well
be able to avoid the cases that trigger shutdown.  Otherwise it
is a case of identifying the problem directory inode (the inum
is reported in the shutdown trace) and avoiding that path when
cp'ing - you can match inum to path via xfs_ncheck.

> Thanks for XFS, I am using it for years in production servers!

Thanks for the kind words, they're much appreciated at times
like these. :-]

cheers.

-- 
Nathan
