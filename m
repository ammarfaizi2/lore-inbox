Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129333AbRBVSRT>; Thu, 22 Feb 2001 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRBVSRK>; Thu, 22 Feb 2001 13:17:10 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:10232 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129333AbRBVSRA>; Thu, 22 Feb 2001 13:17:00 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102221816.f1MIGWt04170@webber.adilger.net>
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
In-Reply-To: <E14VvfG-00035D-00@beefcake.hdqt.valinux.com> from "Theodore Ts'o"
 at "Feb 22, 2001 05:20:10 am"
To: "Theodore Ts'o" <tytso@valinux.com>
Date: Thu, 22 Feb 2001 11:16:32 -0700 (MST)
CC: phillips@innominate.de, Linux-kernel@vger.kernel.org,
        adilger@turbolinux.com, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net, Al Viro <viro@math.psu.edu>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> All references to "." and ".." are now intercepted and never reach the
> filesystem level.

Ted writes:
>    From: Daniel Phillips <phillips@innominate.de>
> 
>    I'll leave that up to somebody else - we now have two alternatives, the
>    100%, no-compromise INCOMPAT solution, and the slightly-bruised but
>    still largely intact forward compatible solution.  I'll maintain both
>    solutions for now code so it's just as easy to choose either in the end.
> 
> Well, the $64,000 question is exactly how much performance does it cost?
> My guess is that it will be barely measurable, but only benchmarks will
> answer that question.

One important question as to the disk format is whether the "." and ".."
interception by VFS is a new phenomenon in 2.4 or if this also happened
in 2.2?  If so, then having these entries on disk will be important
for 2.2 compatibility, and you don't want to have different on-disk formats
between 2.2 and 2.4.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
