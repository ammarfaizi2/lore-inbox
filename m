Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSHLHY1>; Mon, 12 Aug 2002 03:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSHLHY1>; Mon, 12 Aug 2002 03:24:27 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:2451 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S317463AbSHLHYZ>;
	Mon, 12 Aug 2002 03:24:25 -0400
Date: Mon, 12 Aug 2002 10:28:10 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
In-Reply-To: <200208112125.BAA16174@sex.inr.ac.ru>
Message-ID: <Pine.GSO.4.43.0208121024250.29811-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, if this is so easy to reproduce, you could try to answer this. :-)

Before and after the connetion attempt - looks like the number of bad
segments is increasing so probably not a TCP bug.

Since I can connect to this server fine from different locations, it
looks like something (ISP caches/shapers? cable modem?) is corrupting
specific packets in a reproducible way.

--- enne	2002-08-12 10:22:47.000000000 +0300
+++ nyyd	2002-08-12 10:23:37.000000000 +0300
@@ -1,9 +1,9 @@
 Ip:
-    490363 total packets received
+    490378 total packets received
     54146 forwarded
     0 incoming packets discarded
-    467788 incoming packets delivered
-    391339 requests sent out
+    467803 incoming packets delivered
+    391348 requests sent out
 Icmp:
     32786 ICMP messages received
     0 input ICMP message failed.
@@ -16,33 +16,33 @@
         destination unreachable: 11
         echo replies: 4
 Tcp:
-    3012 active connections openings
+    3013 active connections openings
     31 passive connection openings
     0 failed connection attempts
     0 connection resets received
     0 connections established
-    385065 segments received
-    355005 segments send out
+    385077 segments received
+    355011 segments send out
     437 segments retransmited
-    801 bad segments received.
+    808 bad segments received.
     761 resets sent
 Udp:
-    18080 packets received
+    18083 packets received
     11 packets to unknown port received.
     0 packet receive errors
-    2873 packets sent
+    2876 packets sent
 TcpExt:
     ArpFilter: 0
-    321 TCP sockets finished time wait in fast timer
+    322 TCP sockets finished time wait in fast timer
     3621 delayed acks sent
     9 delayed acks further delayed because of locked socket
     Quick ack mode was activated 141 times
-    767 packets directly queued to recvmsg prequeue.
+    777 packets directly queued to recvmsg prequeue.
     1241624 packets directly received from backlog
     556184 packets directly received from prequeue
     298158 packets header predicted
     1271 packets header predicted and directly queued to user
-    TCPPureAcks: 5053
+    TCPPureAcks: 5056
     TCPHPAcks: 16768
     TCPRenoRecovery: 0
     TCPSackRecovery: 2

-- 
Meelis Roos (mroos@linux.ee)

