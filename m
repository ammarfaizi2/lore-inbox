Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280666AbRKJOac>; Sat, 10 Nov 2001 09:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280667AbRKJOaW>; Sat, 10 Nov 2001 09:30:22 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:25517 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280666AbRKJOaM>; Sat, 10 Nov 2001 09:30:12 -0500
Date: Sat, 10 Nov 2001 15:29:49 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: linux-kernel@vger.kernel.org
Subject: Numbers: ext2/ext3/reiser Performance (ext3 is slow)
In-Reply-To: <20011110.055217.85412085.davem@redhat.com>
Message-ID: <Pine.LNX.4.40.0111101516050.14500-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.27)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello !

On my test to optimize mysql-Performance I noticed, that the sql-bench is
significantly slower when the tables are stored on a partition with
reiserfs than ext2. I assume this is normal due to the overhead of journal
in write-intensiv tasks. I reran the test with ext3 and was shocked how
slow the bench was then. Here are the numbers for my old K6/400 with
scsi-disks.

Time to complete sql-bench

ext2	176min
reiser  203min (+15%)
ext3    310min (+76%)   (first test with 2.4.14-ext3 319min)

I ran all tests multiple times. Since I used the same Kernels this
is not an vm-issue. I tested on 2.4.14, 2.4.14+ext3 and 2.5.15-pre2.
Since the sql-bench is not an pure fs-test the fs should only play a
minor role. +76% time on this test means to mean that either ext3 is
horible slow or has a severe bug.
For those who know sql-bench I say, that test-insert seems to be the worst
case. It shows
Total time: 5880 wallclock secs  for ext2 and 13277 for ext3.
swap was disabled during test.

Anyone has an idea, why this ext3 "fails" at this specific test while on
normal fs-benchmarks it is much better ?

Oktay

