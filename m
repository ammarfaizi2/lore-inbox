Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129395AbRBCHYE>; Sat, 3 Feb 2001 02:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129556AbRBCHXz>; Sat, 3 Feb 2001 02:23:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10112 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129395AbRBCHXk>;
	Sat, 3 Feb 2001 02:23:40 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14971.45502.776808.711822@pizda.ninka.net>
Date: Fri, 2 Feb 2001 23:22:38 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] Zerocopy 2.4.1 rev 3
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You know where to get it:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1-3.diff.gz

Fixes:

1) pskb_expand_tail could corrupt SKB frag lists in some
   cases, leading to OOPS

2) Need to check for out of window data even in the
   partial packet cases of tcp_data_queue

3) Merged in some small net fixes from the AC patches.

As of this moment, I know of no bugs (ie. corrupts data or crashes
kernel) in the zerocopy patches.

Some people have asked me about making a patch against the AC
patches.  It is doable, but would be quite a bit of work for me.

If someone would like to do this and put those patches up somewhere,
they can feel free to do so.  Just let everyone on linux-kernel
and netdev know about it.  Probably, after the next zerocopy patch
revision, I will ask Alan to add the zerocopy stuff to his tree
anyways.  Things really look good right now.

Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
