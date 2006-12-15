Return-Path: <linux-kernel-owner+w=401wt.eu-S965055AbWLOVNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWLOVNR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWLOVNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:13:17 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39580 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965055AbWLOVNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:13:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Neil Brown <neilb@suse.de>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Date: Fri, 15 Dec 2006 22:15:23 +0100
User-Agent: KMail/1.9.1
Cc: Jurriaan <thunder7@xs4all.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <20061204203410.6152efec.akpm@osdl.org> <20061215192146.GA3616@amd64.of.nowhere> <17795.2681.523120.656367@cse.unsw.edu.au>
In-Reply-To: <17795.2681.523120.656367@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612152215.23629.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it's in -rc1, please see below.

On Friday, 15 December 2006 21:50, Neil Brown wrote:
> On Friday December 15, thunder7@xs4all.nl wrote:
> > From: Neil Brown <neilb@suse.de>
> > Date: Wed, Dec 06, 2006 at 06:20:57PM +1100
> > > i.e. current -mm is good for 2.6.20 (though I have a few other little
> > > things I'll be sending in soon, they aren't related to the raid6
> > > problem).
> > > 
> > 2.6.20-rc1-mm1 doesn't boot on my box, due to the fact that e2fsck gives
> > 
> > Buffer I/O error on device /dev/md0, logical block 0
> > 
> 
> But before that....
> > raid5: device sdh1 operational as raid disk 1
> > raid5: device sdg1 operational as raid disk 0
> > raid5: device sdf1 operational as raid disk 5
> > raid5: device sde1 operational as raid disk 6
> > raid5: device sdd1 operational as raid disk 7
> > raid5: device sdc1 operational as raid disk 3
> > raid5: device sdb1 operational as raid disk 2
> > raid5: device sda1 operational as raid disk 4
> > raid5: allocated 8462kB for md0
> > raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
> > RAID5 conf printout:
> >  --- rd:8 wd:8
> >  disk 0, o:1, dev:sdg1
> >  disk 1, o:1, dev:sdh1
> >  disk 2, o:1, dev:sdb1
> >  disk 3, o:1, dev:sdc1
> >  disk 4, o:1, dev:sda1
> >  disk 5, o:1, dev:sdf1
> >  disk 6, o:1, dev:sde1
> >  disk 7, o:1, dev:sdd1
> > md0: bitmap initialized from disk: read 15/15 pages, set 1 bits, status: 0
> > created bitmap (233 pages) for device md0
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sde1, disabling device. Operation continuing on 7 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdg1, disabling device. Operation continuing on 6 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdf1, disabling device. Operation continuing on 5 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdc1, disabling device. Operation continuing on 4 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdb1, disabling device. Operation continuing on 3 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdh1, disabling device. Operation continuing on 2 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sdd1, disabling device. Operation continuing on 1 devices
> > md: super_written gets error=-5, uptodate=0
> > raid5: Disk failure on sda1, disabling device. Operation continuing on 0 devices
> 
> Oh dear, that array isn't much good any more.!
> That is the second report I have had of this with sata drives.  This
> was raid456, the other was raid1.  Two different sata drivers are
> involved (sata_nv in this case, sata_uli in the other case).

The other box is mine and it works just fine with 2.6.20-rc1.

> I think something bad happened in sata land just recently.

Yup.  Please see, for example:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116621656432500&w=2

It looks like the breakage is in sata, in the patches that went in after
2.6.19-rc6-mm2 (that one worked for me like charm).

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
