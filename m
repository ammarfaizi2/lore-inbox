Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVG2ROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVG2ROO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVG2RMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:12:19 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:25481 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262620AbVG2RLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:11:23 -0400
Date: Fri, 29 Jul 2005 19:11:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/4] s390: default configuration.
Message-ID: <20050729171122.GA5663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Update default configuration of s390.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig |  253 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 142 insertions(+), 111 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-07-29 18:43:05.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2005-07-29 18:43:37.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc3
-# Fri Apr 22 15:30:58 2005
+# Linux kernel version: 2.6.13-rc4
+# Fri Jul 29 14:49:30 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -23,10 +23,11 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
-# CONFIG_AUDIT is not set
+CONFIG_AUDIT=y
+# CONFIG_AUDITSYSCALL is not set
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
@@ -36,6 +37,8 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -51,9 +54,10 @@ CONFIG_BASE_SMALL=0
 # Loadable module support
 #
 CONFIG_MODULES=y
-# CONFIG_MODULE_UNLOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
+CONFIG_MODVERSIONS=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
@@ -81,8 +85,15 @@ CONFIG_MARCH_G5=y
 # CONFIG_MARCH_Z990 is not set
 CONFIG_PACK_STACK=y
 # CONFIG_SMALL_STACK is not set
-# CONFIG_CHECK_STACK is not set
+CONFIG_CHECK_STACK=y
+CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
 
 #
 # I/O subsystem configuration
@@ -95,7 +106,7 @@ CONFIG_QDIO=y
 #
 # Misc
 #
-# CONFIG_PREEMPT is not set
+CONFIG_PREEMPT=y
 CONFIG_IPL=y
 # CONFIG_IPL_TAPE is not set
 CONFIG_IPL_VM=y
@@ -105,9 +116,110 @@ CONFIG_BINFMT_MISC=m
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_CMM is not set
-# CONFIG_VIRT_TIMER is not set
+CONFIG_VIRT_TIMER=y
+CONFIG_VIRT_CPU_ACCOUNTING=y
+# CONFIG_APPLDATA_BASE is not set
 CONFIG_NO_IDLE_HZ=y
 CONFIG_NO_IDLE_HZ_INIT=y
+# CONFIG_KEXEC is not set
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+CONFIG_IP_TCPDIAG_IPV6=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CLK_JIFFIES=y
+# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
+# CONFIG_NET_SCH_CLK_CPU is not set
+CONFIG_NET_SCH_CBQ=m
+# CONFIG_NET_SCH_HTB is not set
+# CONFIG_NET_SCH_HFSC is not set
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+# CONFIG_NET_SCH_NETEM is not set
+# CONFIG_NET_SCH_INGRESS is not set
+CONFIG_NET_QOS=y
+CONFIG_NET_ESTIMATOR=y
+CONFIG_NET_CLS=y
+# CONFIG_NET_CLS_BASIC is not set
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_ROUTE=y
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+# CONFIG_CLS_U32_PERF is not set
+# CONFIG_NET_CLS_IND is not set
+CONFIG_NET_CLS_RSVP=m
+CONFIG_NET_CLS_RSVP6=m
+# CONFIG_NET_EMATCH is not set
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_CLS_POLICE=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
 # CONFIG_PCMCIA is not set
 
 #
@@ -133,6 +245,7 @@ CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
 
 #
 # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
@@ -205,7 +318,13 @@ CONFIG_MD_RAID5=m
 # CONFIG_MD_RAID6 is not set
 CONFIG_MD_MULTIPATH=m
 # CONFIG_MD_FAULTY is not set
-# CONFIG_BLK_DEV_DM is not set
+CONFIG_BLK_DEV_DM=y
+CONFIG_DM_CRYPT=y
+CONFIG_DM_SNAPSHOT=y
+CONFIG_DM_MIRROR=y
+CONFIG_DM_ZERO=y
+CONFIG_DM_MULTIPATH=y
+# CONFIG_DM_MULTIPATH_EMC is not set
 
 #
 # Character device drivers
@@ -231,7 +350,8 @@ CONFIG_CCW_CONSOLE=y
 CONFIG_SCLP=y
 CONFIG_SCLP_TTY=y
 CONFIG_SCLP_CONSOLE=y
-# CONFIG_SCLP_VT220_TTY is not set
+CONFIG_SCLP_VT220_TTY=y
+CONFIG_SCLP_VT220_CONSOLE=y
 CONFIG_SCLP_CPI=m
 CONFIG_S390_TAPE=m
 
@@ -255,105 +375,8 @@ CONFIG_S390_TAPE_34XX=m
 CONFIG_Z90CRYPT=m
 
 #
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-CONFIG_UNIX=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-# CONFIG_IP_PNP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-CONFIG_IP_TCPDIAG_IPV6=y
-CONFIG_IPV6=y
-# CONFIG_IPV6_PRIVACY is not set
-# CONFIG_INET6_AH is not set
-# CONFIG_INET6_ESP is not set
-# CONFIG_INET6_IPCOMP is not set
-# CONFIG_INET6_TUNNEL is not set
-# CONFIG_IPV6_TUNNEL is not set
-# CONFIG_NETFILTER is not set
-CONFIG_XFRM=y
-# CONFIG_XFRM_USER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-CONFIG_NET_SCHED=y
-CONFIG_NET_SCH_CLK_JIFFIES=y
-# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
-# CONFIG_NET_SCH_CLK_CPU is not set
-CONFIG_NET_SCH_CBQ=m
-# CONFIG_NET_SCH_HTB is not set
-# CONFIG_NET_SCH_HFSC is not set
-CONFIG_NET_SCH_PRIO=m
-CONFIG_NET_SCH_RED=m
-CONFIG_NET_SCH_SFQ=m
-CONFIG_NET_SCH_TEQL=m
-CONFIG_NET_SCH_TBF=m
-CONFIG_NET_SCH_GRED=m
-CONFIG_NET_SCH_DSMARK=m
-# CONFIG_NET_SCH_NETEM is not set
-# CONFIG_NET_SCH_INGRESS is not set
-CONFIG_NET_QOS=y
-CONFIG_NET_ESTIMATOR=y
-CONFIG_NET_CLS=y
-# CONFIG_NET_CLS_BASIC is not set
-CONFIG_NET_CLS_TCINDEX=m
-CONFIG_NET_CLS_ROUTE4=m
-CONFIG_NET_CLS_ROUTE=y
-CONFIG_NET_CLS_FW=m
-CONFIG_NET_CLS_U32=m
-# CONFIG_CLS_U32_PERF is not set
-# CONFIG_NET_CLS_IND is not set
-CONFIG_NET_CLS_RSVP=m
-CONFIG_NET_CLS_RSVP6=m
-# CONFIG_NET_EMATCH is not set
-# CONFIG_NET_CLS_ACT is not set
-CONFIG_NET_CLS_POLICE=y
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
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
@@ -411,12 +434,15 @@ CONFIG_CCWGROUP=y
 # CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
@@ -426,6 +452,7 @@ CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 
 #
 # XFS support
@@ -433,6 +460,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -457,7 +485,6 @@ CONFIG_DNOTIFY=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_XATTR is not set
@@ -486,15 +513,18 @@ CONFIG_RAMFS=y
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
 # CONFIG_NFSD_V4 is not set
 CONFIG_NFSD_TCP=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -544,11 +574,12 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 
 #
 # Security options
