Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281896AbRKZQPQ>; Mon, 26 Nov 2001 11:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281899AbRKZQPG>; Mon, 26 Nov 2001 11:15:06 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:60683 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S281896AbRKZQO6>; Mon, 26 Nov 2001 11:14:58 -0500
Date: Mon, 26 Nov 2001 11:14:54 -0500
Message-Id: <200111261614.fAQGEsP01603@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15aa1
X-Newsgroups: linux.kernel
In-Reply-To: <1006629351.1470.8.camel@praetorian>
In-Reply-To: <20011124085028.C1419@athlon.random>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1006629351.1470.8.camel@praetorian> aafes@psu.edu asked:
| -=-=-=-=-=-
| 
| On Sat, 2001-11-24 at 02:50, Andrea Arcangeli wrote:
| > Only in 2.4.15aa1: 00_iput-unmount-corruption-fix-1
| > 
| > 	Fix iput umount corruption.
| 
| Is this the problem that Al put out a patch for yesterday? And is his
| patch been tested and working?
| 
| > Only in 2.4.15aa1: 00_read_super-stale-inode-1
| > 
| > 	If read_super fails avoid lefting stale inodes queued into
| > 	the superblock.
| 
| What is this? How dangerous is it?

Good question. As I read the patch, the problem occurs during umount,
when dirty inodes are not (properly) written to the disk. Would a sync()
help or eliminate this problem, assuming that all files were closed?
Hopefully someone knows, I don't want to tell you it only happens at
umount, but that's my impression.

In any case, since 2.4.16 is out (so much for "2.4.15 released without
embarrassment") to fix the problem, I would go with that unless you have
a reason to use whichever patch pleases you.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
