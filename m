Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136145AbRDVORV>; Sun, 22 Apr 2001 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136148AbRDVORL>; Sun, 22 Apr 2001 10:17:11 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:62733 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S136145AbRDVORB>;
	Sun, 22 Apr 2001 10:17:01 -0400
Date: Sun, 22 Apr 2001 15:54:35 +0200 (CEST)
From: <raid@ddx.a2000.nu>
To: <linux-raid@vger.kernel.org>
Subject: Maxtor 80gb slow on asus p2b-d ? (going to use it in raid5 config)
Message-ID: <Pine.LNX.4.30.0104221547120.3518-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm going to build a raid5 config with 6*maxtor 80gb
mainbord is an asus p2b-d (with dual 450 and 512mb ram)
and 2 addon ultra66 promise controllers

i did some tests using hdparm (4.1)
and i get these result :

(hda and hdc are on the onboard controller)

/dev/hda:
 Timing buffered disk reads:  64 MB in  4.94 seconds = 12.96 MB/sec

/dev/hdc:
 Timing buffered disk reads:  64 MB in  4.94 seconds = 12.96 MB/sec

/dev/hde:
 Timing buffered disk reads:  64 MB in  2.26 seconds = 28.32 MB/sec

/dev/hdg:
 Timing buffered disk reads:  64 MB in  2.25 seconds = 28.44 MB/sec

/dev/hdi:
 Timing buffered disk reads:  64 MB in  2.25 seconds = 28.44 MB/sec

/dev/hdk:
 Timing buffered disk reads:  64 MB in  2.25 seconds = 28.44 MB/sec

kernel reports :
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(33)
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(33)
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(66)
hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(66)
hdi: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(66)
hdk: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(66)

and i use hdparm -m16 -c1 -d1 -a8  on all hd's
so why do i only see 13mb/sec on the ultra33 controller
(i thought 28mb/sec would be possible on the ultra33 controller)

i also made a raid0 on the 6 disks
and this gives me :

/dev/md0:
 Timing buffered disk reads:  64 MB in  2.13 seconds = 30.05 MB/sec




