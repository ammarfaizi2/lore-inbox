Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbSJMU0e>; Sun, 13 Oct 2002 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJMU0e>; Sun, 13 Oct 2002 16:26:34 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:11787 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261731AbSJMU0d>; Sun, 13 Oct 2002 16:26:33 -0400
Date: Sun, 13 Oct 2002 21:32:24 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] af_inet.c comment
Message-ID: <20021013203224.GA97806@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


inet_init() is module_init()ed not called directly from socket.c

against 2.5.42

regards
john


--- linux-linus/net/ipv4/af_inet.c	Sat Oct 12 16:54:50 2002
+++ linux/net/ipv4/af_inet.c	Sun Oct 13 21:28:54 2002
@@ -1113,10 +1113,6 @@
 	.handler =	icmp_rcv,
 };
 
-/*
- *	Called by socket.c on kernel startup.  
- */
-
 static int __init inet_init(void)
 {
 	struct sk_buff *dummy_skb;
