Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbSLNSlH>; Sat, 14 Dec 2002 13:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbSLNSlH>; Sat, 14 Dec 2002 13:41:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:49338 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265797AbSLNSlG>;
	Sat, 14 Dec 2002 13:41:06 -0500
Message-ID: <3DFB7D14.149B2B80@digeo.com>
Date: Sat, 14 Dec 2002 10:48:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mohamed El Ayouty <melayout@umich.edu>
CC: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
References: <3DFB03E8.C7AB1271@digeo.com> <1039875751.10805.3.camel@syKr0n.mine.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 18:48:52.0877 (UTC) FILETIME=[72AC93D0:01C2A3A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohamed El Ayouty wrote:
> 
> I started having that problem since 2.5.48.
> 
> I just commented out those 4 lines in init/do_mounts.c:
> 
> #ifdef CONFIG_DEVFS_FS
>         sys_mount("devfs", "/dev", "devfs", 0, NULL);
>         do_devfs = 1;
> #endif
> 
> and 2.5.51 now works.
> 

OK, the above code was added in 2.5.48.   Thanks.  I'll bug Mr Viro
about it when the power comes back on over on the East coast...

If you replace CONFIG_DEVFS_FS with CONFIG_DEVFS_MOUNT there, does
that fix it?
