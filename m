Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbQLCBNV>; Sat, 2 Dec 2000 20:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130804AbQLCBNL>; Sat, 2 Dec 2000 20:13:11 -0500
Received: from r109m245.cybercable.tm.fr ([195.132.109.245]:7428 "HELO alph")
	by vger.kernel.org with SMTP id <S130767AbQLCBM4>;
	Sat, 2 Dec 2000 20:12:56 -0500
To: rusty@linuxcare.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test12-pre3] ip_conntrack_proto_tcp.c compilation fix.
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 03 Dec 2000 01:42:21 +0100
Message-ID: <87sno6gwsy.fsf@mandrakesoft.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux/net/ipv4/netfilter/ip_conntrack_proto_tcp.c.orig	Sat Dec  2 16:18:05 2000
+++ linux/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Sat Dec  2 16:19:04 2000
@@ -228,6 +228,6 @@
 }
 
 struct ip_conntrack_protocol ip_conntrack_protocol_tcp
-= { { NULL, NULLpkt_IPPROTO_TCP, "tcp",
-    tcp_ableto_tuple, tcp_invert_tuple, tcp_print_tuple, tcp_print_conntrack,
+= { { NULL, NULL }, IPPROTO_TCP, "tcp",
+    tcp_pkt_to_tuple, tcp_invert_tuple, tcp_print_tuple, tcp_print_conntrack,
     tcp_packet, tcp_new, NULL };


-- 
		-- Yoann http://www.mandrakesoft.com/~yoann/
   An engineer from NVidia, while asking him to release cards specs said :
	"Actually, we do write our drivers without documentation."








-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
