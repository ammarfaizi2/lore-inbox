Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268983AbRHGQRV>; Tue, 7 Aug 2001 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268907AbRHGQRL>; Tue, 7 Aug 2001 12:17:11 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:37885 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S268110AbRHGQRE>;
	Tue, 7 Aug 2001 12:17:04 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108042332.f74NW1N01658@lynx.adilger.int>
Subject: Re: Any known ext2 FS problems in 2.4.7?
To: david@blue-labs.org (David Ford)
Date: Sat, 4 Aug 2001 17:32:01 -0600 (MDT)
Cc: adilger@turbolinux.com (Andreas Dilger),
        linux-kernel@vger.kernel.org (linux-kernel),
        unlisted-recipients:;;;;@fsa.enel.ucalgary.ca;;; (no To-header on input)
In-Reply-To: <3B6BA0B8.1080704@blue-labs.org> from "David Ford" at Aug 04, 2001 03:14:00 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:
> Ok, the assumed guilty party that just at 4.5gigs flat tonight was the 
> rsync for the kernel mirror.
> 
> Here are the facts.
> a) lsof didn't report any large files opened by rsync
> b) lsof currently reports about 80k in deleted files
> c) the directory where rsync runs from, the destination directory of the 
> mirror, both report expected sizes, the mirror is a little over 9 gigs 
> like it should be, the script directory is tiny.
> e) dmesg shows nothing
> f) du of the partitions shows the expected usage of about 13gigs.
> 
> 4.5gigs just disappeared into nothingness.  I can't find it with any 
> tools.  I have to shut this machine down to single user mode and run 
> e2fsck to recover the space.

Could you try (a) running with quotas disabled to see if it fixes the
problem, or (b) running an -ac kernel which has changes to the quota
code (along with new quota tools, from sourceforge, I believe).

Cheers, Andreas
-- 
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

