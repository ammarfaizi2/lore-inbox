Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUAGSf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUAGSf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:35:29 -0500
Received: from twin.jikos.cz ([213.151.79.26]:37273 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S264934AbUAGSfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:35:23 -0500
Date: Wed, 7 Jan 2004 19:35:16 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS over 7.7TB LVM partition through NFS
In-Reply-To: <20040107182052.GO1882@matchmail.com>
Message-ID: <Pine.LNX.4.58.0401071932180.31032@twin.jikos.cz>
References: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
 <Pine.LNX.4.58.0401071907460.31032@twin.jikos.cz> <20040107182052.GO1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Mike Fedyk wrote:

> > > I am experiencing problems with LVM2 XFS partition in 2.6.0 being accessed 
> > > over NFS. After exporting the filesystem clients start writing files to 
> > > this partition over NFS, and after a short while we get this call trace, 
> > > repeating indefinitely on the screen and the machine stops responding 
> > > (keyboard, network):
> > Jan  8 01:38:35 storage2 kernel: 0x0: 94 38 73 54 cc 8c c9 be 0c 3e 6b 30 
> > 4c 9f 54 c5
> > Jan  8 01:38:35 storage2 kernel: Filesystem "dm-0": XFS internal error 
> > xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01fab06
> Try a fsck on your xfs partitions.

storage2:~# fsck -V /dev/mapper/lvol1-lv1
fsck 1.35-WIP (07-Dec-2003)
[/sbin/fsck.xfs (1) -- /dev/mapper/lvol1-lv1] fsck.xfs 
/dev/mapper/lvol1-lv1

Seems perfectly clean. This is brand new filesystem, bug occurs shortly 
after mkfs when clients start writing files a little bit intensively.

-- 
JiKos.
