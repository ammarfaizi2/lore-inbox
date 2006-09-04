Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWIDHuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWIDHuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWIDHuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:50:55 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:47528 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932472AbWIDHuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:50:54 -0400
Date: Mon, 4 Sep 2006 09:46:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 18/22][RFC] Unionfs: Superblock operations
In-Reply-To: <20060901015851.GS5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040940010.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015851.GS5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* final actions when unmounting a file system */
>+static void unionfs_put_super(struct super_block *sb)
>+{
>+	int bindex, bstart, bend;
>+	struct unionfs_sb_info *spd;
>+
>+	if ((spd = stopd(sb))) {

Sugg.:

if((spd = stopd(sb)) == NULL)
	return;

>+static struct inode *unionfs_alloc_inode(struct super_block *sb)
>+{
>+	struct unionfs_inode_container *c;
>+
>+	c = (struct unionfs_inode_container *)
>+	    kmem_cache_alloc(unionfs_inode_cachep, SLAB_KERNEL);

Nocast.

>+static void init_once(void *v, kmem_cache_t * cachep, unsigned long flags)
>+{
>+	struct unionfs_inode_container *c = (struct unionfs_inode_container *)v;

Nocast.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
