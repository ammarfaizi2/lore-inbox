Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTHVCrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 22:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbTHVCrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 22:47:17 -0400
Received: from www.13thfloor.at ([212.16.59.250]:29420 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262993AbTHVCrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 22:47:15 -0400
Date: Fri, 22 Aug 2003 04:47:26 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Bind Mount Extensions (ro for --bind)
Message-ID: <20030822024726.GA10598@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus!
Hi Andrew!
Hi Marcelo!

a few weeks ago, I posted a patch on lkml, which allows 
ro --bind mounts, at least regarding ...

 - open (read/write/trunc), create
 - link, symlink, unlink
 - mknod (reg/block/char/fifo), mkfifo
 - mkdir, rmdir
 - (f)chown, (f)chmod, utimes
 - ioctl (gen/ext2/ext3/reiser)
 - access, truncate

it doesn't handle update_atime() yet, because Al Viro
hasn't had the time to answer my email, and it doesn't
change current intermezzo code (but this would be easy
to add, because it's almost the same as the vfs_*()s at
least regarding ro --bind mounts)

actually patches are available and tested for 2.4.22-rc2 
and 2.6.0-test3 up to 2.6.0-test3-bk9 ...

I would like to see this or similar code in 2.6 and 2.4 ...
please let me know, what would be required to get them
in, or why you dislike those patches, in case you do ...

TIA,
Herbert

-----
http://www.13thfloor.at/Patches/patch-2.4.22-rc2-bme0.03.diff
http://www.13thfloor.at/Patches/patch-2.4.22-rc2-bme0.03.diff.bz2
http://www.13thfloor.at/Patches/patch-2.6.0-test3-bme0.03.diff
http://www.13thfloor.at/Patches/patch-2.6.0-test3-bme0.03.diff.bz2

