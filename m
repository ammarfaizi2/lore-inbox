Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbULWXLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbULWXLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 18:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULWXLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 18:11:05 -0500
Received: from admingilde.org ([213.95.21.5]:57305 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S261334AbULWXKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 18:10:01 -0500
Date: Fri, 24 Dec 2004 00:09:43 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation fixes
Message-ID: <20041223230943.GB6784@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:041223:linux-kernel@vger.kernel.org:25250a59fc6f9d19
X-Spam-Score: -12.9 (------------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

The patch below fixes some warnings I get while updating my online
version of the Linux DocBook Documentation.

I don't have deep knowledge of all those subsystems, so please provide
better comments here :)

Index: drivers/block/ll_rw_blk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/drivers/block/ll_rw_bl=
k.c,v
retrieving revision 1.264
diff -u -p -r1.264 ll_rw_blk.c
--- drivers/block/ll_rw_blk.c	2 Dec 2004 01:09:52 -0000	1.264
+++ drivers/block/ll_rw_blk.c	23 Dec 2004 21:55:05 -0000
@@ -618,6 +618,7 @@ fail:
  * blk_queue_init_tags - initialize the queue tag info
  * @q:  the request queue for the device
  * @depth:  the maximum queue depth supported
+ * @tags: the tag to use
  **/
 int blk_queue_init_tags(request_queue_t *q, int depth,
 			struct blk_queue_tag *tags)
@@ -1934,7 +1935,7 @@ EXPORT_SYMBOL(blk_rq_map_user);
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @rq:		request to be unmapped
- * @ubuf:	user buffer
+ * @bio:	bio for the request
  * @ulen:	length of user buffer
  *
  * Description:
Index: drivers/net/8390.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/drivers/net/8390.c,v
retrieving revision 1.24
diff -u -p -r1.24 8390.c
--- drivers/net/8390.c	30 Oct 2004 11:59:58 -0000	1.24
+++ drivers/net/8390.c	23 Dec 2004 21:41:43 -0000
@@ -1002,6 +1002,7 @@ static void ethdev_setup(struct net_devi
=20
 /**
  * alloc_ei_netdev - alloc_etherdev counterpart for 8390
+ * @size: extra bytes to allocate
  *
  * Allocate 8390-specific net_device.
  */
Index: drivers/usb/core/hcd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/drivers/usb/core/hcd.c=
,v
retrieving revision 1.65
diff -u -p -r1.65 hcd.c
--- drivers/usb/core/hcd.c	13 Nov 2004 19:29:18 -0000	1.65
+++ drivers/usb/core/hcd.c	23 Dec 2004 22:50:14 -0000
@@ -1435,7 +1435,7 @@ static int hcd_hub_resume (struct usb_bu
 /**
  * usb_bus_start_enum - start immediate enumeration (for OTG)
  * @bus: the bus (must use hcd framework)
- * @port: 1-based number of port; usually bus->otg_port
+ * @port_num: 1-based number of port; usually bus->otg_port
  * Context: in_interrupt()
  *
  * Starts enumeration, with an immediate reset followed later by
Index: drivers/usb/core/hub.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/drivers/usb/core/hub.c=
,v
retrieving revision 1.73
diff -u -p -r1.73 hub.c
--- drivers/usb/core/hub.c	13 Nov 2004 19:29:18 -0000	1.73
+++ drivers/usb/core/hub.c	23 Dec 2004 22:49:47 -0000
@@ -368,7 +368,7 @@ static void hub_tt_kevent (void *arg)
=20
 /**
  * usb_hub_tt_clear_buffer - clear control/bulk TT state in high speed hub
- * @dev: the device whose split transaction failed
+ * @udev: the device whose split transaction failed
  * @pipe: identifies the endpoint of the failed transaction
  *
  * High speed HCDs use this to tell the hub driver that some split control=
 or
Index: drivers/video/fbmem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/drivers/video/fbmem.c,v
retrieving revision 1.114
diff -u -p -r1.114 fbmem.c
--- drivers/video/fbmem.c	29 Nov 2004 21:39:21 -0000	1.114
+++ drivers/video/fbmem.c	23 Dec 2004 22:23:37 -0000
@@ -1173,9 +1173,10 @@ static int ofonly;
=20
 /**
  * fb_get_options - get kernel boot parameters
- * @name - framebuffer name as it would appear in
- *         the boot parameter line
- *         (video=3D<name>:<options>)
+ * @name:   framebuffer name as it would appear in
+ *          the boot parameter line
+ *          (video=3D<name>:<options>)
+ * @option: the option will be stored here
  *
  * NOTE: Needed to maintain backwards compatibility
  */
Index: fs/super.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/fs/super.c,v
retrieving revision 1.120
diff -u -p -r1.120 super.c
--- fs/super.c	20 Oct 2004 01:26:30 -0000	1.120
+++ fs/super.c	23 Dec 2004 20:30:53 -0000
@@ -141,7 +141,7 @@ int __put_super_and_need_restart(struct=20
=20
 /**
  *	put_super	-	drop a temporary reference to superblock
- *	@s: superblock in question
+ *	@sb: superblock in question
  *
  *	Drops a temporary reference, frees superblock if there's no
  *	references left.
Index: fs/jbd/journal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/fs/jbd/journal.c,v
retrieving revision 1.80
diff -u -p -r1.80 journal.c
--- fs/jbd/journal.c	11 Nov 2004 21:40:50 -0000	1.80
+++ fs/jbd/journal.c	23 Dec 2004 22:39:19 -0000
@@ -1147,6 +1147,10 @@ void journal_destroy(journal_t *journal)
=20
 /**
  *int journal_check_used_features () - Check if features specified are use=
d.
+ * @journal: Journal to check.
+ * @compat: bitmask of compatible features
+ * @ro: bitmask of features that force read-only mount
+ * @incompat: bitmask of incompatible features
  *=20
  * Check whether the journal uses all of a given set of
  * features.  Return true (non-zero) if it does.=20
@@ -1174,6 +1178,10 @@ int journal_check_used_features (journal
=20
 /**
  * int journal_check_available_features() - Check feature set in journalli=
ng layer
+ * @journal: Journal to check.
+ * @compat: bitmask of compatible features
+ * @ro: bitmask of features that force read-only mount
+ * @incompat: bitmask of incompatible features
  *=20
  * Check whether the journaling code supports the use of
  * all of a given set of features on this journal.  Return true
@@ -1206,6 +1214,10 @@ int journal_check_available_features (jo
=20
 /**
  * int journal_set_features () - Mark a given journal feature in the super=
block
+ * @journal: Journal to act on.
+ * @compat: bitmask of compatible features
+ * @ro: bitmask of features that force read-only mount
+ * @incompat: bitmask of incompatible features
  *
  * Mark a given journal feature as present on the
  * superblock.  Returns true if the requested features could be set.=20
@@ -1238,6 +1250,7 @@ int journal_set_features (journal_t *jou
=20
 /**
  * int journal_update_format () - Update on-disk journal structure.
+ * @journal: Journal to act on.
  *
  * Given an initialised but unloaded journal struct, poke about in the
  * on-disk structure to update it to the most recent supported version.
@@ -1538,6 +1551,7 @@ int journal_errno(journal_t *journal)
=20
 /**=20
  * int journal_clear_err () - clears the journal's error state
+ * @journal: journal to act on.
  *
  * An error must be cleared or Acked to take a FS out of readonly
  * mode.
@@ -1557,6 +1571,7 @@ int journal_clear_err(journal_t *journal
=20
 /**=20
  * void journal_ack_err() - Ack journal err.
+ * @journal: journal to act on.
  *
  * An error must be cleared or Acked to take a FS out of readonly
  * mode.
@@ -1578,10 +1593,6 @@ int journal_blocks_per_page(struct inode
  * Simple support for retying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies.=20
  */
-/*
- * Simple support for retying memory allocations.  Introduced to help to
- * debug different VM deadlock avoidance strategies.=20
- */
 void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry)
 {
 	return kmalloc(size, flags | (retry ? __GFP_NOFAIL : 0));
Index: fs/jbd/transaction.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/fs/jbd/transaction.c,v
retrieving revision 1.91
diff -u -p -r1.91 transaction.c
--- fs/jbd/transaction.c	8 Nov 2004 04:02:44 -0000	1.91
+++ fs/jbd/transaction.c	23 Dec 2004 22:45:36 -0000
@@ -742,6 +742,7 @@ out:
  * int journal_get_write_access() - notify intent to modify a buffer for m=
etadata (not data) update.
  * @handle: transaction to add buffer modifications to
  * @bh:     bh to be used for metadata writes
+ * @credits: variable that will receive credits for the buffer
  *
  * Returns an error code or 0 on success.
  *
@@ -1570,7 +1571,7 @@ out:
  * int journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
- * @gfp_mask: 'IO' mode for try_to_free_buffers()
+ * @unused_gfp_mask: unused
  *
  *=20
  * For all the buffers on this page,
Index: include/linux/jbd.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/include/linux/jbd.h,v
retrieving revision 1.48
diff -u -p -r1.48 jbd.h
--- include/linux/jbd.h	8 Nov 2004 04:02:44 -0000	1.48
+++ include/linux/jbd.h	23 Dec 2004 22:34:43 -0000
@@ -560,6 +560,7 @@ struct transaction_s=20
  * @j_sb_buffer: First part of superblock buffer
  * @j_superblock: Second part of superblock buffer
  * @j_format_version: Version of the superblock format
+ * @j_state_lock: Protect the various scalars in the journal
  * @j_barrier_count:  Number of processes waiting to create a barrier lock
  * @j_barrier: The barrier lock itself
  * @j_running_transaction: The current running transaction..
@@ -587,6 +588,7 @@ struct transaction_s=20
  * @j_fs_dev: Device which holds the client fs.  For internal journal this=
 will
  *     be equal to j_dev
  * @j_maxlen: Total maximum capacity of the journal region on disk.
+ * @j_list_lock: Protects the buffer lists and internal buffer state.
  * @j_inode: Optional inode where we store the journal.  If present, all j=
ournal
  *     block numbers are mapped into this inode via bmap().
  * @j_tail_sequence:  Sequence number of the oldest transaction in the log=
=20
@@ -602,8 +604,11 @@ struct transaction_s=20
  * @j_commit_interval: What is the maximum transaction lifetime before we =
begin
  *  a commit?
  * @j_commit_timer:  The timer used to wakeup the commit thread
+ * @j_revoke_lock: Protect the revoke table
  * @j_revoke: The revoke table - maintains the list of revoked blocks in t=
he
  *     current transaction.
+ * @j_revoke_table: alternate revoke tables for j_revoke
+ * @j_private: An opaque pointer to fs-private information.
  */
=20
 struct journal_s
Index: include/linux/skbuff.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/include/linux/skbuff.h=
,v
retrieving revision 1.55
diff -u -p -r1.55 skbuff.h
--- include/linux/skbuff.h	7 Oct 2004 21:45:31 -0000	1.55
+++ include/linux/skbuff.h	23 Dec 2004 20:35:21 -0000
@@ -187,6 +187,8 @@ struct skb_shared_info {
  *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
  *      @private: Data which is private to the HIPPI implementation
  *	@tc_index: Traffic control index
+ *	@tc_verd: traffic control verdict
+ *	@tc_classid: traffic control classid
  */
=20
 struct sk_buff {
Index: kernel/sysctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/kernel/sysctl.c,v
retrieving revision 1.96
diff -u -p -r1.96 sysctl.c
--- kernel/sysctl.c	2 Nov 2004 23:04:07 -0000	1.96
+++ kernel/sysctl.c	23 Dec 2004 20:30:34 -0000
@@ -1355,6 +1355,7 @@ static ssize_t proc_writesys(struct file
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes a string from/to the user buffer. If the kernel
  * buffer provided is not large enough to hold the string, the
@@ -1571,6 +1572,7 @@ static int do_proc_dointvec(ctl_table *t
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.=20
@@ -1675,6 +1677,7 @@ static int do_proc_dointvec_minmax_conv(
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.
@@ -1807,6 +1810,7 @@ static int do_proc_doulongvec_minmax(ctl
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string.
@@ -1829,6 +1833,7 @@ int proc_doulongvec_minmax(ctl_table *ta
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string. The values
@@ -1898,6 +1903,7 @@ static int do_proc_dointvec_userhz_jiffi
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.=20
@@ -1920,6 +1926,7 @@ int proc_dointvec_jiffies(ctl_table *tab
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.=20
Index: net/core/skbuff.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/martin/src/linux/linux-cvs/linux-2.5/net/core/skbuff.c,v
retrieving revision 1.39
diff -u -p -r1.39 skbuff.c
--- net/core/skbuff.c	30 Nov 2004 04:46:03 -0000	1.39
+++ net/core/skbuff.c	23 Dec 2004 21:06:22 -0000
@@ -1391,7 +1391,7 @@ static inline void skb_split_no_header(s
=20
 			if (pos < len) {
 				/* Split frag.
-				 * We have to variants in this case:
+				 * We have two variants in this case:
 				 * 1. Move all the frag to the second
 				 *    part, if it is possible. F.e.
 				 *    this approach is mandatory for TUX,
@@ -1414,6 +1414,9 @@ static inline void skb_split_no_header(s
=20
 /**
  * skb_split - Split fragmented skb to two parts at length len.
+ * @skb: the buffer to split
+ * @skb1: the buffer to receive the second part
+ * @len: new length for skb
  */
 void skb_split(struct sk_buff *skb, struct sk_buff *skb1, const u32 len)
 {


--=20
Martin Waitz

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBy1A3j/Eaxd/oD7IRAp8/AJ98oQDvV8+bJCnjrxr61lQjKot8IwCdGdd8
XVIVcqRJqukIdmzdHolRhkQ=
=PQYj
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

