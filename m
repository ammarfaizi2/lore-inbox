Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133055AbRDLHC7>; Thu, 12 Apr 2001 03:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133056AbRDLHCp>; Thu, 12 Apr 2001 03:02:45 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:1264 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S133055AbRDLHCX>; Thu, 12 Apr 2001 03:02:23 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104120700.f3C70W3N016374@webber.adilger.int>
Subject: Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu>
 "from Alexander Viro at Apr 12, 2001 01:45:08 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 12 Apr 2001 01:00:32 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, kowalski@datrix.co.za,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> We _have_ VM pressure there. However, such loads had never been used, so
> there's no wonder that system gets unbalanced under them.
> 
> I suspect that simple replacement of goto next; with continue; in the
> fs/dcache.c::prune_dcache() may make situation seriously better.

Yes, it appears that this would be a bug.  We were only _checking_
"count" dentries, rather than pruning "count" dentries.

Testing continues.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
