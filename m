Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTIYRPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTIYRPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:15:18 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:12695 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261276AbTIYRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:15:12 -0400
Date: Thu, 25 Sep 2003 19:14:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches: descriptions.
Message-ID: <20030925171428.GA2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
I have 19 patches for you, all of them affect only s390. The patches are
against todays bitkeeper tree. I've seen that 32 bit dev_t are finally
in. We'll have another patch for dasd soon :-))

Short descriptions:
1) The usual base bug fix collection for s390.
2) Bug fixes/improvements for the common i/o layer.
3) 31 bit compatability fixes.
4) Some micro optimizations.
5) Fix for the system tick misaccounting problem. LPAR and VM have the
   tedious habit to deliver timer ticks after i/o interrupts if they
   are close enough together although the timer interrupt arrived first.
   In some szenarios (network benchmarks) this happens all the time and
   this leads to high system time numbers although the system is mostly
   idle.
6) Restarting of system calls crashes if the svc instruction was done via
   an execute instruction.
7) Make use of sysfs_create_group.
8) Kconfig update. Arnd added a condition to BLK_DEV_FD in
   drivers/block/Kconfig so that we can use it in the s390 config.
   In addition the s390 block device configs now reside in
   drivers/s390/block/Kconfig where they belong.
9) Guillaume Morin tested xpram on a 64 bit machine and found some bugs.
10) dasd format fix. Now unformatted dasd device can be accessed with 2.6.
11) Bug fix for the dasd partition support.
12) Bug fixes for the block device interface of the tape driver.
13) Update of the ctc network driver.
14) Bug fixes and update of the iucv network driver.
15) Update of the lcs network driver.
16) Bug fixes and update of the qeth network driver.
17) Add support for vt220 console over sclp.
18) Documentation changes.
19) Remove some outdates files. The ipl boot records have been moved
    to a userspace package.

blue skies,
  Martin.

