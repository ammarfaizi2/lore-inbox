Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbVKCXr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbVKCXr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbVKCXrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:47:55 -0500
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:58594 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030542AbVKCXry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:47:54 -0500
Date: Thu, 3 Nov 2005 18:47:56 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Phillip Hellewell <phillip@hellewell.homeip.net>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 6/12: eCryptfs] Superblock operations
In-Reply-To: <20051103035120.GF3005@sshock.rn.byu.edu>
Message-ID: <Pine.LNX.4.63.0511031838340.22256@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035120.GF3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Phillip Hellewell wrote:

> +static struct inode *ecryptfs_alloc_inode(struct super_block *sb) {
> +	struct ecryptfs_inode_info *ecryptfs_inode = NULL;
> +	struct inode *inode = NULL;
> +	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p]\n", sb);
> +	ecryptfs_inode = ecryptfs_kmem_cache_alloc(ecryptfs_inode_info_cache,
> +						   SLAB_KERNEL);

Most of the kernel code separates variable declarations from code.  Please 
do this with your code.

For debugging and tracing, have a look at the ocfs2 masklog code.  (It'd 
be nice to see something like that as a general kernel feature).


- James
-- 
James Morris
<jmorris@namei.org>
