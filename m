Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRHRWE5>; Sat, 18 Aug 2001 18:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268809AbRHRWEs>; Sat, 18 Aug 2001 18:04:48 -0400
Received: from imladris.infradead.org ([194.205.184.45]:53005 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S268792AbRHRWEf>;
	Sat, 18 Aug 2001 18:04:35 -0400
Date: Sat, 18 Aug 2001 23:04:41 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Dewet Diener <dewet@dewet.org>
cc: Stephen C Tweedie <sct@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 partition unmountable
In-Reply-To: <20010818235211.A24646@darkwing.flatlit.net>
Message-ID: <Pine.LNX.4.33.0108182257490.9206-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dewet.

 >> If I'm reading the files right it looks like:
 >> #define EXT3_FEATURE_INCOMPAT_COMPRESSION 0x0001

 >> Did you compress the file system?

 > Not knowingly, no. Is that a mount option?

The relevant mount option is to specify the ext3 rather than the ext2
file system, and the flag you refer to gets set if ANYBODY sets the
"COMPRESS THIS FILE" flag on ANY file on that file system. As far as I
can tell, nothing ever resets that flag, even if the last file that
was compressed gets uncompressed.

I suggested a while back that fsck should check whether there are any
compressed files on the filesystem, and reset that flag if not, but as
far as I can tell, nothing was ever done to implement that suggestion.

 > I'm mounting them the same on both sides, so its rather
 > strange...

 >> Do a "tune2fs -l /dev/hdc" and see what features are set.

 > Heh, not much more useful:

 > # tune2fs -l /dev/hdd1
 > tune2fs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
 > tune2fs: Filesystem has unsupported feature(s) while trying to open /dev/hdd1
 > Couldn't find valid filesystem superblock.

You have an old version of tune2fs, and need to get the one that knows
about ext3 or alternatively apply the patch that was distributed some
time ago and recompile - I'm not sure which.

Stephen: What's the current status regarding tune2fs and ext3, I'm a
tad out of date in this respect?

 > I'll probably have to take the drive back, and see if it now mounts
 > in the original system :-/

That might help...

Best wishes from Riley.

