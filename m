Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTDIAVr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTDIAVr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:21:47 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:2795 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262652AbTDIAVo (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:21:44 -0400
Date: Tue, 8 Apr 2003 20:29:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.67] more aesthetics to fix menu awkwardness
Message-ID: <Pine.LNX.4.44.0304082028180.18784-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Nru bk1/net/ipv4/netfilter/Kconfig rday-bk1/net/ipv4/netfilter/Kconfig
--- bk1/net/ipv4/netfilter/Kconfig	2003-04-07 13:32:26.000000000 -0400
+++ rday-bk1/net/ipv4/netfilter/Kconfig	2003-04-08 20:24:03.000000000 -0400
@@ -73,16 +73,6 @@
 	  If you want to compile it as a module, say M here and read
 	  <file:Documentation/modules.txt>.  If unsure, say `Y'.
 
-config IP_NF_QUEUE
-	tristate "Userspace queueing via NETLINK (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  Netfilter has the ability to queue packets to user space: the
-	  netlink device can be used to access them using this driver.
-
-	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.  If unsure, say `N'.
-
 config IP_NF_IPTABLES
 	tristate "IP tables support (required for filtering/masq/NAT)"
 	help
@@ -332,11 +322,6 @@
 	  If you want to compile it as a module, say M here and read
 	  <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-config IP_NF_NAT_NEEDED
-	bool
-	depends on IP_NF_CONNTRACK!=y && IP_NF_IPTABLES!=y && (IP_NF_COMPAT_IPCHAINS!=y && IP_NF_COMPAT_IPFWADM || IP_NF_COMPAT_IPCHAINS) || IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
-	default y
-
 config IP_NF_TARGET_MASQUERADE
 	tristate "MASQUERADE target support"
 	depends on IP_NF_NAT
@@ -418,6 +403,11 @@
 	default IP_NF_NAT if IP_NF_AMANDA=y
 	default m if IP_NF_AMANDA=m
 
+config IP_NF_NAT_NEEDED
+	bool
+	depends on IP_NF_CONNTRACK!=y && IP_NF_IPTABLES!=y && (IP_NF_COMPAT_IPCHAINS!=y && IP_NF_COMPAT_IPFWADM || IP_NF_COMPAT_IPCHAINS) || IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
+	default y
+
 config IP_NF_MANGLE
 	tristate "Packet mangling"
 	depends on IP_NF_IPTABLES
@@ -533,6 +523,16 @@
 	  If you want to compile it as a module, say M here and read
 	  <file:Documentation/modules.txt>.  If unsure, say `N'.
 
+config IP_NF_QUEUE
+	tristate "Userspace queueing via NETLINK (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Netfilter has the ability to queue packets to user space: the
+	  netlink device can be used to access them using this driver.
+
+	  If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.  If unsure, say `N'.
+
 config IP_NF_ARPTABLES
 	tristate "ARP tables support"
 

