Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSGQUHk>; Wed, 17 Jul 2002 16:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSGQUHk>; Wed, 17 Jul 2002 16:07:40 -0400
Received: from mailrelay.ds.lanl.gov ([128.165.47.40]:13981 "EHLO
	mailrelay.ds.lanl.gov") by vger.kernel.org with ESMTP
	id <S316621AbSGQUGz>; Wed, 17 Jul 2002 16:06:55 -0400
Subject: 2.5.25-dj2, kernel BUG at dcache.c:361
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, Steven Cole <scole@lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Jul 2002 14:06:50 -0600
Message-Id: <1026936410.11636.107.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running 2.5.25-dj2 and dbench with increasing numbers of clients,
my test machine locked up with the following message:

kernel BUG at dcache.c:361!

I tried to copy down the following register dump but was unable to.
Nothing interesting saved in /var/log/messages.

This is fairly repeatable in that it happens with running dbench with
more than 32 clients.  I saw it once with as few as 6 clients.  After
getting weary of running fsck on an ext2 /home partition, I added a
journal to /home and mounted it as ext3.  With /home (where dbench is
running) mounted as ext3, I got the following message just before the
BUG:

EXT3-fs error (device sd(8,8): ext3_free_blocks: freeing blocks not in
datazone - block = 7939096, count = 13.

The test machine is a dual p3 1mb memory, scsi, 2.5.25-dj2 SMP kernel.

Steven



