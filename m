Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131355AbQK2NbL>; Wed, 29 Nov 2000 08:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131384AbQK2NbB>; Wed, 29 Nov 2000 08:31:01 -0500
Received: from chia.umiacs.umd.edu ([128.8.120.111]:28843 "EHLO
        chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
        id <S131355AbQK2Nav>; Wed, 29 Nov 2000 08:30:51 -0500
Date: Wed, 29 Nov 2000 08:00:19 -0500 (EST)
From: Adam <adam@cfar.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: 'holey files' not holey enough.
Message-ID: <Pine.GSO.4.21.0011290755570.2862-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this feature or bug?

First a test on 'stable' 2.2.x kernel:

	eax /tmp % uname -a
	Linux eax 2.2.17pre15 #1 Sat Aug 5 14:31:19 EDT 2000 i586 unknown

	eax /tmp % dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
	1000+0 records in
	1000+0 records out

	eax /tmp % ls -l holed.file 
	-rw-rw-r--    1 adam     adam      6000000 Nov 29 08:57 holed.file

	eax /tmp % du -sh holed.file 
	983k	holed.file

Above holey file is as expected aproximately 1mb. 
However, when I try on 'development' 2.4.x kernel

	[adam@pepsi /tmp]$ uname -a
	Linux pepsi 2.4.0-test7-packet #24 SMP Fri Sep 8 20:26:35 EDT 2000 i686

	[adam@pepsi /tmp]$  dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
	1000+0 records in
	1000+0 records out

	[adam@pepsi /tmp]$ ls -l holed.file 
	-rw-rw-r--    1 adam     adam      6000000 Nov 29 08:52 holed.file

	[adam@pepsi /tmp]$ du -sh holed.file 
	1.9M    holed.file

The holey file is twice as big, 

at almost 2mb instead of expected 1mb.

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
