Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSKYR6U>; Mon, 25 Nov 2002 12:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSKYR6U>; Mon, 25 Nov 2002 12:58:20 -0500
Received: from bgp996345bgs.nanarb01.mi.comcast.net ([68.40.49.89]:23174 "EHLO
	syKr0n.mine.nu") by vger.kernel.org with ESMTP id <S261868AbSKYR6T>;
	Mon, 25 Nov 2002 12:58:19 -0500
Subject: Re: [PATCH] make 2.5.49 mount root again for devfs users
From: Mohamed El Ayouty <melayout@umich.edu>
To: helgehaf@aitel.hist.no
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, rgooch@ras.ucalgary.ca
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Nov 2002 13:06:01 -0500
Message-Id: <1038247561.4883.280.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, what I experienced is if I configured the kernel with:

CONFIG_UNIX98_PTYS = Y
CONFIG_DEVFS_FS = Y
CONFIG_DEVFS_MOUNT = Y

everything works correctly, but if I configure with only:

CONFIG_UNIX98_PTYS = N
CONFIG_DEVFS_FS = Y
CONFIG_DEVFS_MOUNT = Y

it gives me a panic:

VFS: Cannot open root device "hda2" or 03:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:02

Hope this helps

Mohamed
