Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282497AbRLKSdv>; Tue, 11 Dec 2001 13:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282499AbRLKSdl>; Tue, 11 Dec 2001 13:33:41 -0500
Received: from mustard.heime.net ([194.234.65.222]:11904 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S282497AbRLKSda>; Tue, 11 Dec 2001 13:33:30 -0500
Date: Tue, 11 Dec 2001 19:33:14 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: possible bug with RAID
Message-ID: <Pine.LNX.4.30.0112111730570.1329-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I have this pc with a promise udma133 tx2 controller, having one 120G
drive per channel. I'm benchmarking this, using some 50 'dd if=file[1..50]
of=/dev/null' to simuate my application. This will work for a few seconds,
giving me pretty good i/o speed, but then all the processes go defunct and
stay like that some minutes (i really don't know how long).

I tried to do the bechmark with the individual drives, and no problem
there...

Anyone have a clue?

Configuration:
- Promise 133 TX2 (20269 manually patched in. Just made som defines to
  alias it to the 20268)
- 2 WD1200BB drives (hde and hdg)

/etc/raidtab:

raiddev /dev/md0
	raid-level              0
	nr-raid-disks           2
	persistent-superblock   0
	chunk-size              4096

	device                  /dev/hde
	raid-disk               0
	device                  /dev/hdg
	raid-disk               1

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.



