Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSGVK5D>; Mon, 22 Jul 2002 06:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGVK5C>; Mon, 22 Jul 2002 06:57:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29448 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316715AbSGVKzr>; Mon, 22 Jul 2002 06:55:47 -0400
Message-ID: <3D3BE421.3040800@evision.ag>
Date: Mon, 22 Jul 2002 12:53:21 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 enum
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080408010001090706050900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408010001090706050900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix a bunch of places where there are trailing "," at the
   end of enum declarations.

--------------080408010001090706050900
Content-Type: text/plain;
 name="enum-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="enum-2.5.27.diff"

diff -urN linux-2.5.27/arch/i386/kernel/cpu/centaur.c linux/arch/i386/kernel/cpu/centaur.c
--- linux-2.5.27/arch/i386/kernel/cpu/centaur.c	2002-07-20 21:11:07.000000000 +0200
+++ linux/arch/i386/kernel/cpu/centaur.c	2002-07-21 19:30:42.000000000 +0200
@@ -267,7 +267,7 @@
 		DNA=1<<15,
 		ERETSTK=1<<16,
 		E2MMX=1<<19,
-		EAMD3D=1<<20,
+		EAMD3D=1<<20
 	};
 
 	char *name;
diff -urN linux-2.5.27/arch/i386/kernel/mtrr.c linux/arch/i386/kernel/mtrr.c
--- linux-2.5.27/arch/i386/kernel/mtrr.c	2002-07-20 21:11:06.000000000 +0200
+++ linux/arch/i386/kernel/mtrr.c	2002-07-21 19:30:42.000000000 +0200
@@ -299,7 +299,7 @@
     MTRR_IF_INTEL,		/* Intel (P6) standard MTRRs */
     MTRR_IF_AMD_K6,		/* AMD pre-Athlon MTRRs */
     MTRR_IF_CYRIX_ARR,		/* Cyrix ARRs */
-    MTRR_IF_CENTAUR_MCR,	/* Centaur MCRs */
+    MTRR_IF_CENTAUR_MCR		/* Centaur MCRs */
 } mtrr_if = MTRR_IF_NONE;
 
 static __initdata char *mtrr_if_name[] = {
diff -urN linux-2.5.27/fs/proc/base.c linux/fs/proc/base.c
--- linux-2.5.27/fs/proc/base.c	2002-07-20 21:11:07.000000000 +0200
+++ linux/fs/proc/base.c	2002-07-21 19:30:43.000000000 +0200
@@ -54,7 +54,7 @@
 	PROC_PID_MAPS,
 	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
-	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
+	PROC_PID_FD_DIR = 0x8000	/* 0x8000-0xffff */
 };
 
 struct pid_entry {
diff -urN linux-2.5.27/include/linux/backing-dev.h linux/include/linux/backing-dev.h
--- linux-2.5.27/include/linux/backing-dev.h	2002-07-20 21:11:12.000000000 +0200
+++ linux/include/linux/backing-dev.h	2002-07-21 19:30:43.000000000 +0200
@@ -13,7 +13,7 @@
  */
 enum bdi_state {
 	BDI_pdflush,		/* A pdflush thread is working this device */
-	BDI_unused,		/* Available bits start here */
+	BDI_unused		/* Available bits start here */
 };
 
 struct backing_dev_info {
diff -urN linux-2.5.27/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.27/include/linux/blkdev.h	2002-07-20 21:11:11.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-07-21 19:30:43.000000000 +0200
@@ -87,7 +87,7 @@
 
 	__REQ_SPECIAL,	/* driver suplied command */
 
-	__REQ_NR_BITS,	/* stops here */
+	__REQ_NR_BITS	/* stops here */
 };
 
 #define REQ_RW		(1 << __REQ_RW)
@@ -117,7 +117,7 @@
 
 enum blk_queue_state {
 	Queue_down,
-	Queue_up,
+	Queue_up
 };
 
 #define BLK_TAGS_PER_LONG	(sizeof(unsigned long) * 8)
diff -urN linux-2.5.27/include/linux/buffer_head.h linux/include/linux/buffer_head.h
--- linux-2.5.27/include/linux/buffer_head.h	2002-07-20 21:11:06.000000000 +0200
+++ linux/include/linux/buffer_head.h	2002-07-21 19:30:43.000000000 +0200
@@ -24,7 +24,7 @@
 	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
 
 	BH_Boundary,	/* Block is followed by a discontiguity */
-	BH_PrivateStart,/* not a state bit, but the first bit available
+	BH_PrivateStart /* not a state bit, but the first bit available
 			 * for private allocation by other entities
 			 */
 };
diff -urN linux-2.5.27/include/linux/device.h linux/include/linux/device.h
--- linux-2.5.27/include/linux/device.h	2002-07-20 21:11:13.000000000 +0200
+++ linux/include/linux/device.h	2002-07-21 19:30:43.000000000 +0200
@@ -39,13 +39,13 @@
 	SUSPEND_NOTIFY,
 	SUSPEND_SAVE_STATE,
 	SUSPEND_DISABLE,
-	SUSPEND_POWER_DOWN,
+	SUSPEND_POWER_DOWN
 };
 
 enum {
 	RESUME_POWER_ON,
 	RESUME_RESTORE_STATE,
-	RESUME_ENABLE,
+	RESUME_ENABLE
 };
 
 struct device;
diff -urN linux-2.5.27/include/linux/genhd.h linux/include/linux/genhd.h
--- linux-2.5.27/include/linux/genhd.h	2002-07-20 21:11:09.000000000 +0200
+++ linux/include/linux/genhd.h	2002-07-21 22:15:00.000000000 +0200
@@ -38,7 +38,7 @@
 /* Ours is not to wonder why.. */
 	BSD_PARTITION =	FREEBSD_PARTITION,
 	MINIX_PARTITION = 0x81,  /* Minix Partition ID */
-	UNIXWARE_PARTITION = 0x63,		/* Partition ID, same as */
+	UNIXWARE_PARTITION = 0x63		/* Partition ID, same as */
 						/* GNU_HURD and SCO Unix */
 };
 
diff -urN linux-2.5.27/include/linux/jbd.h linux/include/linux/jbd.h
--- linux-2.5.27/include/linux/jbd.h	2002-07-20 21:11:33.000000000 +0200
+++ linux/include/linux/jbd.h	2002-07-21 19:30:43.000000000 +0200
@@ -226,13 +226,12 @@
 #endif		/* JBD_ASSERTIONS */
 
 enum jbd_state_bits {
-	BH_JBD			/* Has an attached ext3 journal_head */
-	  = BH_PrivateStart,	
+	BH_JBD = BH_PrivateStart, /* Has an attached ext3 journal_head */
 	BH_JWrite,		/* Being written to log (@@@ DEBUGGING) */
 	BH_Freed,		/* Has been freed (truncated) */
 	BH_Revoked,		/* Has been revoked from the log */
 	BH_RevokeValid,		/* Revoked flag is valid */
-	BH_JBDDirty,		/* Is dirty but journaled */
+	BH_JBDDirty		/* Is dirty but journaled */
 };
 
 BUFFER_FNS(JBD, jbd)
diff -urN linux-2.5.27/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux-2.5.27/include/linux/netdevice.h	2002-07-20 21:12:22.000000000 +0200
+++ linux/include/linux/netdevice.h	2002-07-21 19:30:43.000000000 +0200
@@ -688,7 +688,7 @@
 	NETIF_MSG_INTR		= 0x0200,
 	NETIF_MSG_TX_DONE	= 0x0400,
 	NETIF_MSG_RX_STATUS	= 0x0800,
-	NETIF_MSG_PKTDATA	= 0x1000,
+	NETIF_MSG_PKTDATA	= 0x1000
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
diff -urN linux-2.5.27/include/linux/netfilter_ipv4.h linux/include/linux/netfilter_ipv4.h
--- linux-2.5.27/include/linux/netfilter_ipv4.h	2002-07-20 21:11:33.000000000 +0200
+++ linux/include/linux/netfilter_ipv4.h	2002-07-21 19:30:43.000000000 +0200
@@ -56,7 +56,7 @@
 	NF_IP_PRI_NAT_DST = -100,
 	NF_IP_PRI_FILTER = 0,
 	NF_IP_PRI_NAT_SRC = 100,
-	NF_IP_PRI_LAST = INT_MAX,
+	NF_IP_PRI_LAST = INT_MAX
 };
 
 /* Arguments for setsockopt SOL_IP: */
diff -urN linux-2.5.27/include/linux/personality.h linux/include/linux/personality.h
--- linux-2.5.27/include/linux/personality.h	2002-07-20 21:11:21.000000000 +0200
+++ linux/include/linux/personality.h	2002-07-21 19:30:43.000000000 +0200
@@ -33,7 +33,7 @@
 	ADDR_LIMIT_32BIT =	0x0800000,
 	SHORT_INODE =		0x1000000,
 	WHOLE_SECONDS =		0x2000000,
-	STICKY_TIMEOUTS	=	0x4000000,
+	STICKY_TIMEOUTS	=	0x4000000
 };
 
 /*
@@ -62,7 +62,7 @@
 	PER_RISCOS =		0x000c,
 	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
 	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
-	PER_MASK =		0x00ff,
+	PER_MASK =		0x00ff
 };
 
 
diff -urN linux-2.5.27/include/linux/pkt_cls.h linux/include/linux/pkt_cls.h
--- linux-2.5.27/include/linux/pkt_cls.h	2002-07-20 21:11:06.000000000 +0200
+++ linux/include/linux/pkt_cls.h	2002-07-21 19:30:43.000000000 +0200
@@ -48,7 +48,7 @@
 	TCA_U32_LINK,
 	TCA_U32_DIVISOR,
 	TCA_U32_SEL,
-	TCA_U32_POLICE,
+	TCA_U32_POLICE
 };
 
 #define TCA_U32_MAX TCA_U32_POLICE
@@ -96,7 +96,7 @@
 	TCA_RSVP_DST,
 	TCA_RSVP_SRC,
 	TCA_RSVP_PINFO,
-	TCA_RSVP_POLICE,
+	TCA_RSVP_POLICE
 };
 
 #define TCA_RSVP_MAX TCA_RSVP_POLICE
@@ -126,7 +126,7 @@
 	TCA_ROUTE4_TO,
 	TCA_ROUTE4_FROM,
 	TCA_ROUTE4_IIF,
-	TCA_ROUTE4_POLICE,
+	TCA_ROUTE4_POLICE
 };
 
 #define TCA_ROUTE4_MAX TCA_ROUTE4_POLICE
@@ -138,7 +138,7 @@
 {
 	TCA_FW_UNSPEC,
 	TCA_FW_CLASSID,
-	TCA_FW_POLICE,
+	TCA_FW_POLICE
 };
 
 #define TCA_FW_MAX TCA_FW_POLICE
@@ -153,7 +153,7 @@
 	TCA_TCINDEX_SHIFT,
 	TCA_TCINDEX_FALL_THROUGH,
 	TCA_TCINDEX_CLASSID,
-	TCA_TCINDEX_POLICE,
+	TCA_TCINDEX_POLICE
 };
 
 #define TCA_TCINDEX_MAX        TCA_TCINDEX_POLICE
diff -urN linux-2.5.27/include/linux/pkt_sched.h linux/include/linux/pkt_sched.h
--- linux-2.5.27/include/linux/pkt_sched.h	2002-07-20 21:11:29.000000000 +0200
+++ linux/include/linux/pkt_sched.h	2002-07-21 19:30:43.000000000 +0200
@@ -128,7 +128,7 @@
 	TCA_CSZ_UNSPEC,
 	TCA_CSZ_PARMS,
 	TCA_CSZ_RTAB,
-	TCA_CSZ_PTAB,
+	TCA_CSZ_PTAB
 };
 
 /* TBF section */
@@ -147,7 +147,7 @@
 	TCA_TBF_UNSPEC,
 	TCA_TBF_PARMS,
 	TCA_TBF_RTAB,
-	TCA_TBF_PTAB,
+	TCA_TBF_PTAB
 };
 
 
@@ -181,7 +181,7 @@
 {
 	TCA_RED_UNSPEC,
 	TCA_RED_PARMS,
-	TCA_RED_STAB,
+	TCA_RED_STAB
 };
 
 struct tc_red_qopt
@@ -213,7 +213,7 @@
        TCA_GRED_UNSPEC,
        TCA_GRED_PARMS,
        TCA_GRED_STAB,
-       TCA_GRED_DPS,
+       TCA_GRED_DPS
 };
 
 #define TCA_SET_OFF TCA_GRED_PARMS
@@ -327,7 +327,7 @@
 	TCA_CBQ_OVL_STRATEGY,
 	TCA_CBQ_RATE,
 	TCA_CBQ_RTAB,
-	TCA_CBQ_POLICE,
+	TCA_CBQ_POLICE
 };
 
 #define TCA_CBQ_MAX	TCA_CBQ_POLICE
diff -urN linux-2.5.27/include/linux/pm.h linux/include/linux/pm.h
--- linux-2.5.27/include/linux/pm.h	2002-07-20 21:11:24.000000000 +0200
+++ linux/include/linux/pm.h	2002-07-21 19:30:43.000000000 +0200
@@ -45,7 +45,7 @@
 
 	/* base station management */
 	PM_EJECT,
-	PM_LOCK,
+	PM_LOCK
 };
 
 typedef int pm_request_t;
@@ -61,7 +61,7 @@
 	PM_USB_DEV,	    /* USB device */
 	PM_SCSI_DEV,	    /* SCSI device */
 	PM_ISA_DEV,	    /* ISA device */
-	PM_MTD_DEV,	    /* Memory Technology Device */
+	PM_MTD_DEV	    /* Memory Technology Device */
 };
 
 typedef int pm_dev_t;
@@ -77,7 +77,7 @@
 	PM_SYS_IRDA =	 0x41d00510, /* IRDA controller */
 	PM_SYS_FDC =	 0x41d00700, /* floppy controller */
 	PM_SYS_VGA =	 0x41d00900, /* VGA controller */
-	PM_SYS_PCMCIA =	 0x41d00e00, /* PCMCIA controller */
+	PM_SYS_PCMCIA =	 0x41d00e00  /* PCMCIA controller */
 };
 
 /*
diff -urN linux-2.5.27/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linux-2.5.27/include/linux/proc_fs.h	2002-07-20 21:11:03.000000000 +0200
+++ linux/include/linux/proc_fs.h	2002-07-21 19:30:43.000000000 +0200
@@ -21,7 +21,7 @@
  */
 
 enum {
-	PROC_ROOT_INO = 1,
+	PROC_ROOT_INO = 1
 };
 
 /* Finally, the dynamically allocatable proc entries are reserved: */
diff -urN linux-2.5.27/include/linux/root_dev.h linux/include/linux/root_dev.h
--- linux-2.5.27/include/linux/root_dev.h	2002-07-20 21:11:11.000000000 +0200
+++ linux/include/linux/root_dev.h	2002-07-21 19:30:43.000000000 +0200
@@ -11,7 +11,7 @@
 	Root_SDA1 = MKDEV(SCSI_DISK0_MAJOR, 1),
 	Root_SDA2 = MKDEV(SCSI_DISK0_MAJOR, 2),
 	Root_HDC1 = MKDEV(IDE1_MAJOR, 1),
-	Root_SR0 = MKDEV(SCSI_CDROM_MAJOR, 0),
+	Root_SR0 = MKDEV(SCSI_CDROM_MAJOR, 0)
 };
 
 extern dev_t ROOT_DEV;
diff -urN linux-2.5.27/include/linux/rtnetlink.h linux/include/linux/rtnetlink.h
--- linux-2.5.27/include/linux/rtnetlink.h	2002-07-20 21:11:32.000000000 +0200
+++ linux/include/linux/rtnetlink.h	2002-07-21 19:30:43.000000000 +0200
@@ -112,7 +112,7 @@
 	RTN_PROHIBIT,		/* Administratively prohibited	*/
 	RTN_THROW,		/* Not in this table		*/
 	RTN_NAT,		/* Translate this address	*/
-	RTN_XRESOLVE,		/* Use external resolver	*/
+	RTN_XRESOLVE		/* Use external resolver	*/
 };
 
 #define RTN_MAX RTN_XRESOLVE
@@ -278,7 +278,7 @@
 #define RTAX_CWND RTAX_CWND
 	RTAX_ADVMSS,
 #define RTAX_ADVMSS RTAX_ADVMSS
-	RTAX_REORDERING,
+	RTAX_REORDERING
 #define RTAX_REORDERING RTAX_REORDERING
 };
 
@@ -442,7 +442,7 @@
 #define IFLA_PRIORITY IFLA_PRIORITY
 	IFLA_MASTER,
 #define IFLA_MASTER IFLA_MASTER
-	IFLA_WIRELESS,		/* Wireless Extension event - see wireless.h */
+	IFLA_WIRELESS		/* Wireless Extension event - see wireless.h */
 #define IFLA_WIRELESS IFLA_WIRELESS
 };
 
@@ -503,7 +503,7 @@
 	TCA_OPTIONS,
 	TCA_STATS,
 	TCA_XSTATS,
-	TCA_RATE,
+	TCA_RATE
 };
 
 #define TCA_MAX TCA_RATE
diff -urN linux-2.5.27/include/linux/sunrpc/debug.h linux/include/linux/sunrpc/debug.h
--- linux-2.5.27/include/linux/sunrpc/debug.h	2002-07-20 21:11:14.000000000 +0200
+++ linux/include/linux/sunrpc/debug.h	2002-07-21 19:30:43.000000000 +0200
@@ -89,7 +89,7 @@
 	CTL_RPCDEBUG = 1,
 	CTL_NFSDEBUG,
 	CTL_NFSDDEBUG,
-	CTL_NLMDEBUG,
+	CTL_NLMDEBUG
 };
 
 #endif /* _LINUX_SUNRPC_DEBUG_H_ */
diff -urN linux-2.5.27/include/linux/sunrpc/msg_prot.h linux/include/linux/sunrpc/msg_prot.h
--- linux-2.5.27/include/linux/sunrpc/msg_prot.h	2002-07-20 21:11:10.000000000 +0200
+++ linux/include/linux/sunrpc/msg_prot.h	2002-07-21 19:30:43.000000000 +0200
@@ -16,7 +16,7 @@
 	RPC_AUTH_UNIX  = 1,
 	RPC_AUTH_SHORT = 2,
 	RPC_AUTH_DES   = 3,
-	RPC_AUTH_KRB   = 4,
+	RPC_AUTH_KRB   = 4
 };
 
 enum rpc_msg_type {
diff -urN linux-2.5.27/include/linux/swap.h linux/include/linux/swap.h
--- linux-2.5.27/include/linux/swap.h	2002-07-20 21:11:06.000000000 +0200
+++ linux/include/linux/swap.h	2002-07-21 19:30:43.000000000 +0200
@@ -89,7 +89,7 @@
 enum {
 	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
 	SWP_WRITEOK	= (1 << 1),	/* ok to write to this swap?	*/
-	SWP_ACTIVE	= (SWP_USED | SWP_WRITEOK),
+	SWP_ACTIVE	= (SWP_USED | SWP_WRITEOK)
 };
 
 #define SWAP_CLUSTER_MAX 32
diff -urN linux-2.5.27/include/linux/tcp_diag.h linux/include/linux/tcp_diag.h
--- linux-2.5.27/include/linux/tcp_diag.h	2002-07-20 21:11:23.000000000 +0200
+++ linux/include/linux/tcp_diag.h	2002-07-21 19:30:43.000000000 +0200
@@ -34,7 +34,7 @@
 enum
 {
 	TCPDIAG_REQ_NONE,
-	TCPDIAG_REQ_BYTECODE,
+	TCPDIAG_REQ_BYTECODE
 };
 
 #define TCPDIAG_REQ_MAX TCPDIAG_REQ_BYTECODE
@@ -62,7 +62,7 @@
 	TCPDIAG_BC_D_LE,
 	TCPDIAG_BC_AUTO,
 	TCPDIAG_BC_S_COND,
-	TCPDIAG_BC_D_COND,
+	TCPDIAG_BC_D_COND
 };
 
 struct tcpdiag_hostcond
@@ -97,7 +97,7 @@
 {
 	TCPDIAG_NONE,
 	TCPDIAG_MEMINFO,
-	TCPDIAG_INFO,
+	TCPDIAG_INFO
 };
 
 #define TCPDIAG_MAX TCPDIAG_INFO
diff -urN linux-2.5.27/include/linux/writeback.h linux/include/linux/writeback.h
--- linux-2.5.27/include/linux/writeback.h	2002-07-20 21:11:08.000000000 +0200
+++ linux/include/linux/writeback.h	2002-07-21 19:30:43.000000000 +0200
@@ -28,7 +28,7 @@
 	WB_SYNC_NONE =  0,	/* Don't wait on anything */
 	WB_SYNC_LAST =  1,	/* Wait on the last-written mapping */
 	WB_SYNC_ALL =   2,	/* Wait on every mapping */
-	WB_SYNC_HOLD =  3,	/* Hold the inode on sb_dirty for sys_sync() */
+	WB_SYNC_HOLD =  3	/* Hold the inode on sb_dirty for sys_sync() */
 };
 
 void writeback_unlocked_inodes(int *nr_to_write,

--------------080408010001090706050900--

