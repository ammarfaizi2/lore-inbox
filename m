Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbTCIEaQ>; Sat, 8 Mar 2003 23:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbTCIE3e>; Sat, 8 Mar 2003 23:29:34 -0500
Received: from starcraft.mweb.co.za ([196.2.45.78]:15311 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S262441AbTCIE20>; Sat, 8 Mar 2003 23:28:26 -0500
Date: Sun, 9 Mar 2003 06:33:45 +0200
From: Martin Schlemmer <azarah@gentoo.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Corruption problem with ext3 and htree
Message-Id: <20030309063345.47046254.azarah@gentoo.org>
In-Reply-To: <20030306234819.Q1373@schatzie.adilger.int>
References: <20030307063940.6d81780e.azarah@gentoo.org>
	<20030306234819.Q1373@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003 23:48:19 -0700
Andreas Dilger <adilger@clusterfs.com> wrote:

> There have been a number of ext3+htree fixes in the last week or so.
> I'm not sure if all of them are in the kernel yet, but I think the -mm
> tree will have the majority of them.  Please also see the ext2-devel
> and ext3-users mailing list archives for the last week for the
> patches.
> 

Nope, did not fix it.  I tried to grab all patches from mm2, as well as
any others that was lying around.

------------------------------
man3 # ls Hash\:\:Util.*
ls: Hash::Util.tmp: No such file or directory
Hash::Util.3pm.gz
nosferatu man3 # 
------------------------------

And for some reason its only with the Hash::Util* files that it have
this problem.  Am assuming it might not be related to the filename
itself ?

This is what I get when I fsck it:

--------------------------------------------------------------------
nosferatu root # e2fsck -f /dev/hdg1 
e2fsck 1.32 (09-Nov-2002)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Entry 'Hash::Util.tmp' in
/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3 (1619713) has
deleted/unused inode 1619855.  Clear<y>? yes

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/hdg1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hdg1: 318434/4889248 files (3.0% non-contiguous), 5785602/9771528
blocks
nosferatu root # 
--------------------------------------------------------------------

Like I said, just say how I can try to debug this.

PS: Please CC me, as only subscribed at work.


Regards,

-- 

Martin Schlemmer

