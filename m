Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWHNRwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWHNRwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWHNRwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:52:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44444 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932581AbWHNRws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:52:48 -0400
Message-ID: <44E0B86A.6020805@garzik.org>
Date: Mon, 14 Aug 2006 13:52:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: cmm@us.ibm.com, "Darrick J. Wong" <djwong@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain>	<20060809233940.50162afb.akpm@osdl.org>	<m37j1hlyzv.fsf@bzzz.home.net>	<20060811135737.1abfa0f6.rdunlap@xenotime.net>	<20060811160002.b2afbec3.akpm@osdl.org>	<20060811230239.c89394b0.rdunlap@xenotime.net>	<44DE1328.5080101@us.ibm.com>	<20060812112014.d1b4691a.rdunlap@xenotime.net>	<1155572792.3961.2.camel@localhost.localdomain> <20060814102212.3af5fd2a.rdunlap@xenotime.net>
In-Reply-To: <20060814102212.3af5fd2a.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> @@ -2683,9 +2683,9 @@ static int ext4_get_sb(struct file_syste
>  	return get_sb_bdev(fs_type, flags, dev_name, data, ext4_fill_super, mnt);
>  }
>  
> -static struct file_system_type ext3dev_fs_type = {
> +static struct file_system_type ext4dev_fs_type = {
>  	.owner		= THIS_MODULE,
> -	.name		= "ext3dev",
> +	.name		= "ext4dev",
>  	.get_sb		= ext4_get_sb,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> @@ -2699,7 +2699,7 @@ static int __init init_ext4_fs(void)
>  	err = init_inodecache();
>  	if (err)
>  		goto out1;
> -        err = register_filesystem(&ext3dev_fs_type);
> +        err = register_filesystem(&ext4dev_fs_type);
>  	if (err)
>  		goto out;
>  	return 0;
> @@ -2712,7 +2712,7 @@ out1:
>  
>  static void __exit exit_ext4_fs(void)
>  {
> -	unregister_filesystem(&ext3dev_fs_type);
> +	unregister_filesystem(&ext4dev_fs_type);
>  	destroy_inodecache();
>  	exit_ext4_xattr();


IMO these non-CONFIG bits should just be ext4_

	Jeff


