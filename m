Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWCTVJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWCTVJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWCTVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:09:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13531 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030459AbWCTVJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:09:37 -0500
Date: Mon, 20 Mar 2006 22:09:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-xfs@oss.sgi.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Parenthesize macros in xfs
Message-ID: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello xfs list,


while browsing through the xfs/linux source, I noticed that many macros do 
not do proper bracing. I have started to cook up a patch, but would like 
feedback first before I continue for nothing.
It goes like this:

diff --fast -dpru linux-2.6.16~/fs/xfs/xfs_acl.h linux-2.6.16/fs/xfs/xfs_acl.h
--- linux-2.6.16~/fs/xfs/xfs_acl.h      2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16/fs/xfs/xfs_acl.h       2006-03-20 21:23:02.235418000 +0100
@@ -55,7 +55,7 @@ struct xfs_inode;

 extern struct kmem_zone *xfs_acl_zone;
 #define xfs_acl_zone_init(zone, name)  \
-               (zone) = kmem_zone_init(sizeof(xfs_acl_t), name)
+               (zone) = kmem_zone_init(sizeof(xfs_acl_t), (name))
 #define xfs_acl_zone_destroy(zone)     kmem_cache_destroy(zone)

 extern int xfs_acl_inherit(struct vnode *, struct vattr *, xfs_acl_t *);



Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
