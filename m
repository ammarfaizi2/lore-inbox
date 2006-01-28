Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWA1KIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWA1KIP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 05:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWA1KIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 05:08:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:46732 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932115AbWA1KIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 05:08:14 -0500
Subject: Re: [patch 2/6] Create and Use common mempool allocators
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1138407582.26088.2.camel@localhost.localdomain>
References: <20060128001539.030809000@localhost.localdomain>
	 <1138407582.26088.2.camel@localhost.localdomain>
Date: Sat, 28 Jan 2006 12:08:12 +0200
Message-Id: <1138442892.8657.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-01-27 at 16:19 -0800, Matthew Dobson wrote:
> -	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_page,
> -				       mempool_free_page, NULL);
> +	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_pages,
> +				       mempool_free_pages, 0);

You need to cast that zero to a void pointer to avoid compliation
warning (found in various other places as well). Would probably make
sense to implement helper functions so the casting doesn't spread all
over the place. Other than that, looks good to me.

			Pekka

