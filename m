Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265657AbTFNJHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 05:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbTFNJHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 05:07:12 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:63182 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265657AbTFNJHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 05:07:11 -0400
Date: Sat, 14 Jun 2003 02:21:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EFS breakage in 2.5
Message-Id: <20030614022108.6b9d0e8b.akpm@digeo.com>
In-Reply-To: <20030614091014.GA18188@suse.de>
References: <20030614091014.GA18188@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2003 09:20:59.0914 (UTC) FILETIME=[44C986A0:01C33256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> Current bk oopses during initialisation of EFS.

diff -puN fs/efs/super.c~efs-typo-fix fs/efs/super.c
--- 25/fs/efs/super.c~efs-typo-fix	2003-06-14 02:20:27.000000000 -0700
+++ 25-akpm/fs/efs/super.c	2003-06-14 02:20:42.000000000 -0700
@@ -58,7 +58,7 @@ static int init_inodecache(void)
 {
 	efs_inode_cachep = kmem_cache_create("efs_inode_cache",
 					     sizeof(struct efs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (efs_inode_cachep == NULL)
 		return -ENOMEM;

_

