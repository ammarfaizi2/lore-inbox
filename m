Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282301AbRKXAP2>; Fri, 23 Nov 2001 19:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282305AbRKXAPX>; Fri, 23 Nov 2001 19:15:23 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:20983 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282301AbRKXAPL>;
	Fri, 23 Nov 2001 19:15:11 -0500
Date: Fri, 23 Nov 2001 17:11:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jahn Veach <V64@Galaxy42.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.4.15 + fs corruption.
Message-ID: <20011123171143.M1308@lynx.no>
Mail-Followup-To: Jahn Veach <V64@Galaxy42.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <013601c17479$933f0450$2b910404@Molybdenum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <013601c17479$933f0450$2b910404@Molybdenum>; from V64@Galaxy42.com on Fri, Nov 23, 2001 at 05:50:03PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  17:50 -0600, Jahn Veach wrote:
> > Breakage happens when you umount filesystem (_any_ local filesystem, be
> > it ext2, reiserfs, whatever) that still has dirty inodes.
> 
> What kind of breakage are we looking at here? I had a system that ran 2.4.15
> and got shut down without a sync. What kind of corruption will occur and is
> it something a simple fsck will fix?

Well it appears to leave inodes around which do not point at existing files.
It is easy to fix on ext2/ext3, but may be harder for reiserfs.  Maybe
reiserfs shows the problem differently, though, I don't know.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

