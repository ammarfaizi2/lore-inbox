Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286198AbRL0D2e>; Wed, 26 Dec 2001 22:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286197AbRL0D2Z>; Wed, 26 Dec 2001 22:28:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11653 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S286196AbRL0D2K>;
	Wed, 26 Dec 2001 22:28:10 -0500
Date: Wed, 26 Dec 2001 22:28:09 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20011226222809.A8233@havoc.gtf.org>
In-Reply-To: <E16JR71-0000cU-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16JR71-0000cU-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Dec 27, 2001 at 04:21:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 04:21:42AM +0100, Daniel Phillips wrote:
> --- ../2.4.17.clean/include/linux/fs.h	Fri Dec 21 12:42:03 2001
> +++ ./include/linux/fs.h	Wed Dec 26 23:30:55 2001
> @@ -478,7 +478,7 @@
>  	__u32			i_generation;
>  	union {
>  		struct minix_inode_info		minix_i;
> -		struct ext2_inode_info		ext2_i;
> +		struct ext2_inode_info		ext2_inode_info;
>  		struct ext3_inode_info		ext3_i;
>  		struct hpfs_inode_info		hpfs_i;
>  		struct ntfs_inode_info		ntfs_i;

Change in principle looks good except IMHO you should go ahead and
remove the ext2 stuff from the union...  (with the additional changes
that implies)

	Jeff


