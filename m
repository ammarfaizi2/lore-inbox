Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261788AbSI2UPN>; Sun, 29 Sep 2002 16:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSI2UPN>; Sun, 29 Sep 2002 16:15:13 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:10880 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S261788AbSI2UPM>;
	Sun, 29 Sep 2002 16:15:12 -0400
Date: Sun, 29 Sep 2002 13:20:34 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@linuxcare.com.au>,
       Harald Welte <laforge@gnumonks.org>
Subject: ASSERT: ip_nat_core.c:841 &ip_conntrack_lock not readlocked
Message-ID: <20020929202034.GA9591@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20pre8, up for about a day, stopped responding.

This box is our staff NAT box, and has been stable running 2.4.19-pre4
for 183 days.  On Saturday morning, I put 2.4.20-pre8 on, and did not
notice until now that it was spitting these messages everywhere:

ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1014 buckets, 8112 max) - 292 bytes per conntrack
ASSERT ip_conntrack_core.c:624 &ip_conntrack_lock not readlocked
ASSERT ip_conntrack_core.c:94 &ip_conntrack_lock readlocked
ASSERT: ip_nat_core.c:841 &ip_conntrack_lock not readlocked
ASSERT ip_conntrack_core.c:94 &ip_conntrack_lock readlocked
ASSERT ip_conntrack_core.c:1063 &ip_conntrack_lock not readlocked
ASSERT ip_conntrack_core.c:1074 &ip_conntrack_lock not readlocked
ASSERT: ip_nat_core.c:841 &ip_conntrack_lock not readlocked
ASSERT ip_conntrack_core.c:94 &ip_conntrack_lock readlocked

(Taken from after a reboot, but the kern.log is full of these messages
from last time.)

Just now, the box died with the console full of this message:

ASSERT: ip_nat_core.c:841 &ip_conntrack_lock not readlocked

No Oops or backtrace occurred.  Sysrq apparently didn't work.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
