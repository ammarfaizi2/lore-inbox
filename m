Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRACRzv>; Wed, 3 Jan 2001 12:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRACRzl>; Wed, 3 Jan 2001 12:55:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:49418 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129436AbRACRz3>;
	Wed, 3 Jan 2001 12:55:29 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101020038.f020cRK00428@webber.adilger.net>
Subject: Re: feature flags set on rev 0 fs
In-Reply-To: <Pine.LNX.4.31.0101010027100.103-100000@clubneon.com>
 "from Chris Meadors at Jan 1, 2001 00:29:55 am"
To: Chris Meadors <clubneon@hereintown.net>
Date: Mon, 1 Jan 2001 17:38:26 -0700 (MST)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris, you write:
> I'm seeing a new warning with the 2.4.0-prerelease (could have been
> introduced in -pre11 or 12):
> 
> EXT2-fs warning: feature flags set on rev 0 fs, running e2fsck is recommended
> 
> Well I've run e2fsck (version 1.18) twice, and looked at the options for
> tune2fs.

The feature flag/revision level fix is only in the current development
version of e2fsck right now (1.20.WIP).  Fortunately, the "error" is no
more of a problem now than before the checking went into the kernel.  All
of the current feature flags are supported by the ext2 filesystem code, so
it will continue to work just like it always did.  The reason the checks
were added is for features that may cause a real problem like ext3
journalling, or Tux2 which totally changes the layout of the filesystem.

> Is there an easy way to change the rev of the fs, without a format and
> restore?

I would just wait until e2fsck 1.20 is released and it will fix this for
you the next time it even looks at the filesystem.  Unfortunately, the
commands to change the revision field in the superblock is only in 1.20
as well, so once you get that far you may as well just let e2fsck fix
it...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
