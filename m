Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTKZWRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTKZWRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:17:23 -0500
Received: from dp.samba.org ([66.70.73.150]:30130 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264352AbTKZWRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:17:22 -0500
Date: Wed, 26 Nov 2003 18:25:53 +1100
From: Anton Blanchard <anton@samba.org>
To: Jack Steiner <steiner@sgi.com>
Cc: Jes Sorensen <jes@trained-monkey.org>, Alexander Viro <viro@math.psu.edu>,
       Andrew Morton <akpm@osdl.org>,
       "William Lee Irwin, III" <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031126072553.GF26811@krispykreme>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125211611.GE26811@krispykreme> <20031125231108.GA5675@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125231108.GA5675@sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That was a concern to me too. However, on IA64, all page structs are
> in the vmalloc region (it isnt allocated by vmalloc but is in the same
> region as vmalloc'ed pages. They are mapped with 16k pages instead of
> the 64MB pages used for memory allocated by kmalloc).
> 
> Before switching to 16K pages for the page structs, we made numerous
> performance measurements. As far as we could tell, there was no
> performce degradation caused by the smaller pages. It seems to me that
> if page structs are ok being mapped by 16k pages, the hash tables
> would be ok too. 

OK, on ppc64 with a 4kB base pagesize Id be more worried about using the
vmalloc region.

Anton
