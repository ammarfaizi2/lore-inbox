Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTAHCSR>; Tue, 7 Jan 2003 21:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267667AbTAHCSR>; Tue, 7 Jan 2003 21:18:17 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:26152 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S267658AbTAHCSQ>; Tue, 7 Jan 2003 21:18:16 -0500
Date: Wed, 8 Jan 2003 13:23:56 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4] DHCP-client-related options in Configure.help
In-Reply-To: <Pine.LNX.4.05.10301081312150.2087-100000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.05.10301081322100.2087-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Appended patch against 2.4.21-pre2 updates
Documentation/Configure.help re options which are required to support
DHCP client.

Thanks,
Neale.

--- linux-2.4.21-pre2/Documentation/Configure.help	Wed Jan  8 12:02:26 2003
+++ linux-2.4.21-pre2-ntb/Documentation/Configure.help	Wed Jan  8 12:08:33 2003
@@ -2446,7 +2446,9 @@
   information.
 
   You need to say Y here if you want to use PPP packet filtering
-  (see the CONFIG_PPP_FILTER option below).
+  (see the CONFIG_PPP_FILTER option below) or if the host may be using
+  DHCP to configure its own address (the DHCP client requires this and
+  'Packet socket').
 
   If unsure, say N.
 
@@ -6382,6 +6384,9 @@
   directly with network devices without an intermediate network
   protocol implemented in the kernel, e.g. tcpdump.  If you want them
   to work, choose Y.
+
+  Note that DHCP client requires this and 'Socket filtering', so if
+  you want DHCP client to work, choose Y.
 
   This driver is also available as a module called af_packet.o ( =
   code which can be inserted in and removed from the running kernel

