Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129462AbRBVGEC>; Thu, 22 Feb 2001 01:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRBVGDw>; Thu, 22 Feb 2001 01:03:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11392 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129462AbRBVGDp>;
	Thu, 22 Feb 2001 01:03:45 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.43857.22794.280050@pizda.ninka.net>
Date: Wed, 21 Feb 2001 22:01:53 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] Zerocopy BETA 2 against 2.4.2 final.
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Usual place:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2-1.diff.gz

Besides merging to the 2.4.2-final release there are two bug fixes:

1) New TCP receive queue collapser could trigger assertion failures
   in tcp_recvmsg(), reason: uninitialized skb->used field in fresh
   SKB allocated for collapsing.

2) IP header IDs are generated differently on big vs. little endian
   systems, added htons() to fix.

Some have asked why this isn't pushed to Alan for his AC patches yet,
the reason is that I want to fully resolve the final few performance
issues that remain (1.5K mtu on gbit still has some warts).  Once
those are cleared and everyone involved is satisfied that there are no
performance regressions against vanilla 2.4.2, I will ask Alan to
consider including it.

Later,
David S. Miller
davem@redhat.com
