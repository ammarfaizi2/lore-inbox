Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131466AbQK2NpZ>; Wed, 29 Nov 2000 08:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131465AbQK2NpP>; Wed, 29 Nov 2000 08:45:15 -0500
Received: from chia.umiacs.umd.edu ([128.8.120.111]:33963 "EHLO
        chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
        id <S131310AbQK2No4>; Wed, 29 Nov 2000 08:44:56 -0500
Date: Wed, 29 Nov 2000 08:14:27 -0500 (EST)
From: Adam <adam@cfar.umd.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <Pine.LNX.4.21.0011291306260.883-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011290812140.2862-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	[adam@pepsi /tmp]$ uname -a
> > 	Linux pepsi 2.4.0-test7-packet #24 SMP Fri Sep 8 20:26:35 EDT 2000 i686
> > 
> > 	[adam@pepsi /tmp]$  dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> > 	[adam@pepsi /tmp]$ ls -l holed.file 
> > 	-rw-rw-r--    1 adam     adam      6000000 Nov 29 08:52 holed.file
> > 	[adam@pepsi /tmp]$ du -sh holed.file 
> > 	1.9M    holed.file

> what filesystem type? on ext2 filesystem on 2.4.0-test12-pre3 I get
> expected result:
> 
> # dd if=/dev/zero of=hole bs=1000 seek=5000 count=1000
> 1000+0 records in
> 1000+0 records out
> # l hole
> -rw-r--r--    1 root     root      6000000 Nov 29 13:06 hole
> # du -sh hole
> 988k    hole
> # u
> Linux penguin 2.4.0-test12 #1 Wed Nov 29 09:08:13 GMT 2000 i686 unknown

It is ext2fs with 4kb blocks.

[root@pepsi /tmp]# rpm -q -f /usr/bin/du
fileutils-4.0-21

[root@pepsi /tmp]# ldd /usr/bin/du
        libc.so.6 => /lib/libc.so.6 (0x4001f000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

[root@pepsi /tmp]# rpm -q -f /lib/libc.so.6 
glibc-2.1.3-21

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
