Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281930AbRKZRDK>; Mon, 26 Nov 2001 12:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281928AbRKZRDB>; Mon, 26 Nov 2001 12:03:01 -0500
Received: from server1.symplicity.com ([209.61.154.230]:55560 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S281927AbRKZRCo>; Mon, 26 Nov 2001 12:02:44 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: <linux-kernel@vger.kernel.org>
Subject: Possible md bug in 2.4.16-pre1
Date: Mon, 26 Nov 2001 12:02:13 -0500
Message-ID: <000c01c1769c$187cc390$9865fea9@pcsn630778>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On kernel 2.4.16-pre1 software RAID (tested with levels 0 and 1 on the
same two drives), it is not possible to "raidstop /dev/md0" after
mounting and using it, even though the partition is unmounted.  Attempts
are rejected with "/dev/md0: Device or resource busy".  Even shutting
down to single user mode does not release the device for stopping.  I
had to reboot to single user mode, then I was able to stop it,
unconfigure it, etc.

Testing the throughput of Linux's software raid in levels raid1 and
raid0 with various chunksizes was somewhat more tedious because of this
problem...

Here is my (current) raidtab:

Raiddev			/dev/md0
raid-level			0
nr-raid-disks		2
chunk-size			64k
persistent-superblock	1
nr-spare-disks		0
device			/dev/sda2
raid-disk			0
device			/dev/sdb1
raid-disk			1

Thanks...

Al


