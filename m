Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318088AbSGXW76>; Wed, 24 Jul 2002 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318098AbSGXW76>; Wed, 24 Jul 2002 18:59:58 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:48112 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318088AbSGXW74>; Wed, 24 Jul 2002 18:59:56 -0400
Date: Wed, 24 Jul 2002 17:01:27 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-critical ext3-fs errors and IDE issues with 2.4.19-rc3
Message-ID: <20020724230127.GE574@clusterfs.com>
Mail-Followup-To: Ed Sweetman <safemode@speakeasy.net>,
	linux-kernel@vger.kernel.org
References: <1027456090.1982.28.camel@psuedomode> <20020723204833.GR25899@clusterfs.com> <1027469995.496.6.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027469995.496.6.camel@psuedomode>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 23, 2002  20:19 -0400, Ed Sweetman wrote:
> On Tue, 2002-07-23 at 16:48, Andreas Dilger wrote:
> > Well, this is an error, and the next time the computer is restarted it
> > should force a full fsck on the partition.  The other "panic" (oops)
> > situations are when things are totally shot and it is better to stop
> > doing anything than try and continue.  In this case, it is possible to
> > continue, but that doesn't mean things are OK.
> 
> I rebooted after setting max mount count to 1 so it would force an fsck.

That is not the right thing to do, FYI.  That will mean that each time
you boot (even after clean shutdown) you will get an fsck.  Instead,
you should change the mount count (-C), or the time it was last checked
(-T on more recent tune2fs) to force it to fsck.  That will make it a
one-time event.

Yes, you could also touch /forcefsck or whatever, but that would force
it for all filesystems, again probably not what you want.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

