Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287404AbSACQbj>; Thu, 3 Jan 2002 11:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287401AbSACQba>; Thu, 3 Jan 2002 11:31:30 -0500
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:2318 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287388AbSACQbM>;
	Thu, 3 Jan 2002 11:31:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ion Badulescu <ion@cs.columbia.edu>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Thu, 3 Jan 2002 17:34:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com>
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MAp4-00018b-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 05:05 pm, Ion Badulescu wrote:
> Daniel Phillips wrote:
> 
> > +static struct file_system_type ext2_fs = {
> > +       owner:          THIS_MODULE,
> > +       fs_flags:       FS_REQUIRES_DEV,
> > +       name:           "ext2",
> > +       read_super:     ext2_read_super,
> > +       super_size:     sizeof(struct ext2_sb_info),
> > +       inode_size:     sizeof(struct ext2_inode_info)
> > +};
> 
> While we're at it, can we extend this model to also include details about 
> the other filesystem data structures with (potential) private info, i.e.
> struct dentry and struct file? ext2 might not use them, but other 
> filesystems certainly do.

Hi,

Could you be more specific about what you mean, please?

> > -static inline struct inode * new_inode(struct super_block *sb)
> > +static inline struct inode *new_inode (struct super_block *sb)
> 
> Minor issue of coding style. I'd steer away from such gratuitious changes, 
> especially since they divert from the commonly accepted practice of having 
> no spaces between the name of the function and its arguments.

That's good advice and I'm likely to adhere to it - if you can show that 
having no spaces between the name of the function and its arguments really is 
the accepted practice.  I've seen both styles on my various travels though 
the kernel, and I prefer the one with the space.  Much as I prefer to put 
spaces around '+' (but not around '.', go figure).

In general, I allow myself the indulgence of cleaning up the odd line here 
and there to be more pleasing to my eyes, so long as it's in the vicinity of 
a substantive change and doesn't introduce a new patch hunk.  You could think 
of it as a perk that takes some of the sting out of doing the grunt work.

--
Daniel
