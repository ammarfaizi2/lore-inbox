Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTI2PU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTI2PU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:20:58 -0400
Received: from buerotecgmbh.de ([217.160.181.99]:13545 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S263549AbTI2PT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:19:59 -0400
Date: Mon, 29 Sep 2003 17:19:57 +0200
From: Kay Sievers <lkml001@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6-test6-mm1 zombie hotplug/event processes
Message-ID: <20030929151957.GA8260@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the hotplug/event processes are hanging in my task list.
Everything if working, but as a example: USB-mouse disconnect/connect gets 6 more
zombies.

2.4 is okay. System is debian sid with hotplug package 20030924.

Any idea, why this happens?

Thanks
Kay


pim:~# ps afx
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:03 init [2]  
    2 ?        SWN    0:00 [ksoftirqd/0]
    3 ?        SW<    0:00 [events/0]
   41 ?        Z<     0:00  \_ [events/0] <defunct>
   58 ?        Z<     0:00  \_ [hotplug] <defunct>
   68 ?        Z<     0:00  \_ [hotplug] <defunct>
   79 ?        Z<     0:00  \_ [hotplug] <defunct>
  123 ?        Z<     0:00  \_ [hotplug] <defunct>
  128 ?        Z<     0:00  \_ [hotplug] <defunct>
  134 ?        Z<     0:00  \_ [hotplug] <defunct>
  140 ?        Z<     0:00  \_ [hotplug] <defunct>
  145 ?        Z<     0:00  \_ [hotplug] <defunct>
  151 ?        Z<     0:00  \_ [hotplug] <defunct>
  157 ?        Z<     0:00  \_ [hotplug] <defunct>
  162 ?        Z<     0:00  \_ [hotplug] <defunct>
  168 ?        Z<     0:00  \_ [hotplug] <defunct>
  186 ?        Z<     0:00  \_ [events/0] <defunct>
  188 ?        Z<     0:00  \_ [events/0] <defunct>
  190 ?        Z<     0:00  \_ [hotplug] <defunct>
  196 ?        Z<     0:00  \_ [hotplug] <defunct>
  221 ?        Z<     0:00  \_ [events/0] <defunct>
  462 ?        Z<     0:00  \_ [events/0] <defunct>
  464 ?        Z<     0:00  \_ [events/0] <defunct>
  466 ?        Z<     0:00  \_ [events/0] <defunct>
  488 ?        Z<     0:00  \_ [hotplug] <defunct>
  497 ?        Z<     0:00  \_ [events/0] <defunct>
  499 ?        Z<     0:00  \_ [events/0] <defunct>
  501 ?        Z<     0:00  \_ [events/0] <defunct>
  503 ?        Z<     0:00  \_ [events/0] <defunct>
  505 ?        Z<     0:00  \_ [events/0] <defunct>
  507 ?        Z<     0:00  \_ [events/0] <defunct>
  551 ?        Z<     0:00  \_ [hotplug] <defunct>
  557 ?        Z<     0:00  \_ [hotplug] <defunct>
  669 ?        Z<     0:00  \_ [events/0] <defunct>
    4 ?        SW<    0:00 [kblockd/0]
    5 ?        SW     0:00 [pdflush]
    6 ?        SW     0:00 [pdflush]
    7 ?        SW     0:00 [kswapd0]
    8 ?        SW<    0:00 [aio/0]
    9 ?        SW<    0:00 [aio_fput/0]
   10 ?        SW     0:00 [kseriod]
...

