Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWHPJF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWHPJF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWHPJF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:05:29 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:16558 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751039AbWHPJF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:05:28 -0400
Message-ID: <44E2DFC7.7060200@uni-hd.de>
Date: Wed, 16 Aug 2006 11:05:11 +0200
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at <bad filename>:50307!
References: <44E1D9CA.30805@uni-hd.de> <20060816101122.E2740551@wobbly.melbourne.sgi.com>
In-Reply-To: <20060816101122.E2740551@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,
> It means XFS detected ondisk corruption in inode# 254474718, and
> paniced your system (stupidly; a fix for this is around, will be
> merged with the next mainline update).  For me, a more interesting
> question is how that inode got into this state... have you had any
> crashes recently (i.e. has the filesystem journal needed to be
> replayed recently?)  Can you send the output of:

We had recently problems with our XFS partition caused by the Kernel-Bug
in 2.6.17. I updated xfsprogs-2.8.10 and repaired the partition with
xfs_repair - it found a corrupted dir-inode (254474253)


> 
> 	# xfs_db -c 'inode 254474718' -c print /dev/sdc1
> You'll need to run xfs_repair on that filesystem to fix this up,
> but please send us that output first.

core.magic = 0x494e
core.mode = 0100774
core.version = 1
core.format = 3 (btree)
core.nlinkv1 = 1
core.uid = 1348
core.gid = 104
core.flushiter = 0
core.atime.sec = Tue Aug 15 15:00:58 2006
core.atime.nsec = 934572500
core.mtime.sec = Tue Aug 15 15:01:02 2006
core.mtime.nsec = 261116500
core.ctime.sec = Tue Aug 15 15:01:02 2006
core.ctime.nsec = 261116500
core.size = 10092544
core.nblocks = 197
core.extsize = 0
core.nextents = 182
core.naextents = 0
core.forkoff = 0
core.aformat = 2 (extents)
core.dmevmask = 0
core.dmstate = 0
core.newrtbm = 0
core.prealloc = 0
core.realtime = 0
core.immutable = 0
core.append = 0
core.sync = 0
core.noatime = 0
core.nodump = 0
core.rtinherit = 0
core.projinherit = 0
core.nosymlinks = 0
core.extsz = 0
core.extszinherit = 0
core.nodefrag = 0
core.gen = 9
next_unlinked = null
u.bmbt.level = 1
u.bmbt.numrecs = 1
u.bmbt.keys[1] = [startoff] 1:[1]
u.bmbt.ptrs[1] = 1:112941297



 thanks.
martin

