Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUEYXrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUEYXrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUEYXrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:47:13 -0400
Received: from skif.spylog.com ([194.67.35.250]:42184 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id S265238AbUEYXrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:47:10 -0400
Date: Wed, 26 May 2004 03:46:57 +0400
From: Andrey Nekrasov <andy@spylog.ru>
Reply-To: Andrey Nekrasov <andy@spylog.ru>
X-Priority: 3 (Normal)
Message-ID: <1236867749.20040526034657@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: sata promise and software raid5...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

controller - Promise SATA 150 TX4, linux 2.6.7-rc1-bk1, HDD Maxtor
250Gb (x4)

Why so slowly reads (and writes) with software raid5?

gnome:~ # hdparm -t /dev/sda2

/dev/sda2:
 Timing buffered disk reads:  148 MB in  3.01 seconds =  49.16 MB/sec
gnome:~ # hdparm -t /dev/sdb2

/dev/sdb2:
 Timing buffered disk reads:  148 MB in  3.02 seconds =  49.01 MB/sec
gnome:~ # hdparm -t /dev/sdc2

/dev/sdc2:
 Timing buffered disk reads:  148 MB in  3.03 seconds =  48.90 MB/sec
gnome:~ # hdparm -t /dev/sdd2

/dev/sdd2:
 Timing buffered disk reads:  144 MB in  3.00 seconds =  47.96 MB/sec
gnome:~ #
gnome:~ #
gnome:~ # hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:   64 MB in  3.12 seconds =  20.52 MB/sec
gnome:~ #


gnome:~ # cat /etc/raidtab
raiddev /dev/md0
        raid-level              5
        nr-raid-disks           4
        nr-spare-disks          0
        persistent-superblock   1
        parity-algorithm        left-symmetric
        chunk-size              1024

        device                  /dev/sda2
        raid-disk               0

        device                  /dev/sdb2
        raid-disk               1

        device                  /dev/sdc2
        raid-disk               2

        device                  /dev/sdd2
        raid-disk               3

        
bye
--


