Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSBDEHu>; Sun, 3 Feb 2002 23:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSBDEHk>; Sun, 3 Feb 2002 23:07:40 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:1856 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S288325AbSBDEHa>; Sun, 3 Feb 2002 23:07:30 -0500
From: brian@worldcontrol.com
Date: Sun, 3 Feb 2002 20:05:34 -0800
To: linux-kernel@vger.kernel.org
Subject: valen kernel: kmem_alloc: Bad slab magic (corrupt)
Message-ID: <20020204040534.GA2322@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 14 machines all running Linux 2.2.19 with reiserfs.  All
have been running for at least 4 months 24/7.
All are AMD Athlons or Durons, with 1.5GB memory, and are
interconnected by a 16 port 100mbit/s switch.  All machines have
tons of cooling and are in a temperature, humidity and power
controlled environment.  No overclocking.

The particular machine valen is a 1.333 GHz Athlon Thunderbird

Earlier today it started reporting:

Feb  3 08:24:57 valen kernel: kmem_alloc: Bad slab magic (corrupt)              (name=size-4096)
Feb  3 08:25:17 valen last message repeated 7 times                            ...
Feb  3 08:27:46 valen kernel: kmem_alloc: Bad slab magic (corrupt)              (name=size-4096)
Feb  3 08:27:47 valen kernel: nfs: task 2109 can't get a request slot
Feb  3 08:29:16 valen kernel: nfs: task 2111 can't get a request slot
Feb  3 08:29:24 valen kernel: nfs: task 2112 can't get a request slot
Feb  3 08:29:47 valen kernel: nfs: task 2109 can't get a request slot
...

rebooted machine, then later...

Feb  3 16:50:27 valen kernel: call_verify: server accept status: 2
Feb  3 16:50:27 valen kernel: RPC: garbage, retrying    0
Feb  3 16:50:27 valen kernel: call_verify: server accept status: 2
Feb  3 16:50:27 valen kernel: RPC: garbage, retrying    0
Feb  3 16:50:27 valen kernel: call_verify: server accept status: 2
Feb  3 16:50:27 valen kernel: RPC: garbage, exit EIO
Feb  3 16:50:27 valen kernel: nfs_get_root: getattr error = 5

Though I think most of the machines occasionally get these later
messages.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
