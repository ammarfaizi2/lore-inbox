Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265441AbSJaW7W>; Thu, 31 Oct 2002 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265416AbSJaW7Q>; Thu, 31 Oct 2002 17:59:16 -0500
Received: from duncodin.demon.co.uk ([158.152.19.86]:18054 "EHLO
	duncodin.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265408AbSJaW7M>; Thu, 31 Oct 2002 17:59:12 -0500
Date: Thu, 31 Oct 2002 23:05:34 GMT
From: Mike Civil <mike@duncodin.org>
Message-Id: <200210312305.g9VN5Yvj021985@duncodin.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Htree ate my hard drive, was: post-halloween 0.2
X-Newsgroups: local.linux-kernel
In-Reply-To: <200210310727.52636.baldrick@wanadoo.fr>
References: <20021030171149.GA15007@suse.de>
Organization: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200210310727.52636.baldrick@wanadoo.fr> you write:
>
>> EXT3 Htree support.
>> ~~~~~~~~~~~~~~~~~~~
>> The ext3 filesystem has gained indexed directory support, which offers
>> considerable performance gains when used on filesystems with large
>> directories. In order to use the htree feature, you need at least version
>> 1.29 of e2fsprogs. Existing filesystems can be converted using the command
>> "tune2fs -O dir_index /dev/hdXXX" The latest e2fsprogs can be found at
>> http://prdownloads.sourceforge.net/e2fsprogs
>
>I ran this (tune2fs -O dir_index /dev/hdXXX).
>
>After a bit of switching back and forth between 2.4.19 and 2.5.44,
>fsck was run while booting 2.4.19 (the usual check because of >30
>mounts).  There was a message about optimizing directories.  Booting
>continued but (big surprise) X refused to run.  It turned out that some
>device files had vanished.  Very strange.  On rebooting, fsck found a
>gazillion bad inodes.  They all turned out to be from the 2.5.44 tree -
>poetic justice I suppose!  But this did not suffice.  Rebooting, I got
>"optimizing directories" again.  Next fsck showed up more dud inodes.

For info, I had this as well. Kernel 2.4.19 only. Using e2fsprogs 1.29.

I've not used tune2fs, just using -D switch to e2fsck. Using ext3 on
all filesystems.

No obvious complaints from e2fsck, although I wasn't really watching
it. No entries in /'s lost+found. No problems with other filesystems.

Only lost device files in /dev (about 120) with no discernible pattern.

Mike

dumpe2fs output:

Filesystem volume name:   root
Last mounted on:          /
Filesystem UUID:          6278d5f9-5583-4651-8d58-f12886a4e3a9
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal dir_index filetype needs_recovery sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              122624
Block count:              244991
Reserved block count:     2449
Free blocks:              79421
Free inodes:              86789
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         15328
Inode blocks per group:   479
Last mount time:          Thu Oct 31 17:08:15 2002
Last write time:          Thu Oct 31 17:08:15 2002
Mount count:              4
Maximum mount count:      31
Last checked:             Wed Oct 30 18:57:46 2002
Check interval:           15552000 (6 months)
Next check after:         Mon Apr 28 19:57:46 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            8
Journal device:           0x0000
First orphan inode:       0
Default directory hash:   tea
Directory Hash Seed:      c9f2f715-bc28-4302-a2e9-e53aa08576f7

