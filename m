Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315252AbSD3VqB>; Tue, 30 Apr 2002 17:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSD3VqA>; Tue, 30 Apr 2002 17:46:00 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:56058 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315252AbSD3Vp7>; Tue, 30 Apr 2002 17:45:59 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 30 Apr 2002 15:44:07 -0600
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre7-ac3: ext2 compile failure
Message-ID: <20020430214407.GK3437@turbolinux.com>
Mail-Followup-To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	list linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CCE6381.7CEC4A8F@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 30, 2002  19:27 +1000, Eyal Lebedinsky wrote:
> The fourth hunk for balloc.c introduces a close brace without opening
> one:
> 
> --- linux/fs/ext2/balloc.c.orig	Tue Apr 30 19:17:01 2002
> +++ linux/fs/ext2/balloc.c	Tue Apr 30 19:17:18 2002
> @@ -518,7 +518,7 @@
>  	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
>  	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
>  	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
> -		      sb->u.ext2_sb.s_itb_per_group))
> +		      sb->u.ext2_sb.s_itb_per_group)) {
>  		ext2_error (sb, "ext2_new_block",
>  			    "Allocating block in system zone - block = %lu",
>  			    tmp);

Sorry, that was my fault.  On extracting this patch from my ext2 tree,
the surrounding lines have other changes which I thought could be safely
discarded.  I didn't see the lone brace at the end...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

