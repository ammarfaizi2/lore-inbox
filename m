Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbRAGLYf>; Sun, 7 Jan 2001 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130526AbRAGLYY>; Sun, 7 Jan 2001 06:24:24 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:18446 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130368AbRAGLYP>; Sun, 7 Jan 2001 06:24:15 -0500
Message-ID: <001101c0789c$e006d7b0$0201a8c0@p3x2nt>
From: oliver.kowalke@t-online.de (Oliver Kowalke)
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.0 + software RAID causes problems
Date: Sun, 7 Jan 2001 12:27:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my machine (x86) I've debian2.2r2 with kernel 2.2.16 + raidtools 0.9
running. No problems. Yesterday I installed kern 2.4.0 with the same
configuration like 2.2.16. I added following to the boot params:

root=/dev/md0 md=0,/dev/hde1,/dev/hdg1

If I boot 2.4.0 I can see following:

...
<init of raid>
raid:0 md-size is 249728 blocks
raid0: conf->smallest->size is 249728 blocks
raid0: nb_zone is 1
raid0: blocking 8 bytes for hash
md: updating md0 RAID superblock on device                <<<------
<...>
... autorun DONE
md: loading md0
... md0 already autodetected -use raid=noautodetect
<...>
Parallelizing fsck version 1.18
fsck.ext2: No such file or directory while trying to open /dev/md0 (null):
The superblock could not be read or does not describe a correct ext2
filesystem.


The filessystem is clean because I can mount it with kernel 2.2.16 without
problems. Maybe kernel 2.4.0 does the wrong in updating the RAIS superblock
on md0.
Please help!

with regards,
Oliver



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
