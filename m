Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136526AbRD3WZl>; Mon, 30 Apr 2001 18:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136527AbRD3WZU>; Mon, 30 Apr 2001 18:25:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21509 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136526AbRD3WZI>; Mon, 30 Apr 2001 18:25:08 -0400
Subject: Re: [patch] linux likes to kill bad inodes
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 30 Apr 2001 23:28:41 +0100 (BST)
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org (kernel list),
        torvalds@transmeta.com
In-Reply-To: <20010422141042.A1354@bug.ucw.cz> from "Pavel Machek" at Apr 22, 2001 02:10:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uM9r-0000Wn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  {
> -	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode)
> +	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode && !is_bad_inode(inode))
>  		inode->i_sb->s_op->write_inode(inode, sync);
>  }

Any reason a bad inode can't have its i_sb changed to a bad_inode_fs ?
