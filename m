Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbTHGSBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbTHGSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:01:40 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:18871 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S267317AbTHGSBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:01:02 -0400
Date: Thu, 7 Aug 2003 20:00:32 +0200
From: Jasper Spaans <jasper@vs19.net>
To: torvalds@osdl.org, andries.brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Message-ID: <20030807180032.GA16957@spaans.vs19.net>
Mime-Version: 1.0
Content-Disposition: inline
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.14.2.cvs.20030804
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Content-Type: text/plain; charset=iso-8859-15
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

This patch is a followup to changeset 1.1046.1.459,

http://linus.bkbits.net:8080/linux-2.5/user=jasper/cset@1.1046.1.459?nav=!-%7Cindex.html%7Cstats%7C!+%7Cindex.html%7CChangeSet@-3w


It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
I've just comiled all affected files (that is, the config resulting from
make allyesconfig minus already broken stuff) succesfully on i386.

Andries, I did a small check if mount uses the fieldnames frrom the kernel
headers, which doesn't seem to be the case, can you confirm that this?



------------------

This BitKeeper patch contains the following changesets:
1.1126

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# User:	jasper
# Host:	vs19.net
# Root:	/home/spaans/bk/linux-jsp

#
#--- 1.134/fs/ntfs/super.c	Fri Aug  1 01:53:11 2003
#+++ 1.135/fs/ntfs/super.c	Thu Aug  7 16:48:50 2003
#@@ -1283,7 +1283,7 @@
# 	sfs->f_ffree = __get_nr_free_mft_records(vol);
# 	up_read(&vol->mftbmp_lock);
# 	/*
#-	 * File system id. This is extremely *nix flavour dependent and even
#+	 * File system id. This is extremely *nix flavor dependent and even
# 	 * within Linux itself all fs do their own thing. I interpret this to
# 	 * mean a unique id associated with the mounted fs and not the id
# 	 * associated with the file system driver, the latter is already given
#
#--- 1.19/arch/i386/kernel/cpu/intel.c	Wed Apr 30 10:07:11 2003
#+++ 1.20/arch/i386/kernel/cpu/intel.c	Thu Aug  7 16:48:50 2003
#@@ -363,7 +363,7 @@
# 
# static unsigned int intel_size_cache(struct cpuinfo_x86 * c, unsigned int size)
# {
#-	/* Intel PIII Tualatin. This comes in two flavours.
#+	/* Intel PIII Tualatin. This comes in two flavors.
# 	 * One has 256kb of cache, the other 512. We have no way
# 	 * to determine which, so we use a boottime override
# 	 * for the 512kb model, and assume 256 otherwise.
#
#--- 1.16/include/net/sctp/constants.h	Mon Aug  4 19:35:39 2003
#+++ 1.17/include/net/sctp/constants.h	Thu Aug  7 16:48:50 2003
#@@ -79,7 +79,7 @@
# #define SCTP_CID_ADDIP_MAX		SCTP_CID_ASCONF_ACK
# #define SCTP_NUM_ADDIP_CHUNK_TYPES	2
# 
#-/* These are the different flavours of event.  */
#+/* These are the different flavors of event.  */
# typedef enum {
# 
# 	SCTP_EVENT_T_CHUNK = 1,
#
#--- 1.20/net/sunrpc/svcauth_unix.c	Fri Jun 27 06:21:42 2003
#+++ 1.21/net/sunrpc/svcauth_unix.c	Thu Aug  7 16:48:50 2003
#@@ -43,7 +43,7 @@
# 	rv = auth_domain_lookup(&ud, 0);
# 
#  foundit:
#-	if (rv && rv->flavour != RPC_AUTH_UNIX) {
#+	if (rv && rv->flavor != RPC_AUTH_UNIX) {
# 		auth_domain_put(rv);
# 		return NULL;
# 	}
#@@ -54,7 +54,7 @@
# 	cache_init(&new->h.h);
# 	atomic_inc(&new->h.h.refcnt);
# 	new->h.name = strdup(name);
#-	new->h.flavour = RPC_AUTH_UNIX;
#+	new->h.flavor = RPC_AUTH_UNIX;
# 	new->addr_changes = 0;
# 	new->h.h.expiry_time = NEVER;
# 	new->h.h.flags = 0;
#@@ -263,7 +263,7 @@
# 	struct unix_domain *udom;
# 	struct ip_map ip, *ipmp;
# 
#-	if (dom->flavour != RPC_AUTH_UNIX)
#+	if (dom->flavor != RPC_AUTH_UNIX)
# 		return -EINVAL;
# 	udom = container_of(dom, struct unix_domain, h);
# 	ip.m_class = "nfsd";
#@@ -285,7 +285,7 @@
# {
# 	struct unix_domain *udom;
# 	
#-	if (dom->flavour != RPC_AUTH_UNIX)
#+	if (dom->flavor != RPC_AUTH_UNIX)
# 		return -EINVAL;
# 	udom = container_of(dom, struct unix_domain, h);
# 	udom->addr_changes++;
#@@ -400,7 +400,7 @@
# 
# struct auth_ops svcauth_null = {
# 	.name		= "null",
#-	.flavour	= RPC_AUTH_NULL,
#+	.flavor	= RPC_AUTH_NULL,
# 	.accept 	= svcauth_null_accept,
# 	.release	= svcauth_null_release,
# };
#@@ -501,7 +501,7 @@
# 
# struct auth_ops svcauth_unix = {
# 	.name		= "unix",
#-	.flavour	= RPC_AUTH_UNIX,
#+	.flavor	= RPC_AUTH_UNIX,
# 	.accept 	= svcauth_unix_accept,
# 	.release	= svcauth_unix_release,
# 	.domain_release	= svcauth_unix_domain_release,
#
#--- 1.9/Documentation/s390/Debugging390.txt	Tue Mar 11 19:20:18 2003
#+++ 1.10/Documentation/s390/Debugging390.txt	Thu Aug  7 16:48:50 2003
#@@ -1666,7 +1666,7 @@
# CCWS are linked lists of instructions initially pointed to by an operation request block (ORB),
# which is initially given to Start Subchannel (SSCH) command along with the subchannel number
# for the IO subsystem to process while the CPU continues executing normal code.
#-These come in two flavours, Format 0 ( 24 bit for backward )
#+These come in two flavors, Format 0 ( 24 bit for backward )
# compatibility & Format 1 ( 31 bit ). These are typically used to issue read & write 
# ( & many other instructions ) they consist of a length field & an absolute address field.
# For each IO typically get 1 or 2 interrupts one for channel end ( primary status ) when the
#@@ -1741,7 +1741,7 @@
#   IOP = IP Processor               
#   CU = Control Unit
# 
#-The 390 IO systems come in 2 flavours the current 390 machines support both
#+The 390 IO systems come in 2 flavors the current 390 machines support both
# 
# The Older 360 & 370 Interface,sometimes called the paralell I/O interface,
# sometimes called Bus-and Tag & sometimes Original Equipment Manufacturers
#
#--- 1.21/fs/sysv/super.c	Mon May 26 04:21:25 2003
#+++ 1.22/fs/sysv/super.c	Thu Aug  7 16:48:50 2003
#@@ -264,7 +264,7 @@
# static struct {
# 	int block;
# 	int (*test)(struct sysv_sb_info *, struct buffer_head *);
#-} flavours[] = {
#+} flavors[] = {
# 	{1, detect_xenix},
# 	{0, detect_sysv},
# 	{0, detect_coherent},
#@@ -273,7 +273,7 @@
# 	{18,detect_sysv},
# };
# 
#-static char *flavour_names[] = {
#+static char *flavor_names[] = {
# 	[FSTYPE_XENIX]	= "Xenix",
# 	[FSTYPE_SYSV4]	= "SystemV",
# 	[FSTYPE_SYSV2]	= "SystemV Release 2",
#@@ -282,7 +282,7 @@
# 	[FSTYPE_AFS]	= "AFS",
# };
# 
#-static void (*flavour_setup[])(struct sysv_sb_info *) = {
#+static void (*flavor_setup[])(struct sysv_sb_info *) = {
# 	[FSTYPE_XENIX]	= detected_xenix,
# 	[FSTYPE_SYSV4]	= detected_sysv4,
# 	[FSTYPE_SYSV2]	= detected_sysv2,
#@@ -295,14 +295,14 @@
# {
# 	struct sysv_sb_info *sbi = SYSV_SB(sb);
# 	struct inode *root_inode;
#-	char *found = flavour_names[sbi->s_type];
#+	char *found = flavor_names[sbi->s_type];
# 	u_char n_bits = size+8;
# 	int bsize = 1 << n_bits;
# 	int bsize_4 = bsize >> 2;
# 
# 	sbi->s_firstinodezone = 2;
# 
#-	flavour_setup[sbi->s_type](sbi);
#+	flavor_setup[sbi->s_type](sbi);
# 	
# 	sbi->s_truncate = 1;
# 	sbi->s_ndatazones = sbi->s_nzones - sbi->s_firstdatazone;
#@@ -371,12 +371,12 @@
# 	
# 	sb_set_blocksize(sb, BLOCK_SIZE);
# 
#-	for (i = 0; i < sizeof(flavours)/sizeof(flavours[0]) && !size; i++) {
#+	for (i = 0; i < sizeof(flavors)/sizeof(flavors[0]) && !size; i++) {
# 		brelse(bh);
#-		bh = sb_bread(sb, flavours[i].block);
#+		bh = sb_bread(sb, flavors[i].block);
# 		if (!bh)
# 			continue;
#-		size = flavours[i].test(SYSV_SB(sb), bh);
#+		size = flavors[i].test(SYSV_SB(sb), bh);
# 	}
# 
# 	if (!size)
#
#--- 1.1/arch/mips/kernel/scall32-o32.S	Fri Aug  1 07:39:47 2003
#+++ 1.2/arch/mips/kernel/scall32-o32.S	Thu Aug  7 16:48:50 2003
#@@ -19,7 +19,7 @@
# #include <asm/unistd.h>
# #include <asm/offset.h>
# 
#-/* Highest syscall used of any syscall flavour */
#+/* Highest syscall used of any syscall flavor */
# #define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
# 
# 	.align  5
#@@ -338,10 +338,10 @@
# 	.endm
# 
# 	.macro	syscalltable
#-	mille	sys_ni_syscall		0	/*    0 -  999 SVR4 flavour */
#+	mille	sys_ni_syscall		0	/*    0 -  999 SVR4 flavor */
# 	#include "irix5sys.h"			/* 1000 - 1999 32-bit IRIX */
#-	mille	sys_ni_syscall		0	/* 2000 - 2999 BSD43 flavour */
#-	mille	sys_ni_syscall		0	/* 3000 - 3999 POSIX flavour */
#+	mille	sys_ni_syscall		0	/* 2000 - 2999 BSD43 flavor */
#+	mille	sys_ni_syscall		0	/* 3000 - 3999 POSIX flavor */
# 
# 	sys	sys_syscall		0	/* 4000 */
# 	sys	sys_exit		1
#
#--- 1.2/arch/mips/mm-32/pg-r4k.S	Mon Jul 28 13:57:51 2003
#+++ 1.3/arch/mips/mm-32/pg-r4k.S	Thu Aug  7 16:48:50 2003
#@@ -28,7 +28,7 @@
# /*
#  * Zero an entire page.  Basically a simple unrolled loop should do the
#  * job but we want more performance by saving memory bus bandwidth.  We
#- * have five flavours of the routine available for:
#+ * have five flavors of the routine available for:
#  *
#  * - 16byte cachelines and no second level cache
#  * - 32byte cachelines second level cache
#@@ -112,7 +112,7 @@
# 	END(r4k_clear_page_d32)
# 
# /*
#- * This flavour of r4k_clear_page is for the R4600 V1.x.  Cite from the
#+ * This flavor of r4k_clear_page is for the R4600 V1.x.  Cite from the
#  * IDT R4600 V1.7 errata:
#  *
#  *  18. The CACHE instructions Hit_Writeback_Invalidate_D, Hit_Writeback_D,
#
#--- 1.2/arch/mips/mm-64/pg-r4k.c	Mon Jul 28 13:57:51 2003
#+++ 1.3/arch/mips/mm-64/pg-r4k.c	Thu Aug  7 16:48:50 2003
#@@ -25,7 +25,7 @@
# /*
#  * Zero an entire page.  Basically a simple unrolled loop should do the
#  * job but we want more performance by saving memory bus bandwidth.  We
#- * have five flavours of the routine available for:
#+ * have five flavors of the routine available for:
#  *
#  * - 16byte cachelines and no second level cache
#  * - 32byte cachelines second level cache
#@@ -89,7 +89,7 @@
# 
# 
# /*
#- * This flavour of r4k_clear_page is for the R4600 V1.x.  Cite from the
#+ * This flavor of r4k_clear_page is for the R4600 V1.x.  Cite from the
#  * IDT R4600 V1.7 errata:
#  *
#  *  18. The CACHE instructions Hit_Writeback_Invalidate_D, Hit_Writeback_D,
#
#--- 1.28/kernel/futex.c	Mon May 26 05:39:28 2003
#+++ 1.29/kernel/futex.c	Thu Aug  7 16:48:50 2003
#@@ -10,7 +10,7 @@
#  *  Kirkwood for proof-of-concept implementation.
#  *
#  *  "The futexes are also cursed."
#- *  "But they come in a choice of three flavours!"
#+ *  "But they come in a choice of three flavors!"
#  *
#  *  This program is free software; you can redistribute it and/or modify
#  *  it under the terms of the GNU General Public License as published by
#
#--- 1.2/arch/sparc/math-emu/math.c	Fri Feb  7 09:20:33 2003
#+++ 1.3/arch/sparc/math-emu/math.c	Thu Aug  7 16:48:50 2003
#@@ -37,7 +37,7 @@
#  * Finally, sfp-machine.h is the machine dependent part of the
#  * code: it defines the word size and what type a word is. It also
#  * defines how _FP_MUL_MEAT_t() maps to _FP_MUL_MEAT_n_* : op-n.h
#- * provide several possible flavours of multiply algorithm, most
#+ * provide several possible flavors of multiply algorithm, most
#  * of which require that you supply some form of asm or C primitive to
#  * do the actual multiply. (such asm primitives should be defined
#  * in sfp-machine.h too). udivmodti4.c is the same sort of thing.
#
#--- 1.8/drivers/char/ftape/zftape/zftape-ctl.c	Fri Mar 14 01:52:15 2003
#+++ 1.9/drivers/char/ftape/zftape/zftape-ctl.c	Thu Aug  7 16:48:50 2003
#@@ -125,7 +125,7 @@
# 		 * compression map. We therefor simply
# 		 * position at the beginning of the first
# 		 * volume. This covers old ftape archives as
#-		 * well has various flavours of the
#+		 * well has various flavors of the
# 		 * compression map segments. The worst case is
# 		 * that the compression map shows up as a
# 		 * additional volume in front of all others.
#
#--- 1.5/drivers/isdn/eicon/adapter.h	Mon Feb 24 18:56:02 2003
#+++ 1.6/drivers/isdn/eicon/adapter.h	Thu Aug  7 16:48:50 2003
#@@ -125,7 +125,7 @@
# dia_config_t	DivasCardConfigs[];
# 
# extern
#-byte 			DivasFlavourConfig[];
#+byte 			DivasFlavorConfig[];
# 
# /*------------------------------------------------------------------*/
# /* public functions of IDI common code                              */
#
#--- 1.9/drivers/net/7990.c	Mon Apr 28 05:36:18 2003
#+++ 1.10/drivers/net/7990.c	Thu Aug  7 16:48:50 2003
#@@ -51,7 +51,7 @@
#  */
# #define DECLARE_LL /* nothing to declare */
# 
#-/* debugging output macros, various flavours */
#+/* debugging output macros, various flavors */
# /* #define TEST_HITS */
# #ifdef UNDEF
# #define PRINT_RINGS() \
#
#--- 1.25/drivers/net/ewrk3.c	Sun May 25 23:08:16 2003
#+++ 1.26/drivers/net/ewrk3.c	Thu Aug  7 16:48:50 2003
#@@ -36,7 +36,7 @@
#    and  is deprecated in this  driver,  although allowed to provide initial
#    setup when hardstrapped.
# 
#-   The shared memory mode comes in 3 flavours: 2kB, 32kB and 64kB. There is
#+   The shared memory mode comes in 3 flavors: 2kB, 32kB and 64kB. There is
#    no point in using any mode other than the 2kB  mode - their performances
#    are virtually identical, although the driver has  been tested in the 2kB
#    and 32kB modes. I would suggest you uncomment the line:
#
#--- 1.84/fs/nfs/inode.c	Thu Jul 17 19:40:29 2003
#+++ 1.85/fs/nfs/inode.c	Thu Aug  7 16:48:50 2003
#@@ -1354,7 +1354,7 @@
# 	struct rpc_xprt *xprt = NULL;
# 	struct rpc_clnt *clnt = NULL;
# 	struct rpc_timeout timeparms;
#-	rpc_authflavor_t authflavour;
#+	rpc_authflavor_t authflavor;
# 	int proto, err = -EIO;
# 
# 	sb->s_blocksize_bits = 0;
#@@ -1407,17 +1407,17 @@
# 		goto out_fail;
# 	}
# 
#-	authflavour = RPC_AUTH_UNIX;
#-	if (data->auth_flavourlen != 0) {
#-		if (data->auth_flavourlen > 1)
#-			printk(KERN_INFO "NFS: cannot yet deal with multiple auth flavours.\n");
#-		if (copy_from_user(&authflavour, data->auth_flavours, sizeof(authflavour))) {
#+	authflavor = RPC_AUTH_UNIX;
#+	if (data->auth_flavorlen != 0) {
#+		if (data->auth_flavorlen > 1)
#+			printk(KERN_INFO "NFS: cannot yet deal with multiple auth flavors.\n");
#+		if (copy_from_user(&authflavor, data->auth_flavors, sizeof(authflavor))) {
# 			err = -EFAULT;
# 			goto out_fail;
# 		}
# 	}
# 	clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
#-				 server->rpc_ops->version, authflavour);
#+				 server->rpc_ops->version, authflavor);
# 	if (clnt == NULL) {
# 		printk(KERN_WARNING "NFS: cannot create RPC client.\n");
# 		xprt_destroy(xprt);
#@@ -1441,7 +1441,7 @@
# 	if ((server->idmap = nfs_idmap_new(server)) == NULL)
# 		printk(KERN_WARNING "NFS: couldn't start IDmap\n");
# 
#-	err = nfs_sb_init(sb, authflavour);
#+	err = nfs_sb_init(sb, authflavor);
# 	if (err == 0)
# 		return 0;
# 	rpciod_down();
#
#--- 1.10/fs/partitions/check.h	Tue Apr 29 23:42:50 2003
#+++ 1.11/fs/partitions/check.h	Thu Aug  7 16:48:50 2003
#@@ -32,5 +32,5 @@
# 
# extern void parse_bsd(struct parsed_partitions *state,
# 			struct block_device *bdev, u32 offset, u32 size,
#-			int origin, char *flavour, int max_partitions);
#+			int origin, char *flavor, int max_partitions);
# 
#
#--- 1.20/fs/partitions/msdos.c	Tue May 27 02:48:43 2003
#+++ 1.21/fs/partitions/msdos.c	Thu Aug  7 16:48:50 2003
#@@ -209,7 +209,7 @@
#  */
# void
# parse_bsd(struct parsed_partitions *state, struct block_device *bdev,
#-		u32 offset, u32 size, int origin, char *flavour,
#+		u32 offset, u32 size, int origin, char *flavor,
# 		int max_partitions)
# {
# 	Sector sect;
#@@ -223,7 +223,7 @@
# 		put_dev_sector(sect);
# 		return;
# 	}
#-	printk(" %s%d: <%s:", state->name, origin, flavour);
#+	printk(" %s%d: <%s:", state->name, origin, flavor);
# 
# 	if (le16_to_cpu(l->d_npartitions) < max_partitions)
# 		max_partitions = le16_to_cpu(l->d_npartitions);
#
#--- 1.5/include/asm-i386/types.h	Sat May 17 23:09:33 2003
#+++ 1.6/include/asm-i386/types.h	Thu Aug  7 16:48:50 2003
#@@ -49,7 +49,7 @@
# typedef signed long long s64;
# typedef unsigned long long u64;
# 
#-/* DMA addresses come in generic and 64-bit flavours.  */
#+/* DMA addresses come in generic and 64-bit flavors.  */
# 
# #ifdef CONFIG_HIGHMEM64G
# typedef u64 dma_addr_t;
#
#--- 1.4/include/asm-mips/fcntl.h	Mon Jul 28 13:57:50 2003
#+++ 1.5/include/asm-mips/fcntl.h	Thu Aug  7 16:48:50 2003
#@@ -77,7 +77,7 @@
# #define LOCK_RW		192	/* ... Which allows concurrent read & write ops */
# 
# /*
#- * The flavours of struct flock.  "struct flock" is the ABI compliant
#+ * The flavors of struct flock.  "struct flock" is the ABI compliant
#  * variant.  Finally struct flock64 is the LFS variant of struct flock.  As
#  * a historic accident and inconsistence with the ABI definition it doesn't
#  * contain all the same fields as struct flock.
#
#--- 1.8/include/asm-mips/unistd.h	Tue Jul 29 13:04:55 2003
#+++ 1.9/include/asm-mips/unistd.h	Thu Aug  7 16:48:50 2003
#@@ -290,7 +290,7 @@
# #define __NR_utimes			(__NR_Linux + 267)
# 
# /*
#- * Offset of the last Linux o32 flavoured syscall
#+ * Offset of the last Linux o32 flavored syscall
#  */
# #define __NR_Linux_syscalls		267
# 
#@@ -534,7 +534,7 @@
# #define __NR_utimes			(__NR_Linux + 226)
# 
# /*
#- * Offset of the last Linux flavoured syscall
#+ * Offset of the last Linux flavored syscall
#  */
# #define __NR_Linux_syscalls		226
# 
#@@ -782,7 +782,7 @@
# #define __NR_utimes			(__NR_Linux + 231)
# 
# /*
#- * Offset of the last N32 flavoured syscall
#+ * Offset of the last N32 flavored syscall
#  */
# #define __NR_Linux_syscalls		231
# 
#
#--- 1.3/include/asm-sparc64/types.h	Tue Dec 31 05:14:21 2002
#+++ 1.4/include/asm-sparc64/types.h	Thu Aug  7 16:48:50 2003
#@@ -51,7 +51,7 @@
# typedef __signed__ long s64;
# typedef unsigned long u64;
# 
#-/* Dma addresses come in generic and 64-bit flavours.  */
#+/* Dma addresses come in generic and 64-bit flavors.  */
# 
# typedef u32 dma_addr_t;
# typedef u64 dma64_addr_t;
#
#--- 1.2/include/linux/dio.h	Fri Jun  7 13:06:42 2002
#+++ 1.3/include/linux/dio.h	Thu Aug  7 16:48:50 2003
#@@ -124,7 +124,7 @@
# #define DIO_DESC_SCSI2 "98625A SCSI2"
# #define DIO_ID_SCSI3    0x67 /* ditto */
# #define DIO_DESC_SCSI3 "98625A SCSI3"
#-#define DIO_ID_FBUFFER  0x39 /* framebuffer: flavour is distinguished by secondary ID */
#+#define DIO_ID_FBUFFER  0x39 /* framebuffer: flavor is distinguished by secondary ID */
# #define DIO_DESC_FBUFFER "bitmapped display"
# /* the NetBSD kernel source is a bit unsure as to what these next IDs actually do :-> */
# #define DIO_ID_MISC0    0x03 /* 98622A */
#
#--- 1.24/include/linux/sunrpc/svc.h	Tue Jun 24 08:30:35 2003
#+++ 1.25/include/linux/sunrpc/svc.h	Thu Aug  7 16:48:50 2003
#@@ -108,7 +108,7 @@
# 
# 	struct svc_serv *	rq_server;	/* RPC service definition */
# 	struct svc_procedure *	rq_procinfo;	/* procedure info */
#-	struct auth_ops *	rq_authop;	/* authentication flavour */
#+	struct auth_ops *	rq_authop;	/* authentication flavor */
# 	struct svc_cred		rq_cred;	/* auth info */
# 	struct sk_buff *	rq_skbuff;	/* fast recv inet buffer */
# 	struct svc_deferred_req*rq_deferred;	/* deferred request we are replaying */
#
#--- 1.9/include/linux/sunrpc/svcauth.h	Sat Jan 11 02:55:15 2003
#+++ 1.10/include/linux/sunrpc/svcauth.h	Thu Aug  7 16:48:50 2003
#@@ -35,7 +35,7 @@
#  * For a client, a domain represents a number of servers which all
#  * use a common authentication mechanism and network identity name space.
#  *
#- * A domain is created by an authentication flavour module based on name
#+ * A domain is created by an authentication flavor module based on name
#  * only.  Userspace then fills in detail on demand.
#  *
#  * The creation of a domain typically implies creation of one or
#@@ -44,14 +44,14 @@
# struct auth_domain {
# 	struct	cache_head	h;
# 	char			*name;
#-	int			flavour;
#+	int			flavor;
# };
# 
# /*
#- * Each authentication flavour registers an auth_ops
#+ * Each authentication flavor registers an auth_ops
#  * structure.
#  * name is simply the name.
#- * flavour gives the auth flavour. It determines where the flavour is registered
#+ * flavor gives the auth flavor. It determines where the flavor is registered
#  * accept() is given a request and should verify it.
#  *   It should inspect the authenticator and verifier, and possibly the data.
#  *    If there is a problem with the authentication *authp should be set.
#@@ -82,7 +82,7 @@
#  */
# struct auth_ops {
# 	char *	name;
#-	int	flavour;
#+	int	flavor;
# 	int	(*accept)(struct svc_rqst *rq, u32 *authp);
# 	int	(*release)(struct svc_rqst *rq);
# 	void	(*domain_release)(struct auth_domain *);
#
#--- 1.6/net/decnet/dn_fib.c	Wed May  7 22:36:49 2003
#+++ 1.7/net/decnet/dn_fib.c	Thu Aug  7 16:48:50 2003
#@@ -302,11 +302,11 @@
# 		struct rtattr *attr = RTA_DATA(rta->rta_mx);
# 
# 		while(RTA_OK(attr, attrlen)) {
#-			unsigned flavour = attr->rta_type;
#-			if (flavour) {
#-				if (flavour > RTAX_MAX)
#+			unsigned flavor = attr->rta_type;
#+			if (flavor) {
#+				if (flavor > RTAX_MAX)
# 					goto err_inval;
#-				fi->fib_metrics[flavour-1] = *(unsigned*)RTA_DATA(attr);
#+				fi->fib_metrics[flavor-1] = *(unsigned*)RTA_DATA(attr);
# 			}
# 			attr = RTA_NEXT(attr, attrlen);
# 		}
#
#--- 1.13/net/ipv6/exthdrs.c	Tue Jun 24 10:33:31 2003
#+++ 1.14/net/ipv6/exthdrs.c	Thu Aug  7 16:48:50 2003
#@@ -693,7 +693,7 @@
#  * processing all preceding ones.
#  * 
#  * We do exactly this. This is a protocol bug. We can't decide after a
#- * seeing an unknown discard-with-error flavour TLV option if it's a 
#+ * seeing an unknown discard-with-error flavor TLV option if it's a 
#  * ICMP error message or not (errors should never be send in reply to
#  * ICMP error messages).
#  * 
#
#--- 1.12/net/sunrpc/svcauth.c	Tue Jun 24 05:32:34 2003
#+++ 1.13/net/sunrpc/svcauth.c	Thu Aug  7 16:48:50 2003
#@@ -88,7 +88,7 @@
# 
# /**************************************************
#  * cache for domain name to auth_domain
#- * Entries are only added by flavours which will normally
#+ * Entries are only added by flavors which will normally
#  * have a structure that 'inherits' from auth_domain.
#  * e.g. when an IP -> domainname is given to  auth_unix,
#  * and the domain name doesn't exist, it will create a
#@@ -100,7 +100,7 @@
# /*
#  * Auth auth_domain cache is somewhat different to other caches,
#  * largely because the entries are possibly of different types:
#- * each auth flavour has it's own type.
#+ * each auth flavor has it's own type.
#  * One consequence of this that DefineCacheLookup cannot
#  * allocate a new structure as it cannot know the size.
#  * Notice that the "INIT" code fragment is quite different
#@@ -118,7 +118,7 @@
# {
# 	struct auth_domain *dom = container_of(item, struct auth_domain, h);
# 	if (cache_put(item,cd))
#-		authtab[dom->flavour]->domain_release(dom);
#+		authtab[dom->flavor]->domain_release(dom);
# }
# 
# 
#
#--- 1.1/include/linux/nfs4_mount.h	Mon Oct 14 20:39:05 2002
#+++ 1.2/include/linux/nfs4_mount.h	Thu Aug  7 16:48:50 2003
#@@ -50,9 +50,9 @@
# 	/* Transport protocol to use */
# 	int proto;				/* 1 */
# 
#-	/* Pseudo-flavours to use for authentication. See RFC2623 */
#-	int auth_flavourlen;			/* 1 */
#-	int *auth_flavours;			/* 1 */
#+	/* Pseudo-flavors to use for authentication. See RFC2623 */
#+	int auth_flavorlen;			/* 1 */
#+	int *auth_flavors;			/* 1 */
# };
# 
# /* bits in the flags field */
#
#--- 1.6/scripts/kconfig/Makefile	Sat Mar 15 18:25:56 2003
#+++ 1.7/scripts/kconfig/Makefile	Thu Aug  7 16:48:50 2003
#@@ -11,7 +11,7 @@
# #
# #################
# 
#-# object files used by all lkc flavours
#+# object files used by all lkc flavors
# libkconfig-objs := zconf.tab.o
# 
# host-progs	:= conf mconf qconf gconf
#

# Diff checksum=172dea2f


# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
jasper@vs19.net[spaans]|ChangeSet|20030807153159|57503
D 1.1126 03/08/07 17:33:10+02:00 jasper@vs19.net[spaans] +30 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c diff-flavor
K 44954
P ChangeSet
------------------------------------------------

0a0
> davej@suse.de|arch/i386/kernel/cpu/intel.c|20020605182529|14299|83fae676fbe78e0d jasper@vs19.net[spaans]|arch/i386/kernel/cpu/intel.c|20030807153304|22402
> ralf@linux-mips.org[torvalds]|arch/mips/kernel/scall32-o32.S|20030801053947|63044|4cc5bba7d1ca75a8 jasper@vs19.net[spaans]|arch/mips/kernel/scall32-o32.S|20030807153304|29937
> ralf@linux-mips.org[torvalds]|arch/mips/mm/pg-r4k.S|20030623190711|33260|7be7818a2c76f61 jasper@vs19.net[spaans]|arch/mips/mm-32/pg-r4k.S|20030807153304|65227
> ralf@linux-mips.org[torvalds]|arch/mips64/mm/pg-r4k.c|20030623190834|25969|ecd0bdbaaedbdc21 jasper@vs19.net[spaans]|arch/mips/mm-64/pg-r4k.c|20030807153304|54092
> torvalds@athlon.transmeta.com|arch/sparc/math-emu/math.c|20020205174023|62816|aef85ee6f8e8a0ea jasper@vs19.net[spaans]|arch/sparc/math-emu/math.c|20030807153304|25276
> patch@athlon.transmeta.com|Documentation/s390/Debugging390.txt|20020205181001|17682|38abccf5c3739022 jasper@vs19.net[spaans]|Documentation/s390/Debugging390.txt|20030807153304|03371
> torvalds@athlon.transmeta.com|drivers/char/ftape/zftape/zftape-ctl.c|20020205174005|17560|7242a156fd497a05 jasper@vs19.net[spaans]|drivers/char/ftape/zftape/zftape-ctl.c|20030807153304|15600
> torvalds@athlon.transmeta.com|drivers/isdn/eicon/adapter.h|20020205174012|37040|410433d89beedee5 jasper@vs19.net[spaans]|drivers/isdn/eicon/adapter.h|20030807153304|36911
> torvalds@athlon.transmeta.com|drivers/net/7990.c|20020205174002|33456|dcb0c81be07ac4be jasper@vs19.net[spaans]|drivers/net/7990.c|20030807153304|12159
> torvalds@athlon.transmeta.com|drivers/net/ewrk3.c|20020205174001|13864|cfa24e3bd0cdc03c jasper@vs19.net[spaans]|drivers/net/ewrk3.c|20030807153304|27724
> torvalds@athlon.transmeta.com|fs/nfs/inode.c|20020205173938|09363|3f03927acfdbd4a jasper@vs19.net[spaans]|fs/nfs/inode.c|20030807153304|62737
> BK|fs/ntfs/super.c|19700101030959|00024|ae6e00b03ea02889 jasper@vs19.net[spaans]|fs/ntfs/super.c|20030807153304|22041
> torvalds@athlon.transmeta.com|fs/partitions/check.h|20020205173939|07282|8bf4113a8485c596 jasper@vs19.net[spaans]|fs/partitions/check.h|20030807153304|62227
> torvalds@athlon.transmeta.com|fs/partitions/msdos.c|20020205173939|08398|638b6058a3f829f7 jasper@vs19.net[spaans]|fs/partitions/msdos.c|20030807153304|11193
> patch@athlon.transmeta.com|fs/sysv/super.c|20020205190830|20794|d2909d10bd7c4d3f jasper@vs19.net[spaans]|fs/sysv/super.c|20030807153305|46476
> torvalds@athlon.transmeta.com|include/asm-i386/types.h|20020205173944|26206|8bddf1df4b96d31c jasper@vs19.net[spaans]|include/asm-i386/types.h|20030807153305|38645
> torvalds@athlon.transmeta.com|include/asm-mips/fcntl.h|20020205173945|13899|997d88dc30026e54 jasper@vs19.net[spaans]|include/asm-mips/fcntl.h|20030807153305|61560
> torvalds@athlon.transmeta.com|include/asm-mips/unistd.h|20020205173944|32413|96869979d8709174 jasper@vs19.net[spaans]|include/asm-mips/unistd.h|20030807153305|22345
> torvalds@athlon.transmeta.com|include/asm-sparc64/types.h|20020205173950|51322|8cba6ad8b65b9893 jasper@vs19.net[spaans]|include/asm-sparc64/types.h|20030807153305|48888
> torvalds@athlon.transmeta.com|include/linux/dio.h|20020205173942|53841|5d000b7be555bc76 jasper@vs19.net[spaans]|include/linux/dio.h|20030807153305|40295
> trond.myklebust@fys.uio.no[torvalds]|include/linux/nfs4_mount.h|20021016023045|64519|cbcac9fb1bf3e26d jasper@vs19.net[spaans]|include/linux/nfs4_mount.h|20030807153305|08909
> torvalds@athlon.transmeta.com|include/linux/sunrpc/svcauth.h|20020205173941|15745|13d0f21c8c263fde jasper@vs19.net[spaans]|include/linux/sunrpc/svcauth.h|20030807153305|15900
> torvalds@athlon.transmeta.com|include/linux/sunrpc/svc.h|20020205173941|15025|8e29f1e46c1fd990 jasper@vs19.net[spaans]|include/linux/sunrpc/svc.h|20030807153305|31867
> jgrimm@touki.qip.austin.ibm.com|include/net/sctp/sctp_constants.h|20020819215340|26717|e2f7b309e21a66cf jasper@vs19.net[spaans]|include/net/sctp/constants.h|20030807153305|50934
> rusty@rustcorp.com.au|kernel/futex.c|20020310195012|48961|39d169578d353bea jasper@vs19.net[spaans]|kernel/futex.c|20030807153305|14489
> torvalds@athlon.transmeta.com|net/decnet/dn_fib.c|20020205173959|01501|b27680a712405bb8 jasper@vs19.net[spaans]|net/decnet/dn_fib.c|20030807153305|44148
> torvalds@athlon.transmeta.com|net/ipv6/exthdrs.c|20020205173959|13760|16ff28906231f4a1 jasper@vs19.net[spaans]|net/ipv6/exthdrs.c|20030807153305|27715
> torvalds@athlon.transmeta.com|net/sunrpc/svcauth.c|20020205173959|06895|dd2942bf6d6fcda jasper@vs19.net[spaans]|net/sunrpc/svcauth.c|20030807153305|26770
> neilb@cse.unsw.edu.au[torvalds]|net/sunrpc/svcauth_unix.c|20021012023922|44522|e8927e109738a7a jasper@vs19.net[spaans]|net/sunrpc/svcauth_unix.c|20030807153305|50092
> zippel@linux-m68k.org[torvalds]|scripts/kconfig/Makefile|20021030043213|15288|5bd1152661e7e933 jasper@vs19.net[spaans]|scripts/kconfig/Makefile|20030807153305|27757

== fs/ntfs/super.c ==
BK|fs/ntfs/super.c|19700101030959|00024|ae6e00b03ea02889
rddunlap@osdl.org[torvalds]|fs/ntfs/super.c|20030801220216|22158
D 1.135 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 22041
O -rw-rw-r--
P fs/ntfs/super.c
------------------------------------------------

D1286 1
I1286 1
	 * File system id. This is extremely *nix flavor dependent and even

== arch/i386/kernel/cpu/intel.c ==
davej@suse.de|arch/i386/kernel/cpu/intel.c|20020605182529|14299|83fae676fbe78e0d
ak@muc.de[torvalds]|arch/i386/kernel/cpu/intel.c|20030430143200|22519
D 1.20 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 22402
O -rw-rw-r--
P arch/i386/kernel/cpu/intel.c
------------------------------------------------

D366 1
I366 1
	/* Intel PIII Tualatin. This comes in two flavors.

== include/net/sctp/constants.h ==
jgrimm@touki.qip.austin.ibm.com|include/net/sctp/sctp_constants.h|20020819215340|26717|e2f7b309e21a66cf
sri@us.ibm.com|include/net/sctp/constants.h|20030804173539|51051
D 1.17 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 50934
O -rw-rw-r--
P include/net/sctp/constants.h
------------------------------------------------

D82 1
I82 1
/* These are the different flavors of event.  */

== net/sunrpc/svcauth_unix.c ==
neilb@cse.unsw.edu.au[torvalds]|net/sunrpc/svcauth_unix.c|20021012023922|44522|e8927e109738a7a
neilb@cse.unsw.edu.au[torvalds]|net/sunrpc/svcauth_unix.c|20030627163755|50794
D 1.21 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +6 -6
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 50092
O -rw-rw-r--
P net/sunrpc/svcauth_unix.c
------------------------------------------------

D46 1
I46 1
	if (rv && rv->flavor != RPC_AUTH_UNIX) {
D57 1
I57 1
	new->h.flavor = RPC_AUTH_UNIX;
D266 1
I266 1
	if (dom->flavor != RPC_AUTH_UNIX)
D288 1
I288 1
	if (dom->flavor != RPC_AUTH_UNIX)
D403 1
I403 1
	.flavor	= RPC_AUTH_NULL,
D504 1
I504 1
	.flavor	= RPC_AUTH_UNIX,

== Documentation/s390/Debugging390.txt ==
patch@athlon.transmeta.com|Documentation/s390/Debugging390.txt|20020205181001|17682|38abccf5c3739022
elenstev@mesatop.com[torvalds]|Documentation/s390/Debugging390.txt|20030312014752|03605
D 1.10 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +2 -2
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 3371
O -rw-rw-r--
P Documentation/s390/Debugging390.txt
------------------------------------------------

D1669 1
I1669 1
These come in two flavors, Format 0 ( 24 bit for backward )
D1744 1
I1744 1
The 390 IO systems come in 2 flavors the current 390 machines support both

== fs/sysv/super.c ==
patch@athlon.transmeta.com|fs/sysv/super.c|20020205190830|20794|d2909d10bd7c4d3f
Andries.Brouwer@cwi.nl[torvalds]|fs/sysv/super.c|20030526022125|47529
D 1.22 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +8 -8
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 46476
O -rw-rw-r--
P fs/sysv/super.c
------------------------------------------------

D267 1
I267 1
} flavors[] = {
D276 1
I276 1
static char *flavor_names[] = {
D285 1
I285 1
static void (*flavor_setup[])(struct sysv_sb_info *) = {
D298 1
I298 1
	char *found = flavor_names[sbi->s_type];
D305 1
I305 1
	flavor_setup[sbi->s_type](sbi);
D374 1
I374 1
	for (i = 0; i < sizeof(flavors)/sizeof(flavors[0]) && !size; i++) {
D376 1
I376 1
		bh = sb_bread(sb, flavors[i].block);
D379 1
I379 1
		size = flavors[i].test(SYSV_SB(sb), bh);

== arch/mips/kernel/scall32-o32.S ==
ralf@linux-mips.org[torvalds]|arch/mips/kernel/scall32-o32.S|20030801053947|63044|4cc5bba7d1ca75a8
ralf@linux-mips.org[torvalds]|arch/mips/kernel/scall32-o32.S|20030801053948|30405
D 1.2 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +4 -4
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 29937
O -rw-rw-r--
P arch/mips/kernel/scall32-o32.S
------------------------------------------------

D22 1
I22 1
/* Highest syscall used of any syscall flavor */
D341 1
I341 1
	mille	sys_ni_syscall		0	/*    0 -  999 SVR4 flavor */
D343 2
I344 2
	mille	sys_ni_syscall		0	/* 2000 - 2999 BSD43 flavor */
	mille	sys_ni_syscall		0	/* 3000 - 3999 POSIX flavor */

== arch/mips/mm-32/pg-r4k.S ==
ralf@linux-mips.org[torvalds]|arch/mips/mm/pg-r4k.S|20030623190711|33260|7be7818a2c76f61
ralf@linux-mips.org[torvalds]|arch/mips/mm-32/pg-r4k.S|20030801053948|65461
D 1.3 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +2 -2
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 65227
O -rw-rw-r--
P arch/mips/mm-32/pg-r4k.S
------------------------------------------------

D31 1
I31 1
 * have five flavors of the routine available for:
D115 1
I115 1
 * This flavor of r4k_clear_page is for the R4600 V1.x.  Cite from the

== arch/mips/mm-64/pg-r4k.c ==
ralf@linux-mips.org[torvalds]|arch/mips64/mm/pg-r4k.c|20030623190834|25969|ecd0bdbaaedbdc21
ralf@linux-mips.org[torvalds]|arch/mips/mm-64/pg-r4k.c|20030801053948|04120
D 1.3 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +2 -2
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 54092
O -rw-rw-r--
P arch/mips/mm-64/pg-r4k.c
------------------------------------------------

D28 1
I28 1
 * have five flavors of the routine available for:
D92 1
I92 1
 * This flavor of r4k_clear_page is for the R4600 V1.x.  Cite from the

== kernel/futex.c ==
rusty@rustcorp.com.au|kernel/futex.c|20020310195012|48961|39d169578d353bea
davem@kernel.bkbits.net|kernel/futex.c|20030526033928|14606
D 1.29 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 14489
O -rw-rw-r--
P kernel/futex.c
------------------------------------------------

D13 1
I13 1
 *  "But they come in a choice of three flavors!"

== arch/sparc/math-emu/math.c ==
torvalds@athlon.transmeta.com|arch/sparc/math-emu/math.c|20020205174023|62816|aef85ee6f8e8a0ea
elenstev@mesatop.com[torvalds]|arch/sparc/math-emu/math.c|20030207161102|25393
D 1.3 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 25276
O -rw-rw-r--
P arch/sparc/math-emu/math.c
------------------------------------------------

D40 1
I40 1
 * provide several possible flavors of multiply algorithm, most

== drivers/char/ftape/zftape/zftape-ctl.c ==
torvalds@athlon.transmeta.com|drivers/char/ftape/zftape/zftape-ctl.c|20020205174005|17560|7242a156fd497a05
alan@lxorguk.ukuu.org.uk[torvalds]|drivers/char/ftape/zftape/zftape-ctl.c|20030322021935|15717
D 1.9 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 15600
O -rw-rw-r--
P drivers/char/ftape/zftape/zftape-ctl.c
------------------------------------------------

D128 1
I128 1
		 * well has various flavors of the

== drivers/isdn/eicon/adapter.h ==
torvalds@athlon.transmeta.com|drivers/isdn/eicon/adapter.h|20020205174012|37040|410433d89beedee5
mike@aiinc.ca[torvalds]|drivers/isdn/eicon/adapter.h|20030225035751|37028
D 1.6 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 36911
O -rw-rw-r--
P drivers/isdn/eicon/adapter.h
------------------------------------------------

D128 1
I128 1
byte 			DivasFlavorConfig[];

== drivers/net/7990.c ==
torvalds@athlon.transmeta.com|drivers/net/7990.c|20020205174002|33456|dcb0c81be07ac4be
akpm@digeo.com|drivers/net/7990.c|20030428033618|12276
D 1.10 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 12159
O -rw-rw-r--
P drivers/net/7990.c
------------------------------------------------

D54 1
I54 1
/* debugging output macros, various flavors */

== drivers/net/ewrk3.c ==
torvalds@athlon.transmeta.com|drivers/net/ewrk3.c|20020205174001|13864|cfa24e3bd0cdc03c
akpm@digeo.com[torvalds]|drivers/net/ewrk3.c|20030525221423|27841
D 1.26 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 27724
O -rw-rw-r--
P drivers/net/ewrk3.c
------------------------------------------------

D39 1
I39 1
   The shared memory mode comes in 3 flavors: 2kB, 32kB and 64kB. There is

== fs/nfs/inode.c ==
torvalds@athlon.transmeta.com|fs/nfs/inode.c|20020205173938|09363|3f03927acfdbd4a
jasper@vs19.net[torvalds]|fs/nfs/inode.c|20030717191036|63907
D 1.85 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +8 -8
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 62737
O -rw-rw-r--
P fs/nfs/inode.c
------------------------------------------------

D1357 1
I1357 1
	rpc_authflavor_t authflavor;
D1410 5
I1414 5
	authflavor = RPC_AUTH_UNIX;
	if (data->auth_flavorlen != 0) {
		if (data->auth_flavorlen > 1)
			printk(KERN_INFO "NFS: cannot yet deal with multiple auth flavors.\n");
		if (copy_from_user(&authflavor, data->auth_flavors, sizeof(authflavor))) {
D1420 1
I1420 1
				 server->rpc_ops->version, authflavor);
D1444 1
I1444 1
	err = nfs_sb_init(sb, authflavor);

== fs/partitions/check.h ==
torvalds@athlon.transmeta.com|fs/partitions/check.h|20020205173939|07282|8bf4113a8485c596
hch@lst.de[torvalds]|fs/partitions/check.h|20030430143235|62344
D 1.11 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 62227
O -rw-rw-r--
P fs/partitions/check.h
------------------------------------------------

D35 1
I35 1
			int origin, char *flavor, int max_partitions);

== fs/partitions/msdos.c ==
torvalds@athlon.transmeta.com|fs/partitions/msdos.c|20020205173939|08398|638b6058a3f829f7
Andries.Brouwer@cwi.nl[torvalds]|fs/partitions/msdos.c|20030527004843|11427
D 1.21 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +2 -2
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2654
K 11193
O -rw-rw-r--
P fs/partitions/msdos.c
------------------------------------------------

D212 1
I212 1
		u32 offset, u32 size, int origin, char *flavor,
D226 1
I226 1
	printk(" %s%d: <%s:", state->name, origin, flavor);

== include/asm-i386/types.h ==
torvalds@athlon.transmeta.com|include/asm-i386/types.h|20020205173944|26206|8bddf1df4b96d31c
akpm@digeo.com[torvalds]|include/asm-i386/types.h|20030519172735|38762
D 1.6 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 38645
O -rw-rw-r--
P include/asm-i386/types.h
------------------------------------------------

D52 1
I52 1
/* DMA addresses come in generic and 64-bit flavors.  */

== include/asm-mips/fcntl.h ==
torvalds@athlon.transmeta.com|include/asm-mips/fcntl.h|20020205173945|13899|997d88dc30026e54
ralf@linux-mips.org[torvalds]|include/asm-mips/fcntl.h|20030801053950|61677
D 1.5 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 61560
O -rw-rw-r--
P include/asm-mips/fcntl.h
------------------------------------------------

D80 1
I80 1
 * The flavors of struct flock.  "struct flock" is the ABI compliant

== include/asm-mips/unistd.h ==
torvalds@athlon.transmeta.com|include/asm-mips/unistd.h|20020205173944|32413|96869979d8709174
ralf@linux-mips.org[torvalds]|include/asm-mips/unistd.h|20030801053950|22696
D 1.9 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +3 -3
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 22345
O -rw-rw-r--
P include/asm-mips/unistd.h
------------------------------------------------

D293 1
I293 1
 * Offset of the last Linux o32 flavored syscall
D537 1
I537 1
 * Offset of the last Linux flavored syscall
D785 1
I785 1
 * Offset of the last N32 flavored syscall

== include/asm-sparc64/types.h ==
torvalds@athlon.transmeta.com|include/asm-sparc64/types.h|20020205173950|51322|8cba6ad8b65b9893
kai@tp1.ruhr-uni-bochum.de|include/asm-sparc64/types.h|20021231041421|49005
D 1.4 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 48888
O -rw-rw-r--
P include/asm-sparc64/types.h
------------------------------------------------

D54 1
I54 1
/* Dma addresses come in generic and 64-bit flavors.  */

== include/linux/dio.h ==
torvalds@athlon.transmeta.com|include/linux/dio.h|20020205173942|53841|5d000b7be555bc76
geert@linux-m68k.org|include/linux/dio.h|20020724032151|40412
D 1.3 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 40295
O -rw-rw-r--
P include/linux/dio.h
------------------------------------------------

D127 1
I127 1
#define DIO_ID_FBUFFER  0x39 /* framebuffer: flavor is distinguished by secondary ID */

== include/linux/sunrpc/svc.h ==
torvalds@athlon.transmeta.com|include/linux/sunrpc/svc.h|20020205173941|15025|8e29f1e46c1fd990
neilb@cse.unsw.edu.au[torvalds]|include/linux/sunrpc/svc.h|20030624191536|31984
D 1.25 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 31867
O -rw-rw-r--
P include/linux/sunrpc/svc.h
------------------------------------------------

D111 1
I111 1
	struct auth_ops *	rq_authop;	/* authentication flavor */

== include/linux/sunrpc/svcauth.h ==
torvalds@athlon.transmeta.com|include/linux/sunrpc/svcauth.h|20020205173941|15745|13d0f21c8c263fde
neilb@cse.unsw.edu.au[torvalds]|include/linux/sunrpc/svcauth.h|20030111044021|16719
D 1.10 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +5 -5
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 15900
O -rw-rw-r--
P include/linux/sunrpc/svcauth.h
------------------------------------------------

D38 1
I38 1
 * A domain is created by an authentication flavor module based on name
D47 1
I47 1
	int			flavor;
D51 1
I51 1
 * Each authentication flavor registers an auth_ops
D54 1
I54 1
 * flavor gives the auth flavor. It determines where the flavor is registered
D85 1
I85 1
	int	flavor;

== net/decnet/dn_fib.c ==
torvalds@athlon.transmeta.com|net/decnet/dn_fib.c|20020205173959|01501|b27680a712405bb8
shemminger@osdl.org|net/decnet/dn_fib.c|20030507203649|44616
D 1.7 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +4 -4
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 44148
O -rw-rw-r--
P net/decnet/dn_fib.c
------------------------------------------------

D305 3
I307 3
			unsigned flavor = attr->rta_type;
			if (flavor) {
				if (flavor > RTAX_MAX)
D309 1
I309 1
				fi->fib_metrics[flavor-1] = *(unsigned*)RTA_DATA(attr);

== net/ipv6/exthdrs.c ==
torvalds@athlon.transmeta.com|net/ipv6/exthdrs.c|20020205173959|13760|16ff28906231f4a1
yoshfuji@linux-ipv6.org|net/ipv6/exthdrs.c|20030624083331|27832
D 1.14 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 27715
O -rw-rw-r--
P net/ipv6/exthdrs.c
------------------------------------------------

D696 1
I696 1
 * seeing an unknown discard-with-error flavor TLV option if it's a 

== net/sunrpc/svcauth.c ==
torvalds@athlon.transmeta.com|net/sunrpc/svcauth.c|20020205173959|06895|dd2942bf6d6fcda
neilb@cse.unsw.edu.au[torvalds]|net/sunrpc/svcauth.c|20030624191435|27121
D 1.13 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +3 -3
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 26770
O -rw-rw-r--
P net/sunrpc/svcauth.c
------------------------------------------------

D91 1
I91 1
 * Entries are only added by flavors which will normally
D103 1
I103 1
 * each auth flavor has it's own type.
D121 1
I121 1
		authtab[dom->flavor]->domain_release(dom);

== include/linux/nfs4_mount.h ==
trond.myklebust@fys.uio.no[torvalds]|include/linux/nfs4_mount.h|20021016023045|64519|cbcac9fb1bf3e26d
trond.myklebust@fys.uio.no[torvalds]|include/linux/nfs4_mount.h|20021016023046|09260
D 1.2 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +3 -3
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 8909
O -rw-rw-r--
P include/linux/nfs4_mount.h
------------------------------------------------

D53 3
I55 3
	/* Pseudo-flavors to use for authentication. See RFC2623 */
	int auth_flavorlen;			/* 1 */
	int *auth_flavors;			/* 1 */

== scripts/kconfig/Makefile ==
zippel@linux-m68k.org[torvalds]|scripts/kconfig/Makefile|20021030043213|15288|5bd1152661e7e933
zippel@linux-m68k.org[torvalds]|scripts/kconfig/Makefile|20030316011735|27874
D 1.7 03/08/07 16:48:50+02:00 jasper@vs19.net[spaans] +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Change all occurences of flavour to flavor
F 2655
K 27757
O -rw-rw-r--
P scripts/kconfig/Makefile
------------------------------------------------

D14 1
I14 1
# object files used by all lkc flavors

# Patch checksum=21f4a75e


VrGr,
-- 
Jasper Spaans               http://jsp.vs19.net/contact/

<==          ``Got no clue? Too bad for you''          ==>
<==                                                    ==>
