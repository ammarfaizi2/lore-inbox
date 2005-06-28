Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVF1XsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVF1XsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVF1XqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:46:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262242AbVF1Xa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:30:59 -0400
Date: Tue, 28 Jun 2005 16:31:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Message-Id: <20050628163114.6594e1e1.akpm@osdl.org>
In-Reply-To: <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
	<iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> This patch addresses the following minor issues:
> 
>   - Typo in printk
>   - Redundant casts
>   - Use C99 struct initializers instead of memset
>   - Parenthesis around return value
>   - Use inline instead of __inline__

That struct initialisation:

> +	*infp = (struct vxfs_sb_info) {
> +		.vsi_raw = rsbp,
> +		.vsi_bp = bp,
> +		.vsi_oltext = rsbp->vs_oltext[0],
> +		.vsi_oltsize = rsbp->vs_oltsize,
> +	};
>  

Is a bit unconventional, but it doesn't alter the size of the .o file, so
whatever.

