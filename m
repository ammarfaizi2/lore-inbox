Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbRB1Pew>; Wed, 28 Feb 2001 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRB1Pem>; Wed, 28 Feb 2001 10:34:42 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:61965 "HELO
	zcamail05.zca.compaq.com") by vger.kernel.org with SMTP
	id <S130224AbRB1Pe1>; Wed, 28 Feb 2001 10:34:27 -0500
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD120888D@cceexc19.americas.cpqcorp.net>
From: "Dupuis, Don" <Don.Dupuis@COMPAQ.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Problem with ramdisk driver 2.4.2
Date: Wed, 28 Feb 2001 09:31:35 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem still appears in 2.4.2-ac6.

I have a 64k vfat filesystem image file.  I use the following commands to
reproduce this problem.

dd if=file.bin of=/dev/ram0 bs=1024
mount /dev/ram0 /mnt -t vfat

I can do a ls -l /mnt and the filesystem looks correct.  If I do a file * in
the /mnt directory, I will get a segmentation fault.  This worked just fine
on a 2.2.17 kernel.  Also if I do the following commands

dd if=file.bin of=/dev/ram1 bs=1024
mount -o loop /dev/ram1 /test -t vfat
it works, but the ls -l of /test is gargabe mixed with correct file names.
Accessing a filename will also cause a segmentation fault. This also worked
just fine on a 2.2.17 kernel.  Any idea what is wrong with the ramdisk
driver rd.c?

Thanks



