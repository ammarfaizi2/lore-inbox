Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262559AbTCZWRq>; Wed, 26 Mar 2003 17:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262577AbTCZWRq>; Wed, 26 Mar 2003 17:17:46 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:65183 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262559AbTCZWRm>; Wed, 26 Mar 2003 17:17:42 -0500
Date: Wed, 26 Mar 2003 23:28:51 +0000
From: norbert_wolff@t-online.de (Norbert Wolff)
To: "jds" <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Linux 2.5.65 can't mount root Partition - PANIC
Message-Id: <20030326232851.4c9d1906.norbert_wolff@t-online.de>
In-Reply-To: <20030326015511.M32266@soltis.cc>
References: <20030325190214.M66226@soltis.cc>
	<20030326014652.5b9f44a3.norbert_wolff@t-online.de>
	<20030326015511.M32266@soltis.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi my name is Jesus Delgado from Mexico City:
>
>  I need help for resolve this problems, compile kernel 2.5.66 in rh 8,
> update
> my lvm to lvm2 utils, devmapper, modutil 2.4.24, when try to boot with new
> kernel recive this messages:
>
>   VFS: Cannot open root device "rootvg/lvol1" or unknown-block(0,0)
>   Please append a coorect "root=" boot option
>   kernel panic
>   VFS= Unable to mount fs on unknown-block(0,0).

Hi Jesus !

I have tried to hunt down our problem a lot of hours, but without Success.

Neither the bk-patches nor the mm-patches cure the panic, i've tried 3
different compilers and two binutils.

The strangest thing about this is that we seem to be the only people triggering
the bug, as there is no echo in the LKML.

I give up and go back to 2.5.65 :-(

Below some debugging statements, if there should be somewhere outside
who likes to spent his time in frustrating debugging Sessions ...

Bye
    Norbert

----
Kernel: Linux 2.5.66  (no Problems with 2.5.65 with same .config ! )
Compiler: gcc 2.95.3 (also tried 3.2.2 and 3.4-CVS)
No Modules, no lvm, no raid, no initrd, tried with and without devfs.

VFS: Cannot open root device "301" or ide(3,1)  <- my /dev/hda1 boot-partition
                                                                     (reiserfs)

sys_mount("sysfs", "/sys", "sysfs", 0, NULL) succeeds
sys_mknod for /dev/root                      succeeds
sys_mount for /dev/root   returns ENOENT     -> Panic
