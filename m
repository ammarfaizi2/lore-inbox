Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264887AbSJPFhR>; Wed, 16 Oct 2002 01:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSJPFhR>; Wed, 16 Oct 2002 01:37:17 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:39408 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264887AbSJPFhP>; Wed, 16 Oct 2002 01:37:15 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 15 Oct 2002 23:40:35 -0600
To: Michael Clark <michael@metaparadigm.com>
Cc: J Sloan <joe@tmsusa.com>, GrandMasterLee <masterlee@digitalroadkill.net>,
       Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Message-ID: <20021016054035.GM15552@clusterfs.com>
Mail-Followup-To: Michael Clark <michael@metaparadigm.com>,
	J Sloan <joe@tmsusa.com>,
	GrandMasterLee <masterlee@digitalroadkill.net>,
	Simon Roscic <simon.roscic@chello.at>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <200210152120.13666.simon.roscic@chello.at> <1034710299.1654.4.camel@localhost.localdomain> <200210152153.08603.simon.roscic@chello.at> <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost> <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com> <3DACF908.70207@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DACF908.70207@metaparadigm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2002  13:28 +0800, Michael Clark wrote:
> Every one i was getting oops when used with a combination
> of ext3, LVM1 and qla2x00 driver.
> 
> Since taking LVM1 out of the picture, my oopsing problem has
> gone away. This could of course not be LVM1's fault but the
> fact that qla driver is a stack hog or something - i don't have
> enough information to draw any conclusions all at the moment
> i'm too scared to try LVM again (plus the time it takes to
> migrate a few hundred gigs of storage).

Yes, we have seen that ext3 is a stack hog in some cases, and I
know there were some fixes in later LVM versions to remove some
huge stack allocations.  Arjan also reported stack problems with
qla2x00, so it is not a surprise that the combination causes
problems.

In 2.5 there is the "4k IRQ stack" patch floating around, which
would avoid these problems.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

