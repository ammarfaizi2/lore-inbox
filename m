Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUA3EBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUA3EBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:01:47 -0500
Received: from dp.samba.org ([66.70.73.150]:61116 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266553AbUA3EBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:01:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rik van Riel <riel@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: David Woodhouse <dwmw2@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] some more fixes for inode.c 
In-reply-to: Your message of "Tue, 20 Jan 2004 08:06:32 CDT."
             <Pine.LNX.4.44.0401200803150.15071-100000@chimarrao.boston.redhat.com> 
Date: Fri, 30 Jan 2004 14:55:12 +1100
Message-Id: <20040130040158.63DA42C107@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401200803150.15071-100000@chimarrao.boston.redhat.com> you write:
>  	}
>  	list_for_each(act_head, &inode_unused) {
> +		inode = list_entry(act_head, struct inode, i_list);
> +		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
> +			remove_inode_dquot_ref(inode, type, &tofree_head);
> +	}
> +	list_for_each(act_head, &inode_unused_pagecache) {
>  		inode = list_entry(act_head, struct inode, i_list);

list_for_each_entry() perhaps?

It's in 2.4, as well.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
