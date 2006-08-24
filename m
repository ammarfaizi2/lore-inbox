Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWHXQ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWHXQ7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWHXQ7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:59:30 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:62396 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751631AbWHXQ73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:59:29 -0400
Date: Fri, 25 Aug 2006 01:23:40 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 5/6] BC: kernel memory accounting (core)
Message-ID: <20060824212340.GA952@oleg>
References: <44EC31FB.2050002@sw.ru> <44EC36D3.9030108@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC36D3.9030108@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23, Kirill Korotaev wrote:
>
> +int bc_slab_charge(kmem_cache_t *cachep, void *objp, gfp_t flags)
> +{
> +	unsigned int size;
> +	struct beancounter *bc, **slab_bcp;
> +
> +	bc = get_exec_bc();
> +	if (bc == NULL)
> +		return 0;

Is it possible to .exec_bc == NULL ?

If yes, why do we need init_bc? We can do 'set_exec_bc(NULL)' in __do_IRQ()
instead.

Oleg.

