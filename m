Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbUKKLPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUKKLPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUKKLOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:14:06 -0500
Received: from [195.135.223.242] ([195.135.223.242]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262210AbUKKLLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:11:39 -0500
Date: Thu, 11 Nov 2004 00:42:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: andyliu <liudeyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]a tar filesystem for 2.6.10-rc1-mm3
Message-ID: <20041110234203.GE1099@elf.ucw.cz>
References: <aad1205e04110523176bf66a37@mail.gmail.com> <aad1205e04110621472123bf67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad1205e04110621472123bf67@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   let's think about the way we access the file which contained in a tar file
> may we can untar the whole thing and we find the file we want to access
> or we can use the t option with tar to list all the files in the tar
> and then untar
> the only one file we want to access.
> 
>   but with the help of the tarfs,we can mount a tar file to some dir and access
> it easily and quickly.it's like the tarfs in mc.
> 
>  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> then access the files easily.
> 
> it was writen by Kazuto Miyoshi (kaz@earth.email.ne.jp) Hirokazu
> Takahashi (h-takaha@mub.biglobe.ne.jp) for linux 2.4.0
> 
> and i make it work for linux 2.6.0. now a patch for linux
> 2.6.10-rc1-mm3

Hmm, at least it needs to be indented by tab, see
Documentation/CodingStyle. If it could do compressed tars... well I
could find a use for _that_...
									Pavel

> +static int tarfs_readdir(struct file * filp,
> +                        void * dirent, filldir_t filldir)
> +{
> +  struct inode *inode = filp->f_dentry->d_inode;
> +  int err;
> +  struct tarent *dir_tarent, *ent;
> +  int dtype=0;
> +  int count, stored;
> +
> +  dir_tarent = TARENT(inode);
> +
> +  message("tarfs: tarfs_readdir (dir_tarent %p, f_pos %ld)\n",
> +         dir_tarent, (long)filp->f_pos);
> +

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
