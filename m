Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVJXHtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVJXHtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVJXHtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:49:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbVJXHty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:49:54 -0400
Date: Mon, 24 Oct 2005 00:48:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset bitmap and mask remap operators
Message-Id: <20051024004833.50d9676b.akpm@osdl.org>
In-Reply-To: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  +#define node_remap(oldbit, old, new) \
>  +		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
>  +static inline int __node_remap(int oldbit,
>  +		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
>  +{
>  +	return bitmap_bitremap(oldbit, oldp->bits, newp->bits, nbits);
>  +}

What's the reason for the wrapper macro?

+EXPORT_SYMBOL(bitmap_bitremap);

Is that deliberately not EXPORT_SYMBOL_GPL?
