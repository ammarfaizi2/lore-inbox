Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSDJDs0>; Tue, 9 Apr 2002 23:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312425AbSDJDsZ>; Tue, 9 Apr 2002 23:48:25 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:17911 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312420AbSDJDsY>; Tue, 9 Apr 2002 23:48:24 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 9 Apr 2002 21:46:56 -0600
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020410034656.GE424@turbolinux.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <200204100041.g3A0fSj00928@saturn.cs.uml.edu> <20020409225854.A15883@cecm.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 09, 2002  22:58 -0300, Alexis S. L. Carvalho wrote:
> OK, but if something scribbles on random unrelated parts of the disk
> there's not much you can do besides praying that fsck will fix it.

Well, the fact that ext2 uses fixed areas of the disk for specific
purposes (e.g. inode table) and it has backups of a lot of metadata
makes it very possible to recover from random data corruption.

> Note that if you were running a journalling fs, fsck wouldn't be run at
> all.

Note that this is incorrect.  Even with ext3, e2fsck is run on each
boot.  While in the normal case all it does is journal recovery (takes
a few seconds at most) and do a superficial check of the superblock.
This is incredibly useful, however, if there was a filesystem error,
since e2fsck has a chance to check and cleanup the filesystem before
it is put into use.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

