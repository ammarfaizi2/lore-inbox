Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVF0Ftz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVF0Ftz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVF0Ftz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:49:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8850 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261831AbVF0Fts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:49:48 -0400
Date: Mon, 27 Jun 2005 11:21:50 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: [PATCH][TRIVIAL] Allocate kprobe_table at runtime
Message-ID: <20050627055150.GA10659@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050626183049.GA22898@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626183049.GA22898@optonline.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

On Sun, Jun 26, 2005 at 06:37:29PM +0000, Jeff Sipek wrote:
> Allocates kprobe_table at runtime.
> -	/* FIXME allocate the probe table, currently defined statically */
> +	kprobe_table = kmalloc(sizeof(struct hlist_head)*KPROBE_TABLE_SIZE, GFP_ATOMIC);

Memory allocation using GFP_KERNEL has more chances of success as compared to
GFP_ATOMIC. Why can't we use GFP_KERNEL here?

Thanks
Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
