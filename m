Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTL2Qmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTL2Qmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:42:31 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:50096 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S263593AbTL2Qma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:42:30 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Speed drop /dev/sda -> /dev/sda1 -> /dev/vg0/test (3ware/LVM)
Date: Mon, 29 Dec 2003 16:42:29 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bsplhl$oq9$1@news.cistron.nl>
References: <20031229125412.GA28262@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1072716149 25417 62.216.29.200 (29 Dec 2003 16:42:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031229125412.GA28262@cistron.nl>,
Miquel van Smoorenburg  <miquels@cistron.nl> wrote:
>Hello,
>
>	I'm running Linux 2.6.0 with a 3ware 8506 controller in
>hardware RAID5 mode. The RAID5 array is built of 7+1 200 MB SATA
>disks.
>
>Now it appears that more "mappings" on the array have a bad
>influence on speed. /dev/sda is the fastest, /dev/sda1 is quite
>a bit slower, LVM on /dev/sda is slower yet and LVM on /dev/sda1
>is the slowest.

For reference, I just took 2.4.24-pre2, applied the device-mapper
patches to it, and re-ran the tests.

Base performance on /dev/sda is a bit slower (70 MB/sec vs 80 MB/sec
raw writespeed), but speeds on /dev/sda1 and /dev/vg0/test are
exactly the same.

So it doesn't look like a 3ware driver or LVM issue as those are
basically the same between the 2.4 and 2.6 systems.

Mike.
-- 
When life hands you lemons, grab the salt and pass the tequila.

