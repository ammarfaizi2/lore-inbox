Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSGVPh2>; Mon, 22 Jul 2002 11:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317564AbSGVPh2>; Mon, 22 Jul 2002 11:37:28 -0400
Received: from [216.167.57.166] ([216.167.57.166]:3849 "EHLO liveglobalbid.com")
	by vger.kernel.org with ESMTP id <S317550AbSGVPh1>;
	Mon, 22 Jul 2002 11:37:27 -0400
Message-ID: <3D3C2773.F33D425@liveglobalbid.com>
Date: Mon, 22 Jul 2002 09:40:35 -0600
From: Roe Peterson <roe@liveglobalbid.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: raid1 problems in 2.5.26 (maybe started at .1?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm adding 2.5.26 to a stock redhat 7.3 distribution, which was
installed with a raid1 root
filesystem on /dev/hda1 and /dev/hdb1.

This is on a Dell GX-260 w/256MB RAM, twin 20MB IDE hard drives.

The system boots 2.5.26, runs, resyncs the raid1 array, and then, just
as the resync
finishes, the BUG at line 655 in drivers/md/raid1.c goes off:

    if (waitqueue_active(&conf->wait_resume)) BUG();

There are no other raid arrays on the system.

I _seriously_ hesitate to simply comment out the bugcheck :-)


It seems that the 2.5.1 patch made wholesale changes to the raid1
subsystem...

Anyone ever seen anything like this?  Have I missed something external
to the
kernel that needs to be updated between 2.4.18 and 2.5.26?



