Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130598AbRBMHPH>; Tue, 13 Feb 2001 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbRBMHO6>; Tue, 13 Feb 2001 02:14:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4227 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130598AbRBMHOr>;
	Tue, 13 Feb 2001 02:14:47 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14984.56970.908321.405130@pizda.ninka.net>
Date: Mon, 12 Feb 2001 23:13:14 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] zerocopy + powder rule
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The only change is to update things to 2.4.2-pre3:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2p3-1.diff.gz

All the reports I am getting now appear to be consistent,
and they all basically show me that:

1) There are no known bugs (as in things that crash the
   kernel or corrupt data)

2) The loopback etc. raw performance anomalies have been
   killed by the P-II Mendocino unaligned memcpy workaround.

3) The acenic/gbit performance anomalies have been cured
   by reverting the PCI mem_inval tweaks.

4) The zerocopy patches have a small yet non-neglible
   cpu usage cost for normal write/send/sendmsg.

If this truly is the current state of affairs, then I am
pretty happy as this is where I wanted things to be when
I first began to publish these zerocopy diffs.  The next
step is to begin profiling things heavily to see if we
can back some of that extra cpu usage the pages SKBs
afford us.

Due to the powder rule (Lake Tahoe received 6 or so feet of snow this
past weekend) I will be a bit quiet until Friday night.  However, I'll
be doing my own profiling of the zerocopy stuff on my laptop while I'm
up there.

Later,
David Snowboard Miller
davem@redhat.com

