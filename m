Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRABD3T>; Mon, 1 Jan 2001 22:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRABD3I>; Mon, 1 Jan 2001 22:29:08 -0500
Received: from linuxcare.com.au ([203.29.91.49]:61702 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130031AbRABD24>; Mon, 1 Jan 2001 22:28:56 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] set_bit takes a long.
Date: Tue, 02 Jan 2001 13:58:05 +1100
Message-Id: <E14DHeH-0001H9-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan has this, obviously hasn't made it to you.

This is the only part of the `set_bit takes a long' audit results I
personally care about.

Thanks,
Rusty.
--
Hacking time.

diff -urN -I \$.*\$ -X /tmp/kerndiff.oiH8zd --minimal linux-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h working-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h
--- linux-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h	Tue Nov  7 15:33:02 2000
+++ working-2.4.0-test11-5/include/linux/netfilter_ipv4/ip_conntrack.h	Thu Nov 16 19:38:19 2000
@@ -101,7 +101,7 @@
 	struct ip_conntrack_tuple_hash tuplehash[IP_CT_DIR_MAX];
 
 	/* Have we seen traffic both ways yet? (bitset) */
-	volatile unsigned int status;
+	volatile unsigned long status;
 
 	/* Timer function; drops refcnt when it goes off. */
 	struct timer_list timeout;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
