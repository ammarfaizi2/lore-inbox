Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbVIBGOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVIBGOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbVIBGN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:13:58 -0400
Received: from mgate01.necel.com ([203.180.232.81]:26299 "EHLO
	mgate01.necel.com") by vger.kernel.org with ESMTP id S1030310AbVIBGN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:13:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Update defconfigs
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20050902061330.839C549B@dhapc248.dev.necel.com>
Date: Fri,  2 Sep 2005 15:13:30 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/configs/rte-ma1-cb_defconfig |  108 ++++++++++++++++++---------------
 arch/v850/configs/rte-me2-cb_defconfig |   21 ++++--
 arch/v850/configs/sim_defconfig        |   21 ++++--
 3 files changed, 90 insertions(+), 60 deletions(-)

diff -ruN -X../cludes linux-2.6.13-uc0/arch/v850/configs/rte-ma1-cb_defconfig linux-2.6.13-uc0-v850-20050902/arch/v850/configs/rte-ma1-cb_defconfig
--- linux-2.6.13-uc0/arch/v850/configs/rte-ma1-cb_defconfig	2005-09-02 14:11:32.000000000 +0900
+++ linux-2.6.13-uc0-v850-20050902/arch/v850/configs/rte-ma1-cb_defconfig	2005-09-02 13:56:07.650149000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-uc0
-# Thu Jul 21 11:08:27 2005
+# Linux kernel version: 2.6.13-uc0
+# Fri Sep  2 13:54:27 2005
 #
 # CONFIG_MMU is not set
 # CONFIG_UID16 is not set
@@ -44,6 +44,8 @@
 # CONFIG_V850E_HIGHRES_TIMER is not set
 # CONFIG_RESET_GUARD is not set
 CONFIG_LARGE_ALLOCS=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
 
 #
 # Code maturity level options
@@ -111,6 +113,52 @@
 # CONFIG_BINFMT_MISC is not set
 
 #
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+# CONFIG_UNIX is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_IP_TCPDIAG is not set
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+
+#
 # Generic Driver Options
 #
 CONFIG_STANDALONE=y
@@ -158,6 +206,7 @@
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
@@ -232,6 +281,7 @@
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -244,53 +294,8 @@
 # CONFIG_I2O is not set
 
 #
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-# CONFIG_PACKET is not set
-# CONFIG_UNIX is not set
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
-# CONFIG_IP_ADVANCED_ROUTER is not set
-# CONFIG_IP_PNP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-# CONFIG_IP_TCPDIAG is not set
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
-
-#
-# Network testing
+# Network device support
 #
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -372,6 +377,8 @@
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -472,6 +479,7 @@
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 
 #
 # XFS support
@@ -479,6 +487,8 @@
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
+# CONFIG_MAGIC_ROM_PTR is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -524,9 +534,11 @@
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
diff -ruN -X../cludes linux-2.6.13-uc0/arch/v850/configs/rte-me2-cb_defconfig linux-2.6.13-uc0-v850-20050902/arch/v850/configs/rte-me2-cb_defconfig
--- linux-2.6.13-uc0/arch/v850/configs/rte-me2-cb_defconfig	2005-09-02 14:12:56.000000000 +0900
+++ linux-2.6.13-uc0-v850-20050902/arch/v850/configs/rte-me2-cb_defconfig	2005-09-02 13:55:57.760206000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-uc0
-# Thu Jul 21 11:30:08 2005
+# Linux kernel version: 2.6.13-uc0
+# Fri Sep  2 13:47:50 2005
 #
 # CONFIG_MMU is not set
 # CONFIG_UID16 is not set
@@ -41,6 +41,8 @@
 # CONFIG_V850E_HIGHRES_TIMER is not set
 # CONFIG_RESET_GUARD is not set
 CONFIG_LARGE_ALLOCS=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
 
 #
 # Code maturity level options
@@ -56,7 +58,6 @@
 CONFIG_LOCALVERSION=""
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
-# CONFIG_AUDIT is not set
 # CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
@@ -104,6 +105,11 @@
 # CONFIG_BINFMT_MISC is not set
 
 #
+# Networking
+#
+# CONFIG_NET is not set
+
+#
 # Generic Driver Options
 #
 CONFIG_STANDALONE=y
@@ -151,6 +157,7 @@
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
@@ -218,6 +225,7 @@
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -228,9 +236,8 @@
 #
 
 #
-# Networking support
+# Network device support
 #
-# CONFIG_NET is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 
@@ -311,7 +318,6 @@
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -335,6 +341,7 @@
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 
 #
 # XFS support
@@ -342,6 +349,8 @@
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
+# CONFIG_MAGIC_ROM_PTR is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
diff -ruN -X../cludes linux-2.6.13-uc0/arch/v850/configs/sim_defconfig linux-2.6.13-uc0-v850-20050902/arch/v850/configs/sim_defconfig
--- linux-2.6.13-uc0/arch/v850/configs/sim_defconfig	2005-09-02 14:12:15.000000000 +0900
+++ linux-2.6.13-uc0-v850-20050902/arch/v850/configs/sim_defconfig	2005-09-02 13:55:44.650302000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-uc0
-# Thu Jul 21 11:29:27 2005
+# Linux kernel version: 2.6.13-uc0
+# Fri Sep  2 13:36:43 2005
 #
 # CONFIG_MMU is not set
 # CONFIG_UID16 is not set
@@ -36,6 +36,8 @@
 CONFIG_ZERO_BSS=y
 # CONFIG_RESET_GUARD is not set
 CONFIG_LARGE_ALLOCS=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
 
 #
 # Code maturity level options
@@ -51,7 +53,6 @@
 CONFIG_LOCALVERSION=""
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
-# CONFIG_AUDIT is not set
 # CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
@@ -99,6 +100,11 @@
 # CONFIG_BINFMT_MISC is not set
 
 #
+# Networking
+#
+# CONFIG_NET is not set
+
+#
 # Generic Driver Options
 #
 CONFIG_STANDALONE=y
@@ -146,6 +152,7 @@
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
@@ -213,6 +220,7 @@
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -223,9 +231,8 @@
 #
 
 #
-# Networking support
+# Network device support
 #
-# CONFIG_NET is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 
@@ -300,7 +307,6 @@
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -324,6 +330,7 @@
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 
 #
 # XFS support
@@ -331,6 +338,8 @@
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
+# CONFIG_MAGIC_ROM_PTR is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
