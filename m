Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbTAHCPz>; Tue, 7 Jan 2003 21:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267658AbTAHCPz>; Tue, 7 Jan 2003 21:15:55 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:24872 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S267654AbTAHCPy>; Tue, 7 Jan 2003 21:15:54 -0500
Date: Wed, 8 Jan 2003 13:20:43 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.2] DHCP-client-related options in Configure.help
In-Reply-To: <Pine.LNX.4.05.10301081312150.2087-100000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.05.10301081318420.2087-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Appended patch against 2.2.24-rc1 updates Documentation/Configure.help
re options which are required to support DHCP client.

Thanks,
Neale.

--- linux-2.2.24-rc1/Documentation/Configure.help	Sat Nov 30 05:05:55 2002
+++ linux-2.2.24-rc1-ntb0/Documentation/Configure.help	Sat Dec 21 19:02:23 2002
@@ -1364,7 +1364,9 @@
   certain types of data to get through the socket. Linux Socket
   Filtering works on all socket types except TCP for now. See the text
   file linux/Documentation/networking/filter.txt for more information.
-  If unsure, say N.
+  If unsure, say N unless the host may be using DHCP to configure its
+  own address (the DHCP client requires this and 'Packet socket') - in
+  that case say Y.
 
 Network firewalls
 CONFIG_FIREWALL
@@ -4152,6 +4154,7 @@
   module, say M here and read Documentation/modules.txt.  You will
   need to add 'alias net-pf-17 af_packet' to your /etc/conf.modules
   file for the module version to function automatically.  If unsure, say Y.
+  Note that DHCP client requires this and 'Socket filtering'.
 
 Kernel/User network link driver
 CONFIG_NETLINK

