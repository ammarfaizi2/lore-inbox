Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbRGWQRR>; Mon, 23 Jul 2001 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbRGWQRH>; Mon, 23 Jul 2001 12:17:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6996 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268285AbRGWQQ6>; Mon, 23 Jul 2001 12:16:58 -0400
Date: Mon, 23 Jul 2001 18:17:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723181711.Q822@athlon.random>
In-Reply-To: <200107230508.AAA04621@ccure.karaya.com> <20010723175635.L822@athlon.random> <20010723175907.N822@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010723175907.N822@athlon.random>; from andrea@suse.de on Mon, Jul 23, 2001 at 05:59:07PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 05:59:07PM +0200, Andrea Arcangeli wrote:
> On Mon, Jul 23, 2001 at 05:56:35PM +0200, Andrea Arcangeli wrote:
> > BTW, Linus the _below_ patches against mainline are needed to compile
> > the x86 port with gcc-3_0-branch of yesterday, it is safe to include it
> > in mainline:
> 
> here another one for reiserfs:

here another one:

--- 2.4.7aa1/net/ipv4/netfilter/ip_queue.c.~1~	Sat Jul 21 00:04:34 2001
+++ 2.4.7aa1/net/ipv4/netfilter/ip_queue.c	Mon Jul 23 18:14:45 2001
@@ -492,7 +492,7 @@
 
 #define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err)); return; } while (0);
 
-extern __inline__ void netlink_receive_user_skb(struct sk_buff *skb)
+static __inline__ void netlink_receive_user_skb(struct sk_buff *skb)
 {
 	int status, type;
 	struct nlmsghdr *nlh;

Andrea
