Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVAZXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVAZXrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVAZXrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:47:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:19918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVAZTYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:24:49 -0500
Date: Wed, 26 Jan 2005 11:24:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: herbert@13thfloor.at, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jack@suse.cz
Subject: Re: 2.6.11-rc2/ext3 quota allocation bug on error path ...
Message-Id: <20050126112430.2daf812d.akpm@osdl.org>
In-Reply-To: <1106764346.13004.232.camel@winden.suse.de>
References: <20050122155044.GA4573@mail.13thfloor.at>
	<1106764346.13004.232.camel@winden.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
>
> > +cleanup_dquot:
>  > +	DQUOT_FREE_BLOCK(inode, 1);
>  > +	goto cleanup;
>  > +
>  >  bad_block:
>  >  	ext3_error(inode->i_sb, __FUNCTION__,
>  >  		   "inode %ld: bad block %d", inode->i_ino,
> 
>  looks good. Can this please be added?

Yup.  But nobody has sent the equivalent ext2 fix yet?


