Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280563AbRKBFFw>; Fri, 2 Nov 2001 00:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280564AbRKBFFn>; Fri, 2 Nov 2001 00:05:43 -0500
Received: from [63.231.122.81] ([63.231.122.81]:12602 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280563AbRKBFFf>;
	Fri, 2 Nov 2001 00:05:35 -0500
Date: Thu, 1 Nov 2001 22:04:45 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
Message-ID: <20011101220445.U16554@lynx.no>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15zV86-0000o4-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E15zV86-0000o4-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Nov 02, 2001 at 04:36:25AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, 2001  04:36 +0100, Daniel Phillips wrote:
> I ran it through some basic tests, up to half a million files/directory, 
> without problems.  There are still a few minor warts to clean up, including 
> still not having settled on a final-final hash function, although it looks 
> likely that it's going to end up being dx_hack_hash, with a more respectable 
> name.

Out of curiosity, does the blkdev-in-pagecache change make the indexed-dir
code simpler?  You should just be able to do bread() for a directory
block and it will work, because the "buffer" is actually backed by the
page cache.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

