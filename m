Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWFSTJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWFSTJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWFSTJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:09:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7912 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751083AbWFSTJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:09:23 -0400
Date: Mon, 19 Jun 2006 20:09:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Message-ID: <20060619190921.GA16959@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org,
	linux390@de.ibm.com
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.418349000@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619153108.418349000@candygram.thunk.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: linux-2.6.17/arch/s390/kernel/debug.c
> ===================================================================
> --- linux-2.6.17.orig/arch/s390/kernel/debug.c	2006-06-18 18:58:51.000000000 -0400
> +++ linux-2.6.17/arch/s390/kernel/debug.c	2006-06-18 18:58:55.000000000 -0400
> @@ -604,7 +604,7 @@
>  	debug_info_t *debug_info, *debug_info_snapshot;
>  
>  	down(&debug_lock);
> -	debug_info = (struct debug_info*)file->f_dentry->d_inode->u.generic_ip;
> +	debug_info = (struct debug_info*)file->f_dentry->d_inode->i_private;

is this actually okay?  who owns the private data in debugfs inodes?

