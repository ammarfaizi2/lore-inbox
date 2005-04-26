Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVDZQyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVDZQyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDZQyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:54:32 -0400
Received: from mail.dif.dk ([193.138.115.101]:13499 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261657AbVDZQyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:54:17 -0400
Date: Tue, 26 Apr 2005 18:57:32 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Addison <addy@quadrics.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
In-Reply-To: <426E62ED.5090803@quadrics.com>
Message-ID: <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost>
References: <426E62ED.5090803@quadrics.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, David Addison wrote:

> Hi,
> here is a patch we use to integrate the Quadrics NICs into the Linux kernel.
<snip>

A few small comments below.


> 
> +static inline void
> +ioproc_release(struct mm_struct *mm)
> +{

Return types on same line as function name makes grep'ing a lot 
easier/nicer.

Here's the example from Documentation/CodingStyle : 

        int function(int x)
        {
                body of function
        }

<snip>
> +/* ! CONFIG_IOPROC so make all hooks empty */
> +
> +#define ioproc_release(mm)			do { } while (0)
> +
> +#define ioproc_sync_range(vma, start, end)	do { } while (0)
> +
> +#define ioproc_invalidate_range(vma, start,end)	do { } while (0)
> +
> +#define ioproc_update_range(vma, start, end)	do { } while (0)
> +
> +#define ioproc_change_protection(vma, start, end, prot)	do { } while (0)
> +
> +#define ioproc_sync_page(vma, addr)		do { } while (0)
> +
> +#define ioproc_invalidate_page(vma, addr)	do { } while (0)
> +
> +#define ioproc_update_page(vma, addr)		do { } while (0)
> +
Why all these blank lines between each define? Seems like just a waste of 
screen space to me.


-- 
Jesper Juhl

