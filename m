Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbTCIGW7>; Sun, 9 Mar 2003 01:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262438AbTCIGW7>; Sun, 9 Mar 2003 01:22:59 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:30446 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S262436AbTCIGW5>; Sun, 9 Mar 2003 01:22:57 -0500
Date: Sat, 8 Mar 2003 23:32:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Corruption problem with ext3 and htree
Message-ID: <20030308233219.G1373@schatzie.adilger.int>
Mail-Followup-To: Martin Schlemmer <azarah@gentoo.org>,
	linux-kernel@vger.kernel.org
References: <20030307063940.6d81780e.azarah@gentoo.org> <20030306234819.Q1373@schatzie.adilger.int> <20030309063345.47046254.azarah@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030309063345.47046254.azarah@gentoo.org>; from azarah@gentoo.org on Sun, Mar 09, 2003 at 06:33:45AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 09, 2003  06:33 +0200, Martin Schlemmer wrote:
> Nope, did not fix it.  I tried to grab all patches from mm2, as well as
> any others that was lying around.
> 
> ------------------------------
> man3 # ls Hash\:\:Util.*
> ls: Hash::Util.tmp: No such file or directory
> Hash::Util.3pm.gz
> nosferatu man3 # 
> ------------------------------
> 
> And for some reason its only with the Hash::Util* files that it have
> this problem.  Am assuming it might not be related to the filename
> itself ?
> 
> This is what I get when I fsck it:
> 
> --------------------------------------------------------------------
> nosferatu root # e2fsck -f /dev/hdg1 
> e2fsck 1.32 (09-Nov-2002)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Entry 'Hash::Util.tmp' in
> /var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3 (1619713) has
> deleted/unused inode 1619855.  Clear<y>? yes

Out of curiosity, when was the last time before this that the filesystem
was fsck'd?  This sounds a lot like a problem that was (I think) fixed
a couple of months ago relating to renaming files (search for "htree"
in ext2-devel and/or linux-kernel archives around Nov 07, 2002).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

