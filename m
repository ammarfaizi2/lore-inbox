Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287358AbSACQFh>; Thu, 3 Jan 2002 11:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287371AbSACQFT>; Thu, 3 Jan 2002 11:05:19 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:9229 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S287361AbSACQFN>; Thu, 3 Jan 2002 11:05:13 -0500
Date: Thu, 3 Jan 2002 11:05:07 -0500
Message-Id: <200201031605.g03G57e22947@guppy.limebrokerage.com>
From: Ion Badulescu <ion@cs.columbia.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
In-Reply-To: <E16M7Gz-00015E-00@starship.berlin>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 3 Jan 2002 13:47:01 +0100, Daniel Phillips <phillips@bonn-fries.net> wrote:

> +static struct file_system_type ext2_fs = {
> +       owner:          THIS_MODULE,
> +       fs_flags:       FS_REQUIRES_DEV,
> +       name:           "ext2",
> +       read_super:     ext2_read_super,
> +       super_size:     sizeof(struct ext2_sb_info),
> +       inode_size:     sizeof(struct ext2_inode_info)
> +};

While we're at it, can we extend this model to also include details about 
the other filesystem data structures with (potential) private info, i.e.
struct dentry and struct file? ext2 might not use them, but other 
filesystems certainly do.

> -static inline struct inode * new_inode(struct super_block *sb)
> +static inline struct inode *new_inode (struct super_block *sb)

Minor issue of coding style. I'd steer away from such gratuitious changes, 
especially since they divert from the commonly accepted practice of having 
no spaces between the name of the function and its arguments.

Thanks,
-Ion
[FiST co-maintainer]
