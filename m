Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319039AbSIJFhD>; Tue, 10 Sep 2002 01:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSIJFhD>; Tue, 10 Sep 2002 01:37:03 -0400
Received: from dp.samba.org ([66.70.73.150]:26753 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319039AbSIJFhB>;
	Tue, 10 Sep 2002 01:37:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jens Axboe <axboe@suse.de>, andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Missing IDE partition 3 of 3 on 2.5.34?
Date: Tue, 10 Sep 2002 15:07:53 +1000
Message-Id: <20020910054147.C86272C1FD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

2.5.33 was fine, but from the boot messages (dual x86 box):

	hda: IC35L020AVER07-0, ATA DISK drive
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	hda: host protected area => 1
	hda: 39876480 sectors (20417 MB) w/1916KiB Cache, CHS=3323040/12/1
	 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

But it doesn't seem to have registered the third partition (/usr):

	(none):~# cat /proc/partitions 
	major minor  #blocks  name

	   3     0   19938240 ide/host0/bus0/target0/lun0/disc
	   3     1     489951 ide/host0/bus0/target0/lun0/part1
	   3     2     128520 ide/host0/bus0/target0/lun0/part2
	   3     3   19318162 hda3

	(none):~# ls -l /dev/ide/host0/bus0/target0/lun0/
	disc   part1  part2  

Devfs issue?  IDE screwage?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
