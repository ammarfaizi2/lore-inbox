Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279958AbRKIQMr>; Fri, 9 Nov 2001 11:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279959AbRKIQMh>; Fri, 9 Nov 2001 11:12:37 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:8175 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S279958AbRKIQMY>;
	Fri, 9 Nov 2001 11:12:24 -0500
Date: Fri, 9 Nov 2001 09:11:40 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011109091140.A1778@lynx.no>
Mail-Followup-To: Ryan Cumming <bodnar42@phalynx.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <20011107132552.J5922@lynx.no> <E161cCh-0003de-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E161cCh-0003de-00@localhost>; from bodnar42@phalynx.dhs.org on Wed, Nov 07, 2001 at 03:33:54PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  15:33 -0800, Ryan Cumming wrote:
> On November 7, 2001 12:25, Andreas Dilger wrote:
> > If both ext2 and ext3 are compiled into the kernel, then ext3 will try
> > first to mount the root fs.  If there is no journal on this fs (check this
> > with tune2fs -l <dev>, and look for "has_journal" feature), then it will be
> > mounted as ext2.  If you are doing strange things with initrd and modules,
> 
> Is there any particular reason why the ext3 driver can't handle mounting both 
> ext2 and ext3 filesystems? 

Not really - just an implementation issue.  At one point (long ago) I had
started putting in support for this.  However, the consensus is that some
people will still want to use the less complex ext2 code instead of ext3
that pretends to be ext2.  I imagine that eventually support for mounting
unjournaled ext2 filesystems with the ext3 driver will be added, but there
is no pressing need - you can always use the ext2 driver.  Yes, it takes
a bit more memory to have both loaded, but most people who switch to ext3
don't use ext2 filesystems anymore anyways.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

