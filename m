Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbSLNKEI>; Sat, 14 Dec 2002 05:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLNKEI>; Sat, 14 Dec 2002 05:04:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:34998 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267573AbSLNKEH>;
	Sat, 14 Dec 2002 05:04:07 -0500
Message-ID: <3DFB03E8.C7AB1271@digeo.com>
Date: Sat, 14 Dec 2002 02:11:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mohamed El Ayouty <melayout@umich.edu>
CC: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
References: <1039790158.25215.48.camel@syKr0n.mine.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 10:11:52.0772 (UTC) FILETIME=[39403040:01C2A359]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohamed El Ayouty wrote:
> 
> Hi,
> 
> This sounds more like the bug I have opened:
> 
> http://bugme.osdl.org/show_bug.cgi?id=110
> 
> where if CONFIG_DEVFS_FS = Y and CONFIG_DEVFS_MOUNT = Y, you will get:
> 
> VFS: Cannot open root device "hda2" or 03:02
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 03:02
> 
> I worked around it by enabling CONFIG_UNIX98_PTYS = Y under the
> character devices.
> 
> But, a recent update to the bug shows that a patch was posted but nobody
> cared.
> 
> Personally, I think the patch should be merged.

You mean this one?

	http://www.lkml.org/archive/2002/12/13/50/index.html

It appears to simply disable internal mounting of devfs.

In which kernel did this problem first appear?   There were
devfs changes in 2.5.51.
