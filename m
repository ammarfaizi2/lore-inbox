Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267614AbSLNOPd>; Sat, 14 Dec 2002 09:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbSLNOPc>; Sat, 14 Dec 2002 09:15:32 -0500
Received: from bgp996345bgs.nanarb01.mi.comcast.net ([68.40.49.89]:51082 "EHLO
	syKr0n.mine.nu") by vger.kernel.org with ESMTP id <S267614AbSLNOPc>;
	Sat, 14 Dec 2002 09:15:32 -0500
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
From: Mohamed El Ayouty <melayout@umich.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3DFB03E8.C7AB1271@digeo.com>
References: <1039790158.25215.48.camel@syKr0n.mine.nu> 
	<3DFB03E8.C7AB1271@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Dec 2002 09:22:31 -0500
Message-Id: <1039875751.10805.3.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started having that problem since 2.5.48.

I just commented out those 4 lines in init/do_mounts.c:

#ifdef CONFIG_DEVFS_FS
        sys_mount("devfs", "/dev", "devfs", 0, NULL);
        do_devfs = 1;
#endif

and 2.5.51 now works.

Mohamed
