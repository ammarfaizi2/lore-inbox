Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbSKMB6V>; Tue, 12 Nov 2002 20:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSKMB6V>; Tue, 12 Nov 2002 20:58:21 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:37904
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267098AbSKMB6V>; Tue, 12 Nov 2002 20:58:21 -0500
Date: Tue, 12 Nov 2002 20:59:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH][2.5] init_timer for mcast.c/mca_timer
Message-ID: <Pine.LNX.4.44.0211122056360.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.47/net/ipv6/mcast.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/net/ipv6/mcast.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mcast.c
--- linux-2.5.47/net/ipv6/mcast.c	11 Nov 2002 03:59:07 -0000	1.1.1.1
+++ linux-2.5.47/net/ipv6/mcast.c	12 Nov 2002 23:22:44 -0000
@@ -298,6 +298,7 @@
 	memset(mc, 0, sizeof(struct ifmcaddr6));
 	mc->mca_timer.function = igmp6_timer_handler;
 	mc->mca_timer.data = (unsigned long) mc;
+	init_timer(&mc->mca_timer);
 
 	memcpy(&mc->mca_addr, addr, sizeof(struct in6_addr));
 	mc->idev = idev;

-- 
function.linuxpower.ca

