Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVD0Mds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVD0Mds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVD0Mds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:33:48 -0400
Received: from coderock.org ([193.77.147.115]:7873 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261531AbVD0Mdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:33:46 -0400
Date: Wed, 27 Apr 2005 14:33:40 +0200
From: Domen Puncer <domen@coderock.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050427123340.GB18533@nd47.coderock.org>
References: <20050425165826.GB11938@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425165826.GB11938@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I noticed (besides some trailing whitespace):

On 26/04/05 00:58 +0800, David Teigland wrote:
> +		if (!r->res_lvbptr)
> +			r->res_lvbptr = allocate_lvb(r->res_ls);
> +
> +		if (!r->res_lvbptr)
> +			return;

This suggests allocate_lvb can fail.

> +
> +		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, DLM_LVB_LEN);

...
However...
> +
> +	if (!r->res_lvbptr)
> +		r->res_lvbptr = allocate_lvb(r->res_ls);
> +
> +	memcpy(r->res_lvbptr, lkb->lkb_lvbptr, DLM_LVB_LEN);

So... can it fail?


	Domen
