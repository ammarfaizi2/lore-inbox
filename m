Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTBGRPY>; Fri, 7 Feb 2003 12:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTBGRPY>; Fri, 7 Feb 2003 12:15:24 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:8190 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S266285AbTBGRPW>; Fri, 7 Feb 2003 12:15:22 -0500
Date: Fri, 7 Feb 2003 10:24:42 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: kernel@ddx.a2000.nu
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: fsck out of memory
Message-ID: <20030207102442.O18636@schatzie.adilger.int>
Mail-Followup-To: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>; from kernel@ddx.a2000.nu on Fri, Feb 07, 2003 at 04:17:35PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07, 2003  16:17 +0100, kernel@ddx.a2000.nu wrote:
> i'm trying to run e2fsk after a system hang
> after 1 hour running (70%) which had a memory usage for about 128M
> i get these errors in the dmesg :
> 
> Out of Memory: Killed process 732 (fsck.ext2).
> Out of Memory: Killed process 732 (fsck.ext2).
> Out of Memory: Killed process 732 (fsck.ext2).
> Out of Memory: Killed process 732 (fsck.ext2).
> 
> I really wonder if there is something wrong with e2fsk ?
> does it really need that much memory ?
> (fsck on 2.2TB /dev/md0)

I don't think many people have run e2fsck on such a large filesystem
before when there are lots of problems.  It is entirely possible that
you need so much memory for such a large filesystem.  I would suggest
creating a larger swap file temporarily (on some other partition) so
that e2fsck can complete.

It _may_ be that e2fsck could reduce memory consumption somewhere (or
enable a "use less memory but run slowly" heuristic, but that isn't
very likely, or if it was it would be very slow.

Regarding the "use fsck.ext3" response - ignore it, it is incorrect.
There is no difference at all between fsck.ext2, fsck.ext3, e2fsck.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

