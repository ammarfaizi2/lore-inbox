Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272192AbRH3Mgm>; Thu, 30 Aug 2001 08:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272194AbRH3Mgc>; Thu, 30 Aug 2001 08:36:32 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:1796 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S272192AbRH3MgV>; Thu, 30 Aug 2001 08:36:21 -0400
Date: Thu, 30 Aug 2001 18:28:21 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Reg-mounting of minix file system
Message-ID: <Pine.LNX.4.10.10108301828090.17070-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I did an "rmmod minix" to remove the minix module from the kernel
and then tried to mount the partition on a mount point using minix
filesystem. I gave the command 

mount -t minix /dev/sdb1 /dummy....

.but found that it got mounted without
error, though I have already removed the minix module from the kernel. So
again I unmounted the fs and took an strace of the same command and a part
of the output was the following:


-----------------------
lstat("/etc/mtab", {st_mode=S_IFREG|0644, st_size=118, ...}) = 0
rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
 mount("/dev/sdb1","/dummy", "minix", 0xc0ed0000, 0) = -1 ENOSYS (Function not i mplemented)

mount("/dev/sdb1", "/dummy", "minix", 0xc0ed0000, 0) = -1 ENOSYS (Function
not i mplemented)

 mount("/dev/sdb1", "/dummy", "minix", 0xc0ed0000, 0) = 0
---------------------------
In the above it succeds only the third time. 

My doubts are:
1. How did the kernel get the minix filesystem when I have already removed
the module from the kernel?

2. Where does the modules get loaded from when we use an insmod? Is it
from "/lib/modules/<kernel version>/fs/" for the filesystem?

Please help me with the answer.

Thanks in advance,
A
Warm regards,
sathish.j




