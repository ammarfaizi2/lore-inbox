Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKMv0>; Thu, 11 Jan 2001 07:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAKMvQ>; Thu, 11 Jan 2001 07:51:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129610AbRAKMuy>;
	Thu, 11 Jan 2001 07:50:54 -0500
Date: Wed, 10 Jan 2001 20:50:50 -0800
Message-Id: <200101110450.UAA02405@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: Updated zerocopy patches on kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now against 2.4.1-pre2:

ftp.kernel.org:/pub/linux/kernel/people/davem/zerocopy-2.4.1p2-1.diff.gz

Changes since the previous installment:

1) Correct netfilter URLS, from Paul Russell.
2) Increase MAX_SKB_FRAGS to 6, from me.
3) Set loopback MTU more appropriately now that we
   use page based SKBs, from me.
4) Backout bogus ip_decrease_ttl "boolean in C can be not 1"
   change.
5) Accept ARP hardware types of 6 and 1 for Fibre Channel,
   from LSI Logic.
6) If ipv6 fragment is not a multiple of 8 _always_ send
   parameter problem message.  From Aki M. Laukkanen
7) Make u32 packet classifier algorithm halt if all handles
   are taken already.  From me.
8) Fix SMP protection of xprt->snd_task value, from me.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
