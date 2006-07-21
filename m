Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWGUOh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWGUOh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWGUOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 10:37:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:29839 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWGUOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 10:37:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Im3gD+kWDKDFLg3JOfwltUd9rYW/nSyavofFBvwz2vFyCRzdX+jr2wGl27eC2bN4R7lFk4dZC+bqtvoR6Vzbrjp5nayDqq16k/VeJCeQiDWXNmBdzXwzK4cFsDUQZMaCFS1pnHy/hmnHPXJZdvlApy7COxBBsuoFoyFqOVCDPg0=
Date: Fri, 21 Jul 2006 16:37:23 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: takis@issaris.org
Cc: linux-kernel@vger.kernel.org, rathamahata@php4.ru, sfrench@samba.org,
       jffs-dev@axis.com, shaggy@austin.ibm.com, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com, raven@themaw.net
Subject: Re: [PATCH] fs: Memory allocation cleanups
Message-ID: <20060721143723.GB2772@slug>
References: <20060721115055.GA12329@issaris.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060721115055.GA12329@issaris.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 01:50:55PM +0200, takis@issaris.org wrote:
> -		dnotify_req = (struct dir_notify_req *) kmalloc(
> -						sizeof(struct dir_notify_req),
> +		dnotify_req = kmalloc(sizeof(struct dir_notify_req),
>  						 GFP_KERNEL);
						^^^^^ 
Should be aligned with the kmalloc?
> -	ext_acl = (reiserfs_acl_header *) kmalloc(sizeof(reiserfs_acl_header) +
> -						  acl->a_count *
> +	ext_acl = kmalloc(sizeof(reiserfs_acl_header) + acl->a_count *
>  						  sizeof(reiserfs_acl_entry),
>  						  GFP_NOFS);
						^^^^^
This should be aligned too, I think.

Regards,
Frederik
