Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965601AbVKGXbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965601AbVKGXbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965602AbVKGXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:31:36 -0500
Received: from holomorphy.com ([66.93.40.71]:24290 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S965601AbVKGXbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:31:35 -0500
Date: Mon, 7 Nov 2005 15:30:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, hugh@veritas.com,
       rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       akpm@osdl.org
Subject: Re: [RFC 1/2] Hugetlb fault fixes and reorg
Message-ID: <20051107233053.GG29402@holomorphy.com>
References: <1131397841.25133.90.camel@localhost.localdomain> <1131399496.25133.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131399496.25133.103.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:38:16PM -0600, Adam Litke wrote:
> (Patch originally from David Gibson <david@gibson.dropbear.id.au>)
> Initial Post: Tue. 25 Oct 2005
> -static struct page *find_lock_huge_page(struct address_space *mapping,
> -			unsigned long idx)
> +static struct page *find_or_alloc_huge_page(struct address_space *mapping,
> +					    unsigned long idx)
>  {
>  	struct page *page;
>  	int err;
> -	struct inode *inode = mapping->host;
> -	unsigned long size;

This patch is a combination of function renaming, variable
initialization/assignment and return path/etc. oddities, plus some
functional changes (did I catch them all?) which apparently took a bit
of effort to get to after sifting through the rest of that.

Dump the parallel cleanups or split them into pure cleanup and pure
functional patches. I don't mind the cleanups, I mind the mixing.


-- wli
