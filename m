Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFPSm>; Wed, 6 Dec 2000 10:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLFPSc>; Wed, 6 Dec 2000 10:18:32 -0500
Received: from collibf1.jhuapl.edu ([128.244.27.248]:50870 "EHLO
	collibf1.jhuapl.edu") by vger.kernel.org with ESMTP
	id <S129183AbQLFPSX>; Wed, 6 Dec 2000 10:18:23 -0500
Message-ID: <3A2E51B0.76C65771@jhuapl.edu>
Date: Wed, 06 Dec 2000 09:48:16 -0500
From: Skip Collins <bernard.collins@jhuapl.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: system hang and corrupt ext2 filesystem with test12-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After running 2.4.0-test11 for a while, my system would occasionally
hang during heavy disk activity resulting in a corrupt ext2 filesystem.
Fortunately, none of the damage has been irrecoverable. I checked
linux-kernel to see if anyone else was seeing the same thing. The recent
threads on corruption seemed to be consistent with the behavior I saw:
ide disk access light remains lit, system hangs, fsck finds bad inodes.
I think test12-pre5 was supposed to fix the problem. But after upgrading
my kernel, I can still get the errors. 

I have a 900MHz Athlon/Asus A7V mobo system with an onboard ata100
promise controller. I have only had problems when my ata100/udma5
harddrive is connected to the promise controller. Using the ATA66 ide
bus eliminates the problem. I typically see the corruption when copying
large (~1GB) files such as vmware virtual disks. It also happens
frequently inside vmware when doing heavy disk access things like
installing software or defragging a win2000 virtual disk.

For now I am going to fall back to the slower ide bus. But I wanted to
let people know that there still may be problems with ext2 corruption in
the latest test kernel.

sc
please cc any replies to me
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
