Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbRCNTSR>; Wed, 14 Mar 2001 14:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRCNTSH>; Wed, 14 Mar 2001 14:18:07 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:8189 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131495AbRCNTR4>; Wed, 14 Mar 2001 14:17:56 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103141916.f2EJGhH10169@webber.adilger.int>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <200103141823.TAA11310@ns.caldera.de> from Christoph Hellwig at
 "Mar 14, 2001 07:23:18 pm"
To: Christoph Hellwig <hch@caldera.de>
Date: Wed, 14 Mar 2001 12:16:43 -0700 (MST)
CC: John Jasen <jjasen1@umbc.edu>, linux-kernel@vger.kernel.org,
        AmNet Computers <amnet@amnet-comp.com>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph writes:
> In article <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu> you wrote:
> > drivers change their detection schemes; and changes in the kernel can
> > change the order in which devices are assigned names.
> >
> > For example, the DAC960(?) drivers changed their order of
> > detecting controllers, and I did _not_ have fun, given that the machine in
> > question had about 40 disks to deal with, spread across two controllers.
> 
> Put LABEL=<label set with e2label> in you fstab in place of the device name.
> P.S. UUID= work, too - but I prefer a human-readable label...

Works OK for ext2 only.  I'm still waiting on the reiserfs folks to add a
UUID and LABEL to their superblock.

However, for raw partitions, you will need to use LVM to get rename-safe
device labels.  You probably want LVM anyways, if you have 40 disks...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
