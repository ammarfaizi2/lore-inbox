Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281034AbRKOUUF>; Thu, 15 Nov 2001 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKOUT4>; Thu, 15 Nov 2001 15:19:56 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:28656 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281034AbRKOUTp>;
	Thu, 15 Nov 2001 15:19:45 -0500
Date: Thu, 15 Nov 2001 13:19:38 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux kernel <linux-kernel@vger.kernel.org>,
        "Peter T. Breuer" <ptb@it.uc3m.es>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011115131938.M5739@lynx.no>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>,
	"Peter T. Breuer" <ptb@it.uc3m.es>
In-Reply-To: <20011115003434.A25883@node0.opengeometry.ca> <200111151235.fAFCZQY31248@oboe.it.uc3m.es> <20011115133133.A732@node0.opengeometry.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115133133.A732@node0.opengeometry.ca>; from opengeometry@yahoo.ca on Thu, Nov 15, 2001 at 01:31:33PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  13:31 -0500, William Park wrote:
> I looked around, and 1KB block size is hard-coded in too many places.
> For example, function 'generic_make_request()' in
> 'drivers/block/ll_rw_blk.c' assumes 512 sector and 1024 block size:

Yes, it _would_ be nice to clean this up, but it is a lot of work.  You
could check out Anton's patch (posted today) for this as a starting point.

> Is changing 'int' to 'u64' (and all the dependent code) enough to get
> 64-bit block devices?  I'm willing to do the work.

It is already done, please don't duplicate.  Search for 64 bit block
devices around June of this year for a URL to Jens'/Ben's patch.  Please
repost the URL, as several people have asked.

> I don't care about filesystem; that's the job for maintainer of particular
> filesystem.  I understand XFS is 64-bit, so I can use that.

FYI, ext2/ext3 _should_ be OK up to 8TB (possibly 16TB depending on sign
issues) filesystem, with individual files at 2TB, when using a 4kB block
size.  However, there appear to be other issues like VFS and page cache
which may have problems at this point as well.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

