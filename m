Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKFGPj>; Mon, 6 Nov 2000 01:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129117AbQKFGP3>; Mon, 6 Nov 2000 01:15:29 -0500
Received: from vpop4-111.pacificnet.net ([209.204.35.111]:7940 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129044AbQKFGPU>; Mon, 6 Nov 2000 01:15:20 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200011060615.WAA05490@cx518206-b.irvn1.occa.home.com>
Subject: [PATCH] document ECN in 2.4 Configure.help
To: linux-kernel@vger.kernel.org
Date: Sun, 5 Nov 2000 22:15:20 -0800 (PST)
Reply-To: barryn@pobox.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the dates below show, I've actually been sitting on this patch for about
a week, but I just now got a chance to post it. I haven't had time to
fully, absolutely, completely grok what ECN is, so it's possible that this
help text is incorrect. If so, I'd like to hear about it.

This patch is against test10pre7 but applies cleanly to test10 final as
well.

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.0test10pre7/Documentation/Configure.help linux-2.4.0test10pre7-bkn/Documentation/Configure.help
--- linux-2.4.0test10pre7/Documentation/Configure.help	Mon Oct 30 21:36:42 2000
+++ linux-2.4.0test10pre7-bkn/Documentation/Configure.help	Tue Oct 31 10:13:32 2000
@@ -2052,6 +2052,23 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
+TCP Explicit Congestion Notification support
+CONFIG_INET_ECN
+  Explicit Congestion Notification (ECN) allows routers to notify
+  clients about network congestion, resulting in fewer dropped packets
+  and increased network performance. This option adds ECN support to the
+  Linux kernel, as well as a sysctl (/proc/sys/net/ipv4/tcp_ecn) which
+  allows ECN support to be disabled at runtime.
+
+  Note that, on the Internet, there are many broken firewalls which
+  refuse connections from ECN-enabled machines, and it may be a while
+  before these firewalls are fixed. Until then, to access a site behind
+  such a firewall (some of which are major sites, at the time of this
+  writing) you will have to disable this option, either by saying N now
+  or by using the sysctl.
+
+  If in doubt, say N.
+
 SYN flood protection
 CONFIG_SYN_COOKIES
   Normal TCP/IP networking is open to an attack known as "SYN
diff -ruN linux-2.4.0test10pre7/Documentation/networking/ip-sysctl.txt linux-2.4.0test10pre7-bkn/Documentation/networking/ip-sysctl.txt
--- linux-2.4.0test10pre7/Documentation/networking/ip-sysctl.txt	Fri Aug 18 10:26:25 2000
+++ linux-2.4.0test10pre7-bkn/Documentation/networking/ip-sysctl.txt	Tue Oct 31 10:13:32 2000
@@ -203,7 +203,7 @@
 tcp_dsack - BOOLEAN
 	Allows TCP to send "duplicate" SACKs.
 
-tcp_ecn - BOOLEN
+tcp_ecn - BOOLEAN
 	Enable Explicit Congestion Notification in TCP.
 
 tcp_reordering - INTEGER
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
