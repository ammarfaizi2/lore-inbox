Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSLMO26>; Fri, 13 Dec 2002 09:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSLMO26>; Fri, 13 Dec 2002 09:28:58 -0500
Received: from bgp996345bgs.nanarb01.mi.comcast.net ([68.40.49.89]:63450 "EHLO
	syKr0n.mine.nu") by vger.kernel.org with ESMTP id <S264628AbSLMO26>;
	Fri, 13 Dec 2002 09:28:58 -0500
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
From: Mohamed El Ayouty <melayout@umich.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Dec 2002 09:35:58 -0500
Message-Id: <1039790158.25215.48.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This sounds more like the bug I have opened:

http://bugme.osdl.org/show_bug.cgi?id=110

where if CONFIG_DEVFS_FS = Y and CONFIG_DEVFS_MOUNT = Y, you will get:

VFS: Cannot open root device "hda2" or 03:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:02

I worked around it by enabling CONFIG_UNIX98_PTYS = Y under the
character devices.

But, a recent update to the bug shows that a patch was posted but nobody
cared.

Personally, I think the patch should be merged.

Mohamed

