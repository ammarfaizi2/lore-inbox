Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbUA1Pni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbUA1Pmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:42:51 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:14091 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266063AbUA1PmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:42:24 -0500
Date: Wed, 28 Jan 2004 23:41:27 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 8/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282333200.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

8-autofs4-2.6.1-vfsmount_lock.patch

Exports vfsmount_lock as it's needed by the expire rewrite.

diff -Nur linux-2.6.1/fs/namespace.c linux-2.6.1.vfsmount_lock/fs/namespace.c
--- linux-2.6.1/fs/namespace.c	2004-01-09 14:59:45.000000000 +0800
+++ linux-2.6.1.vfsmount_lock/fs/namespace.c	2004-01-28 22:10:25.000000000 +0800
@@ -28,6 +28,9 @@
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+
+EXPORT_SYMBOL(vfsmount_lock);
+
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
