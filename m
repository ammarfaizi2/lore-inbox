Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSAGXvS>; Mon, 7 Jan 2002 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287432AbSAGXvM>; Mon, 7 Jan 2002 18:51:12 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:13044 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287427AbSAGXu6>;
	Mon, 7 Jan 2002 18:50:58 -0500
Date: Mon, 7 Jan 2002 16:49:21 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 7/7 v2] Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Message-ID: <20020107164921.J777@lynx.no>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.21.0201071401450.6842-100000@weyl.math.psu.edu> <3C3A2F0E.4A132214@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3A2F0E.4A132214@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jan 07, 2002 at 06:28:14PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2002  18:28 -0500, Jeff Garzik wrote:
> --- linux-fs6/fs/ext2/ext2_fs_i.h	Mon Sep 17 20:16:30 2001
> +++ linux-fs7/fs/ext2/ext2_fs_i.h	Mon Jan  7 05:08:38 2002
> @@ -36,6 +36,10 @@
>  	__u32	i_prealloc_count;
>  	__u32	i_dir_start_lookup;
>  	int	i_new_inode:1;	/* Is a freshly allocated inode */
> +
> +#ifdef __KERNEL__
> +	struct inode i_inode_data;
> +#endif
>  };

Since ext2_fs_i.h only describes the in-memory data for ext2 inodes, there
is no reason to #ifdef __KERNEL__ any changes therein.  I have seen several
other people worry about changes to this file in the past also, and I was
going to suggest adding a comment to the file, but I see it already says
"inode data in memory" so I don't know what else to add...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

