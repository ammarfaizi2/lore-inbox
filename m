Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132419AbRDJQaR>; Tue, 10 Apr 2001 12:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRDJQaP>; Tue, 10 Apr 2001 12:30:15 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:36112 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132419AbRDJQaF>;
	Tue, 10 Apr 2001 12:30:05 -0400
Date: Tue, 10 Apr 2001 12:31:02 -0400
Message-Id: <200104101631.f3AGV2U32046@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: torvalds@transmeta.com, axel@uni-paderborn.de,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Documentation/Configure.help garbage collection, part 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes duplicate help entries.

--- Configure.help	2001/04/10 16:21:18	1.2
+++ Configure.help	2001/04/10 16:26:57
@@ -2074,15 +2074,6 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
-Packet filtering
-CONFIG_IP6_NF_FILTER
-  Packet filtering defines a table `filter', which has a series of
-  rules for simple packet filtering at local input, forwarding and
-  local output.  See the man page for iptables(8).
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
 Packet mangling
 CONFIG_IP6_NF_MANGLE
   This option adds a `mangle' table to iptables: see the man page for
@@ -2122,42 +2113,6 @@
 
   If in doubt, say N.
 
-IP6 tables support (required for filtering/masq/NAT)
-CONFIG_IP6_NF_IPTABLES
-  ip6tables is a general, extensible packet identification framework.
-  Currently only the packet filtering and packet mangling subsystem
-  for IPv6 use this, but connection tracking is going to follow.
-  Say 'Y' or 'M' here if you want to use either of those.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
-IPv6 limit match support
-CONFIG_IP6_NF_MATCH_LIMIT
-  limit matching allows you to control the rate at which a rule can be
-  matched: mainly useful in combination with the LOG target ("LOG
-  target support", below) and to avoid some Denial of Service attacks.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
-MAC address match support
-CONFIG_IP6_NF_MATCH_MAC
-  mac matching allows you to match packets based on the source
-  ethernet address of the packet.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
-netfilter mark match support
-CONFIG_IP6_NF_MATCH_MARK
-  Netfilter mark matching allows you to match packets based on the
-  `nfmark' value in the packet.  This can be set by the MARK target
-  (see below).
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
 Packet filtering
 CONFIG_IP6_NF_FILTER
   Packet filtering defines a table `filter', which has a series of
@@ -2167,27 +2122,6 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
-Packet mangling
-CONFIG_IP6_NF_MANGLE
-  This option adds a `mangle' table to iptables: see the man page for
-  iptables(8).  This table is used for various packet alterations
-  which can effect how the packet is routed.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
-MARK target support
-CONFIG_IP6_NF_TARGET_MARK
-  This option adds a `MARK' target, which allows you to create rules
-  in the `mangle' table which alter the netfilter mark (nfmark) field
-  associated with the packet packet prior to routing. This can change
-  the routing method (see `IP: use netfilter MARK value as routing
-  key') and can also be used by other subsystems to change their
-  behavior.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
 SYN flood protection
 CONFIG_SYN_COOKIES
   Normal TCP/IP networking is open to an attack known as "SYN
@@ -16436,27 +16370,6 @@
   SA-1100 based Victor Digital Talking Book Reader.  See
   http://www.visuaide.com/pagevictor.en.html for information on
   this system.
-
-Support ARM610 processor
-CONFIG_CPU_ARM6
-  Say Y here if you wish to include support for the ARM610 processor.
-
-Support ARM710 processor
-CONFIG_CPU_ARM7
-  Say Y here if you wish to include support for the ARM710 processor.
-
-Support StrongARM(R) SA-110 processor
-CONFIG_CPU_SA110
-  Say Y here if you wish to include support for the Intel(R)
-  StrongARM(R) SA-110 processor.
-
-Support ARM720 processor
-CONFIG_CPU_ARM720
-  Say Y here if you wish to include support for the ARM720 processor.
-
-Support ARM920
-CONFIG_CPU_ARM920
-  Say Y here if you wish to include support for the ARM920 processor.
 
 Support ARM610 processor
 CONFIG_CPU_ARM6

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A man with a gun is a citizen.  A man without a gun is a subject.
