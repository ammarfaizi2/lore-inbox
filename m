Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319262AbSHNWSZ>; Wed, 14 Aug 2002 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319284AbSHNWSY>; Wed, 14 Aug 2002 18:18:24 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:59891 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319262AbSHNWSV>; Wed, 14 Aug 2002 18:18:21 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 14 Aug 2002 16:20:23 -0600
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: of dentries and inodes
Message-ID: <20020814222023.GN9642@clusterfs.com>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	linux-kernel@vger.kernel.org
References: <3D5A7896.7020407@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5A7896.7020407@inet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 14, 2002  10:34 -0500, Eli Carter wrote:
> (I'm looking at a 2.2 kernel, but I doubt this has changed.) In ext2, as 
> well as many other fs's, there appears a line much like this in their 
> 'struct file_system_type.read_super()' function:
> 
> sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO), NULL);
> 
> Now, I was under the impression that for each iget(), you need to have 
> an iput() when you're done with the inode... which in this case would 
> mean an iput() in 'struct super_operations.put_super()'... but I don't 
> see one there.

The dput(root) is done in fs/super.c (kill_super in 2.4).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

