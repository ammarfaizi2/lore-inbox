Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSDCK1b>; Wed, 3 Apr 2002 05:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSDCK1W>; Wed, 3 Apr 2002 05:27:22 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25081 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310241AbSDCK1P>; Wed, 3 Apr 2002 05:27:15 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 3 Apr 2002 03:25:50 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jauder Ho <jauderho@carumba.com>,
        Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 vs. ext3 recovery after crash
Message-ID: <20020403102550.GT4735@turbolinux.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Jauder Ho <jauderho@carumba.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204022144310.21070-100000@twinlark.arctic.org> <Pine.LNX.3.96.1020403045517.11049B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 03, 2002  05:05 -0500, Bill Davidsen wrote:
> C'mon, I've been doing this stuff since the MCC four floppy distribution
> was king, I've seen a max mount counts message before.

OK, well I've seen your name around a lot, but you never know...

> This is purely a case of the *first* mount message being EXT2 instead
> of EXT3, as if the journal wasn't detected in the first place.  However,
> the r/w mount is always ext3 per fstab.

Well, 'mount' output is useless w.r.t. the root filesystem, because it is
simply copied from /etc/fstab.  You need to check /proc/mounts to see if
it is _ever_ being mounted as ext3 (lots of people have this problem,
especially if they use initrds and ext3 as a module).

If it _is_ being mounted as ext2 sometimes and ext3 other times, it
would be informative to get the dmesg output, because it will tell
you why it couldn't load the journal.  Note that if there _is_ a
journal in use, it would normally prevent the filesystem from being
mounted as ext2 entirely after a crash.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

