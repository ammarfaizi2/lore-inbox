Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319013AbSHFHvy>; Tue, 6 Aug 2002 03:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319014AbSHFHvy>; Tue, 6 Aug 2002 03:51:54 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:45038 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319013AbSHFHvx>; Tue, 6 Aug 2002 03:51:53 -0400
Date: Tue, 6 Aug 2002 01:52:36 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020806075236.GA23923@clusterfs.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20020806051950.GD22933@clusterfs.com> <200208060724.g767Om3178569@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208060724.g767Om3178569@saturn.cs.uml.edu>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 06, 2002  03:24 -0400, Albert D. Cahalan wrote:
> Andreas Dilger writes:
> > Having 16kB block size would allow a maximum of 64TB for a single
> > filesystem.  The per-file limit would be over 256TB.
> 
> Um, yeah, 64 TB of data with 192 TB of holes!
> I really don't think you should count a file
> that won't fit on your filesystem.

Well, no worse than the original posting which had reiserfs supporting
something-EB files and 16TB filesystems.  Don't think I didn't consider
this at the time of posting.

> > In reality, we will probably implement extent-based allocation for
> > ext3 when we start getting into filesystems that large, which has been
> > discussed among the ext2/ext3 developers already.
> 
> It's nice to have a simple filesystem. If you turn ext2/ext3
> into an XFS/JFS competitor, then what is left? Just minix fs?

Note that I said ext3 in the above sentence, and not ext2.  I'm not in
favour of adding all of the high-end features (htree, extents, etc) into
ext2 at all.  It makes absolutely no sense to have a multi-TB filesystem
running ext2, and then the fsck time takes a day.  It is desirable to
put some minimum support into ext2 for newer features when it makes
sense and does not complicate the code, but not for everything.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

