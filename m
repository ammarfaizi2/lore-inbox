Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbRBSAWL>; Sun, 18 Feb 2001 19:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbRBSAVt>; Sun, 18 Feb 2001 19:21:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23168 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130070AbRBSAVn>;
	Sun, 18 Feb 2001 19:21:43 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14992.26288.233276.641078@pizda.ninka.net>
Date: Sun, 18 Feb 2001 16:20:00 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] Zerocopy BETA 1, against 2.4.2-pre4
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm calling this "BETA 1" because I currently feel that all
performance and other issues have been addressed and that the
patch is up for serious consideration for inclusion into a
future 2.4.x release:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2p4-1.diff.gz

Besides merging to 2.4.2-pre4 the main change in this release is
a totally revamped paged-SKB sendmsg implementation by Alexey.
I truly believe now that bandwidth/latency is back to where we
were before the zerocopy patches, and preliminary testing done
by Andrew Morton supports this.  (actually, in my own testing,
latency over loopback seems to have improved)

Some verbose TCP debugging is enabled in this release, most of
the messages are harmless %99 of the time.  If these messages
bother you just set "FASTRETRANS_DEBUG" back to "1" in
include/net/tcp.h

Thanks.

Later,
David S. Miller
davem@redhat.com
