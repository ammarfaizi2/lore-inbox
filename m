Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319729AbSIMSIK>; Fri, 13 Sep 2002 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319736AbSIMSIK>; Fri, 13 Sep 2002 14:08:10 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:26385 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S319729AbSIMSII>; Fri, 13 Sep 2002 14:08:08 -0400
Subject: [PATCH] 2.4.20-pre7 Configure.help cleanup
From: Steven Cole <elenstev@mesatop.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 13 Sep 2002 12:09:47 -0600
Message-Id: <1031940589.2288.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes three unneeded help texts left over
from when ESR was trying to maintain one Configure.help
file for both the 2.4 and 2.5 trees.  These three options do
not exist in the 2.4 tree and appear to have been removed
from the 2.5 tree as well.  The three removed options are:

CONFIG_IPV6_NETLINK
CONFIG_NETLINK
CONFIG_RTNETLINK

This patch also removes two extra help texts for these two:

CONFIG_IA64_SGI_SN_SIM
CONFIG_IA64_SGI_SN_DEBUG

Other help texts for those two options exist elsewhere in
the Configure.help file.  According to Keith Owens, the removed
texts are the ones which are wrong.

Marcelo, please apply.

Steven

--- linux-2.4.20-pre7/Documentation/Configure.help.orig	Thu Sep 12 21:56:57 2002
+++ linux-2.4.20-pre7/Documentation/Configure.help	Thu Sep 12 22:07:24 2002
@@ -5557,14 +5557,6 @@
 
   It is safe to say N here for now.
 
-# 2.5 tree only
-IPv6: routing messages via old netlink
-CONFIG_IPV6_NETLINK
-  You can say Y here to receive routing messages from the IPv6 code
-  through the old netlink interface. However, a better option is to
-  say Y to "Kernel/User network link driver" and to "Routing
-  messages" instead.
-
 Kernel httpd acceleration
 CONFIG_KHTTPD
   The kernel httpd acceleration daemon (kHTTPd) is a (limited) web
@@ -6325,34 +6317,6 @@
 
   If unsure, say N.
 
-# 2.5 tree only
-Kernel/User network link driver
-CONFIG_NETLINK
-  This driver allows for two-way communication between the kernel and
-  user processes.  It does so by creating a new socket family,
-  PF_NETLINK.  Over this socket, the kernel can send and receive
-  datagrams carrying information.  It is documented on many systems in
-  netlink(7).
-
-  So far, the kernel uses this feature to publish some network related
-  information if you say Y to "Routing messages", below. You also need
-  to say Y here if you want to use arpd, a daemon that helps keep the
-  internal ARP cache (a mapping between IP addresses and hardware
-  addresses on the local network) small.  The ethertap device, which
-  lets user space programs read and write raw Ethernet frames, also
-  needs the network link driver.
-
-  If unsure, say Y.
-
-# 2.5 tree only
-Routing messages
-CONFIG_RTNETLINK
-  If you say Y here, user space programs can receive some network
-  related routing information over the netlink. 'rtmon', supplied
-  with the iproute2 package (<ftp://ftp.inr.ac.ru/>), can read and
-  interpret this data.  Information sent to the kernel over this link
-  is ignored.
-
 Netlink device emulation
 CONFIG_NETLINK_DEV
   This option will be removed soon. Any programs that want to use
@@ -20210,7 +20174,6 @@
   Enable this if you like to use ISDN in US on a NI1 basic rate
   interface.
 
-# 2.4 tree only
 Maximum number of cards supported by HiSax
 CONFIG_HISAX_MAX_CARDS
   This is used to allocate a driver-internal structure array with one
@@ -25030,16 +24993,6 @@
                  system.
 
   If you don't know what to do, choose "generic".
-
-CONFIG_IA64_SGI_SN_SIM
-  Build a kernel that runs on both the SGI simulator AND on hardware.
-  There is a very slight performance penalty on hardware for including this
-  option.
-
-CONFIG_IA64_SGI_SN_DEBUG
-  This enables addition debug code that helps isolate
-  platform/kernel bugs. There is a small but measurable performance
-  degradation when this option is enabled.
 
 # Choice: pagesize
 Kernel page size



