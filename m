Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317924AbSGKW1p>; Thu, 11 Jul 2002 18:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317925AbSGKW1o>; Thu, 11 Jul 2002 18:27:44 -0400
Received: from t6o913p113.telia.com ([213.64.36.113]:8065 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S317924AbSGKW1m>;
	Thu, 11 Jul 2002 18:27:42 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.25: buffer layer error at buffer.c:406
References: <m2ofderr34.fsf@best.localdomain> <3D2DE5D7.B65C7D08@zip.com.au>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Jul 2002 00:30:13 +0200
In-Reply-To: <3D2DE5D7.B65C7D08@zip.com.au>
Message-ID: <m2n0sxkidm.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Peter Osterlund wrote:
> > 
> > When I booted 2.5.25 I got the error "buffer layer error at
> > buffer.c:406". It happened three times within one second. After that it
> > didn't happen again. The error messages didn't seem to cause any harm.
> > 
> > I rebooted the machine, but the error didn't show up again. The only
> > difference was that on the first boot, the machine decided to run an
> > ext2 file system check.
> > 
> 
> Looks like the fsck left some pagecache behind, perhaps with a
> different blocksize.  I have some adjustments in that ares which
> _may_ make it go away - not sure.
> 
> Is it the root filesystem?  And could you please send me the
> `dumpe2fs -h' output for that filesystem?

Yes, it is the root filesystem, which is the only filesystem on that
machine (An old laptop). I noticed the block size is 1Kb, maybe that
has something to do with the problem.

pengo:/home/petero# /sbin/dumpe2fs -h /dev/hda4
dumpe2fs 1.25 (20-Sep-2001)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          e02ff420-1808-11d2-92dd-b0a589171a72
Filesystem magic number:  0xEF53
Filesystem revision #:    0 (original)
Filesystem features:      (none)
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              759808
Block count:              3032064
Reserved block count:     5000
Free blocks:              202811
Free inodes:              625901
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2048
Inode blocks per group:   256
Last mount time:          Thu Jul 11 21:16:09 2002
Last write time:          Fri Jul 12 00:23:44 2002
Mount count:              2
Maximum mount count:      20
Last checked:             Thu Jul 11 20:36:03 2002
Check interval:           15552000 (6 months)
Next check after:         Tue Jan  7 19:36:03 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
