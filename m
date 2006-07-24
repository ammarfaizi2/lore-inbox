Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWGXIzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWGXIzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWGXIzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:55:06 -0400
Received: from mail.gmx.de ([213.165.64.21]:11949 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750993AbWGXIzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:55:04 -0400
X-Authenticated: #428038
Date: Mon, 24 Jul 2006 10:54:55 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Hans Reiser <reiser@namesys.com>
Cc: lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724085455.GD24299@merlin.emma.line.org>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
	Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C44622.9050504@namesys.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006, Hans Reiser wrote:

> I want reiserfs to be the filesystem that professional system
> administrators view as the one with both the fastest technological pace,
> and the most conservative release management.

Well, I, with the administrator hat on, phased out all reiserfs file
systems and replaced them by ext3. This got me rid of silent
corruptions, immature reiserfsprogs and hash collision chain limits.

> I apologize to users  that the technology required a 5 year gap between
> releases.   It just did, an outsider may not realize how deep the
> changes we made were.  Things like per node locking based on a whole new
> approach to tree locking that goes bottom up instead of the usual top
> down are big tasks.    Dancing trees are a big change, getting rid of
> blobs is a big change, wandering logs.....  We did a lot of things like
> that, and got very fortunate with them.  If we had tried to add such
> changes to V3, the code would have been unstable the whole 5 years, and
> would not have come out right.

And that is something that an administrator does not care the least
about. It must simply work, and the tools must simply work. Once I hit
issues like "xfs_check believes / were mounted R/W (not ignoring rootfs)
and refuses the R/O check", "reiserfsck can't fix a R/O file system"
(I believed this one got fixed before 3.6.19) or particularly silent
corruptions that show up later in a routine fsck --check after a kernel
update, the filesystem and its tools appear in a bad light. I've never
had such troubles with ext2fs or ext3fs or FreeBSD's or Solaris's ufs.

I'm not sure what patches Chris added to SUSE's reiserfs, nor do I care
any more. The father declared his child unsupported, and that's the end
of the story for me. There's nothing wrong about focusing on newer code,
but the old code needs to be cared for, too, to fix remaining issues
such as the "can only have N files with the same hash value". (I am well
aware this is exploiting worst-case behavior in a malicious sense but I
simply cannot risk such nonsense on a 270 GB RAID5 if users have shared
work directories.)

-- 
Matthias Andree
