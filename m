Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUC2Wzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUC2Wzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:55:49 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52378
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263188AbUC2Wyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:54:36 -0500
Date: Tue, 30 Mar 2004 00:54:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040329225435.GN3808@dualathlon.random>
References: <20040329124027.36335d93.akpm@osdl.org> <Pine.LNX.4.44.0403292312170.19944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403292312170.19944-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 11:24:58PM +0100, Hugh Dickins wrote:
> On Mon, 29 Mar 2004, Andrew Morton wrote:
> > 
> > hmm, yes, we have pages which satisfy PageSwapCache(), but which are not
> > actually in swapcache.
> > 
> > How about we use the normal pagecache APIs for this?
> > 
> > +	add_to_page_cache(page, &swapper_space, entry.val, GFP_NOIO);
> >...  
> > +	remove_from_page_cache(page);
> 
> Much nicer, and it'll probably appear to work: but (also untested)
> I bet you'll need an additional page_cache_release(page) - damn,

I'll add the page_cache_release before testing ;)
