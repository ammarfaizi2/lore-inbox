Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSAJVuY>; Thu, 10 Jan 2002 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289716AbSAJVtX>; Thu, 10 Jan 2002 16:49:23 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:31141 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289706AbSAJVsu>; Thu, 10 Jan 2002 16:48:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Briging doesn't compile without TCP/IP Networking
Date: Thu, 10 Jan 2002 22:50:45 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16On3u-1zr9mqC@fwd05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I accidently destroyed the Kernel of my self made bridge (old 486 / 4 PCI 
nics).
When i tried to compile an new one (2.4.17) I've got a compile error in
include/net/tcp_ecn.h

Is this patch suitable or could you tell me why unix sokets
and others need tcp.h ? 

MfG, Christian Koenig.

diff -Nurb linux-2.4.17.orig/include/net/tcp_ecn.h 
linux-2.4.17/include/net/tcp_ecn.h
--- linux-2.4.17.orig/include/net/tcp_ecn.h	Sat Nov  3 02:43:26 2001
+++ linux-2.4.17/include/net/tcp_ecn.h	Thu Jan 10 22:28:26 2002
@@ -44,6 +44,8 @@
 		th->ece = 1;
 }

+#ifdef CONFIG_INET
+
 static __inline__ void
 TCP_ECN_send(struct sock *sk, struct tcp_opt *tp, struct sk_buff *skb, int 
tcp_header_len)
 {
@@ -64,6 +66,8 @@
 			skb->h.th->ece = 1;
 	}
 }
+
+#endif //CONFIG_INET

 /* Input functions */

